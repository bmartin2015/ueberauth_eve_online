defmodule UeberauthEveOnline.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/bmartin2015/ueberauth_eve_online.git"

  def project do
    [
      app: :ueberauth_eve_online,
      version: @version,
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: @url,
      homepage_url: @url
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    "An Ueberauth strategy for Eve Online SSO authentication"
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Benjamin Martin"],
      licenses: ["MIT"],
      links: %{Github: @url}
    ]
  end
end
