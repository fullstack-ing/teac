defmodule Teac.MixProject do
  use Mix.Project

  def project do
    [
      app: :teac,
      name: "teac",
      version: "0.2.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/fullstack-ing/teac",
      homepage_url: "https://github.com/fullstack-ing/teac",
      description: description(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Teac.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.5.10"},
      {:ex_doc, "~> 0.28", only: :dev, runtime: false},
      {:plug, "~> 1.14", only: :test},
      {:ecto, "~> 3.13"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    """
    An Elixir HTTP/REST and Websocket Client for the Twitch API.
    """
  end

  defp docs do
    [
      main: "readme",
      # logo: "path/to/logo.png",
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/fullstack-ing/teac"
      },
      description: "Twitch Elixir API Client"
    ]
  end
end
