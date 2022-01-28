defmodule Capture.Repo.Migrations.CreateDemographicResponses do
  use Ecto.Migration

  def change do
    create table(:demographics_responses) do
      add :response_id, references (:responses)
      add :demographic_id, references (:demographics)
    end

    create unique_index(:demographics_responses, [:demographic_id, :response_id])
  end
end
