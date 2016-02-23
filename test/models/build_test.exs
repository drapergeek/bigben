defmodule Bigben.BuildTest do
  use Bigben.ModelCase
  alias Bigben.Build
  import Bigben.Factory

  test "changeset with valid attributes" do
    changeset = Build.changeset(%Build{}, fields_for(:build))
    assert changeset.valid?
  end

  test "changeset will calculate and set the run time" do
    attributes = %{
      started_at: "2016-02-23T01:20:00Z",
      finished_at: "2016-02-23T01:21:00Z",
    }
    changeset = Build.changeset(%Build{}, fields_for(:build, attributes))
    assert changeset.changes.run_time == 60
  end

  test "changeset with invalid attributes" do
    changeset = Build.changeset(%Build{}, %{})
    refute changeset.valid?
  end
end
