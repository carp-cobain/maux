defmodule Maux.MixProject do
  use Mix.Project

  def project do
    [
      app: :maux,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      test_coverage: [
        summary: [
          threshold: 100
        ],
        ignore_modules: [
          Maux.Emp,
          Maux.EmpRepo
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Extend path in test env
  defp elixirc_paths(:test), do: ["lib", "test/lib"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:algae, "~> 1.3.1"},
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false}
    ]
  end
end
