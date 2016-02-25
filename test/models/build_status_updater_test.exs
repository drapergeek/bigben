defmodule Bigben.BuildStatusUpdaterTest do
  use Bigben.ModelCase

  alias Bigben.Branch
  alias Bigben.Repo
  alias Bigben.BuildStatusUpdater

  import Bigben.Factory

  test "get_or_create_branch creates a new branch when there is not one" do
    branch = BuildStatusUpdater.get_or_create_branch(%{"branch" => "master"})

    assert branch.name == "master"
  end

  test "get_branch finds existing by the same name" do
    existing_branch = create(:branch, name: "master")

    found_branch = BuildStatusUpdater.get_or_create_branch(%{"branch" => existing_branch.name})

    assert found_branch.id == existing_branch.id
    assert Repo.one(from(b in Branch, select: count(b.id))) == 1
  end
end
