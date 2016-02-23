ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Bigben.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Bigben.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Bigben.Repo)

