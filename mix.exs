defmodule Poller.MixProject do
  use Mix.Project

  def project do
    [
      app: :poller,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Poller, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poller_dal, path: "../poller_dal"}
    ]
  end
end
