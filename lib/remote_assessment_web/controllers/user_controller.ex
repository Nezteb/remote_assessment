defmodule RemoteAssessmentWeb.UserController do
  use RemoteAssessmentWeb, :controller

  alias RemoteAssessment.UserPointsUpdater

  action_fallback RemoteAssessmentWeb.FallbackController

  def query_user_points(conn, _params) do
    result = UserPointsUpdater.query_user_points()
    render(conn, "index.json", result: result)
  end
end
