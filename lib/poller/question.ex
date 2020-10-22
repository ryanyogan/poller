defmodule Poller.Question do
  defstruct id: nil,
            description: nil,
            choices: []

  def new(id, description) do
    __struct__(
      id: id,
      description: description
    )
  end
end
