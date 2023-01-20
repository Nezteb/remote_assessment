defmodule RemoteAssessment.UserPointsUpdater do
  @moduledoc false
  use GenServer
  alias RemoteAssessment.Users
  require Logger

  defstruct min_number: 0, last_queried_time: nil

  def start_link([] = _args) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(nil) do
    Logger.info("Starting UserPointsUpdater, PID: #{inspect(self())}")

    # Start the 1-minute interval
    Process.send(self(), :refresh_points, [:noconnect])

    {:ok, %__MODULE__{}}
  end

  # Client functions

  def query_user_points do
    GenServer.call(__MODULE__, :query_user_points)
  end

  # Server callbacks

  # - Should accept a handle_call that:
  #   - Queries the database for all users with more points than `min_number` but only retrieve a max of 2 users.
  #   - Updates the genserver state `timestamp` with the current timestamp
  #   - Returns the users just retrieved from the database, as well as the timestamp of the **previous `handle_call`**
  @impl true
  def handle_call(:query_user_points, _from, state) do
    new_last_queried_time = DateTime.utc_now()
    two_users = Users.get_two_users_above_threshold(state.min_number)

    Logger.info(
      "Two users: #{Jason.encode!(two_users)}, new last queried time: #{DateTime.to_string(new_last_queried_time)}"
    )

    new_state = %__MODULE__{
      min_number: state.min_number,
      last_queried_time: new_last_queried_time
    }

    {:reply, {two_users, state.last_queried_time}, new_state}
  end

  # - Run every minute and when it runs:
  #   - Should update every user's points in the database (using a random number generator [0-100] for each)
  #   - Refresh the `min_number` of the genserver state with a new random number
  @impl true
  def handle_info(:refresh_points, state) do
    Logger.info("Randomizing user points")

    Users.randomize_all_user_points()

    new_min_number = Enum.random(0..100)
    Logger.info("Setting new random min_number for queries: #{new_min_number}")

    new_state = %__MODULE__{
      min_number: new_min_number,
      last_queried_time: state.last_queried_time
    }

    next_run_time = DateTime.utc_now() |> DateTime.add(60, :second)
    Logger.info("Next run time: #{DateTime.to_string(next_run_time)}")

    # 1 minute
    Process.send_after(self(), :refresh_points, 60 * 1000)

    {:noreply, new_state}
  end
end
