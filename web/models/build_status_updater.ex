defmodule Bigben.BuildStatusUpdater do
  alias Bigben.Branch
  alias Bigben.Build
  alias Bigben.Repo

  def update(build_params) do
    branch = get_or_create_branch(build_params)
    updated_params = build_params
      |> Map.delete(:branch)
      |> Map.put("branch_id", branch.id)

    Build.changeset(%Build{}, updated_params)
    |> Repo.insert!
  end

  def get_or_create_branch(%{"branch" => branch}) do
    Repo.get_by(Branch, name: branch) || create_branch(branch)
  end

  defp create_branch(name) do
    Branch.changeset(%Branch{}, %{name: name})
    |> Repo.insert!
  end
end
