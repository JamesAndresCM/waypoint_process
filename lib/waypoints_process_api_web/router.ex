defmodule WaypointsProcessApiWeb.Router do
  use WaypointsProcessApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", WaypointsProcessApiWeb do
    pipe_through :api
    resources "/waypoints", WaypointController, only: [:index, :create, :show]
  end

  scope "/", WaypointsProcessApiWeb do
    pipe_through :api
    get "/", DefaultController, :index
    get "/alive", DefaultController, :alive
    get "/*path", DefaultController, :index
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
