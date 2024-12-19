defmodule Demo3.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo3.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> Demo3.Accounts.create_user()

    user
  end
end
