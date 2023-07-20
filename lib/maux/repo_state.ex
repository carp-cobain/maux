defmodule Maux.RepoState do
  @moduledoc """
  Allow modules to hold process scoped, in-memory mock DB state.
  """
  defmacro __using__(_opts) do
    quote do
      alias Algae.State

      # Process scoped in-memory state.
      @repo_state {__MODULE__, :db}

      @doc false
      def put_state(db), do: Process.put(@repo_state, db)

      @doc false
      def get_state, do: Process.get(@repo_state) || %{}

      @doc false
      def eval(op) do
        db = get_state()
        State.evaluate(op, db)
      end

      @doc false
      def exec(op) do
        db = get_state()
        State.execute(op, db)
      end
    end
  end
end
