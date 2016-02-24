defmodule Bigben.Repo.Migrations.CreateBranch do
  use Ecto.Migration

  def change do
    create table(:branches) do
      add :name, :string, null: false

      timestamps
    end

    alter table(:builds) do
      add :branch_id, references(:branches), null: false
      remove :branch
    end
  end
end
