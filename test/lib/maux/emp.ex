defmodule Maux.Emp do
  @moduledoc """
  An employee struct for testing maux db state operations.
  """
  import Algae

  defdata do
    id :: pos_integer()
    name :: String.t()
    salary :: pos_integer()
  end
end
