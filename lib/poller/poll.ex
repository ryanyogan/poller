defmodule Poller.Poll do
  defstruct district_id: nil,
            questions: [],
            votes: %{}

  alias Poller.Question

  def new(district_id) do
    __struct__(district_id: district_id)
  end

  def add_questions(poll, []), do: poll

  def add_questions(poll, [question | questions]) do
    votes = init_votes(poll.votes, question)
    question = Question.new(question)

    poll =
      add_question(poll, question)
      |> Map.put(:votes, votes)

    add_questions(poll, questions)
  end

  def add_question(poll, question) do
    questions = [question | poll.questions]

    %{poll | questions: questions}
  end

  def vote(poll, choice_id) do
    do_vote(poll, choice_id, Map.has_key?(poll.votes, choice_id))
  end

  defp init_votes(votes, question) do
    question.choices
    |> Enum.map(fn choice ->
      votes = choice.votes || 0
      {choice.id, votes}
    end)
    |> Enum.into(votes)
  end

  defp do_vote(poll, choice_id, _has_choice = true) do
    votes = Map.update!(poll.votes, choice_id, &(&1 + 1))

    %{poll | votes: votes}
  end

  defp do_vote(poll, _choice_id, _has_choice = false), do: poll
end
