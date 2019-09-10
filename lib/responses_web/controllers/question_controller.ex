defmodule CaptureWeb.QuestionController do
  use CaptureWeb, :controller

  alias Capture.Surveys
  alias Capture.Surveys.Response

  action_fallback CaptureWeb.FallbackController

  def show(
        conn,
        %{
          "survey_id" => survey_id,
          "id" => id
        } = params
      ) do
    question = Surveys.survey_question_answers(survey_id, id)

    conn
    |> render("show.json", question: question)
  end
end
