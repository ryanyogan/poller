defmodule Poller.MixProject do
  use Mix.Project

  def project do
    [
      app: :poller,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Poller, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poller_dal, [path: "../poller_dal"]}
    ]
  end
end
