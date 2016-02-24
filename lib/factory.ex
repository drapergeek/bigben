defmodule Bigben.Factory do
  use ExMachina.Ecto, repo: Bigben.Repo

  def factory(:build) do
    %Bigben.Build{
      branch: build(:branch),
      finished_at: "2016-02-23T01:20:00Z",
      started_at: "2016-02-23T01:20:00Z",
    }
  end

  def factory(:branch) do
    %Bigben.Branch{
      name: sequence(:name, &"branch-name-#{&1}")
    }
  end
end
