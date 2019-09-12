defmodule Capture.Surveys.Response do
  use Ecto.Schema
  import Ecto.Changeset

  schema "responses" do
    field :question_id, :integer
    field :survey_id, :integer
    field :user_id, :integer
    field :value, :integer

    many_to_many :demogaphics, Capture.Surveys.Demographics, join_through: "demographics_responses"

    timestamps()
  end

  @doc false
  def changeset(response, attrs) do
    response
    |> cast(attrs, [:survey_id, :question_id, :user_id, :value])
    |> validate_required([:survey_id, :question_id, :user_id, :value])
  end
end
