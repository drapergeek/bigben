defmodule Bigben.Build do
  use Bigben.Web, :model

  schema "builds" do
    field :started_at, Timex.Ecto.DateTime
    field :finished_at, Timex.Ecto.DateTime
    field :run_time, :integer

    belongs_to :branch, Bigben.Branch

    timestamps
  end

  @required_fields ~w(started_at finished_at)
  @optional_fields ~w(branch_id)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> set_run_time
  end

  defp set_run_time(changeset) do
    if changeset.valid? do
      run_time = Timex.Date.diff(
        changeset.changes.started_at,
        changeset.changes.finished_at,
        :secs
      )
      put_change changeset, :run_time, run_time
    else
      changeset
    end
  end
end
