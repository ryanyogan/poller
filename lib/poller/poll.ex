defmodule Poller.Poll do
  defstruct district_id: nil,
            questions: [],
            votes: %{}

  def new(district_id) do
    __struct__(district_id: district_id)
  end

  def add_question(poll, question) do
    questions = [question | poll.questions]

    votes = init_votes(poll.votes, question)

    %{poll | questions: questions, votes: votes}
  end

  def vote(poll, choice_id) do
    do_vote(poll, choice_id, Map.has_key?(poll.votes, choice_id))
  end

  defp init_votes(votes, question) do
    question.choices
    |> Enum.map(fn choice -> {choice.id, 0} end)
    |> Enum.into(votes)
  end

  defp do_vote(poll, choice_id, _has_choice = true) do
    votes = Map.update!(poll.votes, choice_id, &(&1 + 1))

    %{poll | votes: votes}
  end

  defp do_vote(poll, _choice_id, _has_choice = false), do: poll
end
