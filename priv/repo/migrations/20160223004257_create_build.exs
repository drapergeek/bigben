defmodule Bigben.Repo.Migrations.CreateBuild do
  use Ecto.Migration

  def change do
    create table(:builds) do
      add :started_at, :datetime, null: false
      add :finished_at, :datetime, null: false
      add :run_time, :integer, null: false
      add :branch, :string, null: false

      timestamps
    end

  end
end
