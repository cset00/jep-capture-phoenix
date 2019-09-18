defmodule Capture.Surveys do
  @moduledoc """
  The Surveys context.
  """

  import Ecto.Query, warn: false
  alias Capture.Repo

  alias Capture.Surveys.Response

  def handle_response(params) do
    find_response(params)
    |> case do
      nil ->
        create_response(params)

      response ->
        update_response(response, params)
    end
  end

  @doc """
  Creates a response.

  ## Examples

      iex> create_response(%{field: value})
      {:ok, %Response{}}

      iex> create_response(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_response(attrs \\ %{}) do
    %Response{}
    |> Response.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a response.

  ## Examples

      iex> update_response(response, %{field: new_value})
      {:ok, %Response{}}

      iex> update_response(response, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_response(%Response{} = response, attrs) do
    response
    |> Response.changeset(attrs)
    |> Repo.update()
  end

  def find_response(%{
        "survey_id" => survey_id,
        "question_id" => question_id,
        "user_id" => user_id
      }) do
    Response
    |> where(
      survey_id: ^survey_id,
      question_id: ^question_id,
      user_id: ^user_id
    )
    |> Repo.one()
  end

  def find_response(id) do
    Response
    |> where(id: ^id)
    |> Repo.one()
  end

  def count_survey_answers_query(survey_id) do
    Response
    |> where(survey_id: ^survey_id)
  end

  def count_survey_question_answers_query(survey_id, question_id) do
    count_survey_answers_query(survey_id)
    |> where(question_id: ^question_id)
  end

  def survey_answers(query) do
    count = query |> aggregate_values

    %{
      ones: count[1] || 0,
      twos: count[2] || 0,
      threes: count[3] || 0,
      fours: count[4] || 0,
      fives: count[5] || 0
    }
  end

  defp aggregate_values(query) do
    query
    |> group_by([r], r.value)
    |> select([r], {r.value, count(r.value)})
    |> Repo.all()
    |> Enum.into(%{})
  end
end
