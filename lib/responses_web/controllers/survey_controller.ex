defmodule CaptureWeb.SurveyController do
  use CaptureWeb, :controller

  alias Capture.Surveys
  alias Capture.Surveys.Response

  action_fallback CaptureWeb.FallbackController

  def show(conn, %{
    "id" => id
  } = params) do
    survey = Surveys.survey_answers(id)

    conn
    |> render("show.json", survey: survey)
  end
end