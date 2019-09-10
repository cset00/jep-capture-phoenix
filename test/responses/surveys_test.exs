defmodule Capture.SurveysTest do
  use Capture.DataCase

  alias Capture.Surveys
  alias Capture.Surveys.Response

  describe "responses, with no existing response" do
    @valid_attrs %{"question_id" => 42, "survey_id" => 42, "user_id" => 42,"value" => 42}

    test "handle_response/1 creates a new response" do
      assert {:ok, %Response{} = response} = Surveys.handle_response(@valid_attrs)
      assert response.question_id == 42
      assert response.survey_id == 42
      assert response.user_id == 42
      assert response.value == 42
    end
  end

  describe "responses, with an existing response" do
    @valid_attrs %{"question_id" => 42, "survey_id" => 42, "user_id" => 42,"value" => 42}

    setup do
      response = %Response{} |> Response.changeset(@valid_attrs) |> Repo.insert!
      {:ok, response: response}
    end

    test "handle_response/1, updates the existing response", %{response: response} do
      new_attrs = @valid_attrs |> Map.put("value", 1)
      assert {:ok, %Response{} = updated_response} = Surveys.handle_response(new_attrs)

      assert updated_response.id == response.id
      assert updated_response.value == 1
    end
  end

  describe "Count the number values selected" do
    naive_datetime = NaiveDateTime.utc_now()

    @response2 %{
      :question_id => 2,
      :survey_id => 1,
      :user_id => 34,
      :value => 2,
      :inserted_at => NaiveDateTime.truncate(naive_datetime, :second),
      :updated_at => NaiveDateTime.truncate(naive_datetime, :second)
    }
    @response1 %{
      :question_id => 1,
      :survey_id => 1,
      :user_id => 42,
      :value => 1,
      :inserted_at => NaiveDateTime.truncate(naive_datetime, :second),
      :updated_at => NaiveDateTime.truncate(naive_datetime, :second)
    }
    @response3 %{
      :question_id => 3,
      :survey_id => 1,
      :user_id => 27,
      :value => 2,
      :inserted_at => NaiveDateTime.truncate(naive_datetime, :second),
      :updated_at => NaiveDateTime.truncate(naive_datetime, :second)
    }

    @response4 %{
        :question_id => 2,
        :survey_id => 1,
        :user_id => 28,
        :value => 5,
        :inserted_at => NaiveDateTime.truncate(naive_datetime, :second),
        :updated_at => NaiveDateTime.truncate(naive_datetime, :second)
    }

    setup do
      response = Repo.insert_all(Response, [@response1, @response2, @response3, @response4])

      {:ok, response: response}
    end

    test "count responses based on survey_id and values" do
      survey_id = 1
      count = Surveys.survey_answers(survey_id)

      assert count.ones == 1
      assert count.twos == 2
      assert count.threes == 0
      assert count.fours == 0
      assert count.fives == 1
    end

    test "count responses based on survey_id, question_id and values" do
      survey_id = 1
      question_id = 2
      count = Surveys.survey_question_answers(survey_id, question_id)

      assert count.ones == 0
      assert count.twos == 1
      assert count.threes == 0
      assert count.fours == 0
      assert count.fives == 1
    end
  end

end
