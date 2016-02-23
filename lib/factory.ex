defmodule Bigben.Factory do
  use ExMachina.Ecto, repo: Bigben.Repo

  def factory(:build) do
    %Bigben.Build{
      branch: "some content",
      finished_at: "2016-02-23T01:20:00Z",
      started_at: "2016-02-23T01:20:00Z",
    }
  end
end
