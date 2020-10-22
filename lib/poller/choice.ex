defmodule Poller.Choice do
  defstruct id: nil,
            description: nil,
            party: nil

  def new(id, description, party) do
    __struct__(
      id: id,
      description: description,
      party: party
    )
  end
end
