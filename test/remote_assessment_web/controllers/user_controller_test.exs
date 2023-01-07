defmodule RemoteAssessmentWeb.UserControllerTest do
  use RemoteAssessmentWeb.ConnCase, async: false

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "queries users with minimum points", %{conn: _conn} do
      # TODO: Implement test
      assert true
    end
  end
end
