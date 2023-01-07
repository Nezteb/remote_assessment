defmodule RemoteAssessment.UsersTest do
  use RemoteAssessment.DataCase, async: false

  alias RemoteAssessment.Users

  setup do
    :ok
  end

  describe "users" do
    import RemoteAssessment.UsersFixtures

    @invalid_attrs %{points: nil}

    test "get_two_users_above_threshold/1 returns two users" do
      # TODO: Implement test
      assert true
    end

    test "randomize_all_user_points/0 randomizes all users' points" do
      # TODO: Implement test
      assert true
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end
  end
end
