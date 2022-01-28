defmodule Capture.Surveys.Demographic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "demographics" do
    field :name, :string
    field :value, :string

    timestamps()
  end
end