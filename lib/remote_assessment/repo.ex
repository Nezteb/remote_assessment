defmodule RemoteAssessment.Repo do
  use Ecto.Repo,
    otp_app: :remote_assessment,
    adapter: Ecto.Adapters.Postgres
end
