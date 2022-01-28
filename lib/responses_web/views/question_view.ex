defmodule CaptureWeb.QuestionView do
  use CaptureWeb, :view
  alias CaptureWeb.QuestionView

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{
      ones: question.ones,
      twos: question.twos,
      threes: question.threes,
      fours: question.fours,
      fives: question.fives
    }
  end
end
