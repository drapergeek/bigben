defmodule Bigben.Branch do
  use Bigben.Web, :model

  schema "branches" do
    field :name, :string
    has_many :builds, Bigben.Build

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
