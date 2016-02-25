defmodule Bigben.Repo.Migrations.AddTotalTime do
  use Ecto.Migration

  def change do
    alter table(:builds) do
      add :total_time, :integer
    end
  end
end
