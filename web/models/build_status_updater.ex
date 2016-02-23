defmodule Bigben.BuildStatusUpdater do
  alias Bigben.Build
  alias Bigben.Repo

  def update(build_params) do
    changeset = Build.changeset(%Build{}, build_params)
    Repo.insert!(changeset)
  end
end
