defmodule Bigben.BranchTest do
  use Bigben.ModelCase

  alias Bigben.Branch

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Branch.changeset(%Branch{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Branch.changeset(%Branch{}, @invalid_attrs)
    refute changeset.valid?
  end
end
