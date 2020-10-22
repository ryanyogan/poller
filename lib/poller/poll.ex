defmodule Poller.Poll do
  defstruct district_id: nil,
            questions: [],
            votes: %{}

  def new(district_id) do
    __struct__(district_id: district_id)
  end
end
