# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Birdle.Repo.insert!(%Birdle.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Birdle.Accounts

Accounts.register_user(%{
  email: "nicole@hiivemarkets.com",
  password: "12345656789012"
})

Accounts.register_user(%{
  email: "grant@hiivemarkets.com",
  password: "12345656789012"
})

Accounts.register_user(%{
  email: "aydan@hiivemarkets.com",
  password: "12345656789012"
})
