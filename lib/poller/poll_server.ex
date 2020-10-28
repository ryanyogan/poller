defmodule Poller.PollServer do
  use GenServer

  alias Poller.Poll
  alias PollerDal.Questions

  # Public API's
  def start_link(district_id) do
    name = district_name(district_id)

    GenServer.start_link(__MODULE__, district_id, name: name)
  end

  def add_question(district_id, question) do
    GenServer.call(district_id |> district_name(), {:add_question, question})
  end

  def vote(district_id, choice_id) do
    GenServer.call(district_id |> district_name(), {:add_vote, choice_id})
  end

  def get_poll(district_id) do
    GenServer.call(district_id |> district_name(), :get_poll)
  end

  def district_name(district_id), do: :"district:#{district_id}"

  # Callback API's
  def init(district_id) do
    poll = init_poll(district_id)
    {:ok, poll}
  end

  defp init_poll(district_id) do
    questions = Questions.list_questions_by_district_id(district_id)

    district_id
    |> Poll.new()
    |> Poll.add_questions(questions)
  end

  def handle_call({:add_question, question}, _from, poll) do
    poll = Poll.add_question(poll, question)
    {:reply, poll, poll}
  end

  def handle_call({:add_vote, choice_id}, _from, poll) do
    poll = Poll.vote(poll, choice_id)
    {:reply, poll, poll}
  end

  def handle_call(:get_poll, _from, poll) do
    {:reply, poll, poll}
  end
end
