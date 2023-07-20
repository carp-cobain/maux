defmodule Maux.EmpRepo do
  @moduledoc """
  A Maux repo for testing operations over state.
  """
  alias Algae.Maybe
  alias Maux.Repo
  use Maux.RepoState
  use Witchcraft

  # NOTE
  # When implementing Maux repos, make sure they mirror the functionality of
  # datastore-backed repos.

  @doc false
  def upsert(emp) do
    Maybe.from_nillable(emp) >>>
      fn emp ->
        Repo.upsert(emp.id, emp) |> exec() |> put_state()
        Maybe.new(emp)
      end
  end

  @doc false
  def get(id) do
    Repo.get(id)
    |> eval()
    |> Maybe.from_nillable()
  end

  @doc false
  def delete(id) do
    Repo.get(id)
    |> eval()
    |> delete_emp()
  end

  @doc false
  def delete_emp(emp) do
    Maybe.from_nillable(emp) >>>
      fn emp ->
        Repo.delete(emp.id) |> exec() |> put_state()
        Maybe.new(emp)
      end
  end

  @doc false
  def find(name) do
    Repo.find(:name, name)
    |> eval()
    |> Maybe.from_nillable()
  end

  @doc false
  def filter(amt) do
    Repo.filter(:salary, amt)
    |> eval()
    |> case do
      [] -> Maybe.new()
      emps -> Maybe.new(emps)
    end
  end
end
