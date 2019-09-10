defmodule CaptureWeb.SurveyView do
  use CaptureWeb, :view
  alias CaptureWeb.SurveyView

  def render("show.json", %{survey: survey}) do
    %{data: render_one(survey, SurveyView, "survey.json")}
  end

  def render("survey.json", %{survey: survey}) do
    %{
      ones: survey.ones,
      twos: survey.twos,
      threes: survey.threes,
      fours: survey.fours,
      fives: survey.fives,
    }
  end

end