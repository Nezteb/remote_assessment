defmodule RemoteAssessmentWeb.PageController do
  use RemoteAssessmentWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
