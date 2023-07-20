defmodule Maux.RepoTest do
  use ExUnit.Case, async: true

  alias Algae.Maybe
  alias Algae.Maybe.{Just, Nothing}
  alias Maux.{Emp, EmpRepo}

  setup do
    %{
      id: 1,
      salary: 85_000,
      jane: Emp.new(1, "Jane", 85_000),
      alice: Emp.new(2, "Alice", 95_000),
      bob: Emp.new(3, "Bob", 85_000)
    }
  end

  describe "Maux" do
    test "should support upsert", ctx do
      assert %Just{just: emp} = EmpRepo.upsert(ctx.jane)
      assert emp == ctx.jane
      assert EmpRepo.upsert(nil) == %Nothing{}
    end

    test "should support get", ctx do
      assert EmpRepo.upsert(ctx.jane)
      assert EmpRepo.get(ctx.id) == Maybe.new(ctx.jane)
      assert EmpRepo.get(nil) == %Nothing{}
    end

    test "should support delete", ctx do
      assert EmpRepo.upsert(ctx.jane)
      assert EmpRepo.delete(ctx.id) == Maybe.new(ctx.jane)
      assert EmpRepo.get(ctx.id) == %Nothing{}
    end

    test "should support find", ctx do
      assert EmpRepo.upsert(ctx.jane)
      assert EmpRepo.find(ctx.jane.name) == Maybe.new(ctx.jane)
      assert EmpRepo.find(nil) == %Nothing{}
    end

    test "should support filter", ctx do
      assert EmpRepo.upsert(ctx.jane)
      assert EmpRepo.upsert(ctx.alice)
      assert EmpRepo.upsert(ctx.bob)
      assert %Just{just: emps} = EmpRepo.filter(ctx.salary)
      assert ctx.bob in emps && ctx.jane in emps && ctx.alice not in emps
      assert EmpRepo.filter(nil) == %Nothing{}
    end
  end
end
