defmodule Bigben.BuildStatusUpdater do
  alias Bigben.Branch
  alias Bigben.Build
  alias Bigben.Repo

  def update(build_params) do
    branch = get_or_create_branch(build_params)
    updated_params = build_params
      |> Map.delete(:branch)
      |> Map.put("branch_id", branch.id)
      |> add_total_time

    Build.changeset(%Build{}, updated_params)
    |> Repo.insert!
  end

  def add_total_time(params) do
    total_time = Bigben.Travis.TotalTimeCalculator.calculate_total_time(params["id"])
    Map.put(params, "total_time", total_time)
  end

  def get_or_create_branch(json_params) do
    Repo.get_by(Branch, name: json_params["branch"]) || create_branch(json_params["branch"])
  end

  defp create_branch(name) do
    Branch.changeset(%Branch{}, %{name: name})
    |> Repo.insert!
  end
end
