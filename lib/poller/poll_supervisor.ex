defmodule Poller.PollSupervisor do
  use DynamicSupervisor
  alias Poller.PollServer

  @name __MODULE__

  def start_link(args) do
    DynamicSupervisor.start_link(@name, args, name: @name)
  end

  @spec start_poll(any) :: :ignore | {:error, any} | {:ok, pid} | {:ok, pid, any}
  def start_poll(district_id) do
    spec = {PollServer, district_id}
    DynamicSupervisor.start_child(@name, spec)
  end

  # Callbacks

  def init(_args), do: DynamicSupervisor.init(strategy: :one_for_one)
end
