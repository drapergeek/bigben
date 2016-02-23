defmodule Bigben.Build do
  use Bigben.Web, :model

  schema "builds" do
    field :started_at, Timex.Ecto.DateTime
    field :finished_at, Timex.Ecto.DateTime
    field :run_time, :integer
    field :branch, :string

    timestamps
  end

  @required_fields ~w(started_at finished_at branch)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
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
