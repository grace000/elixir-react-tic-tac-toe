defmodule TicTacToeWeb.Router do
  use TicTacToeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TicTacToeWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/newgame", BoardController, :new_game
  end

  # Other scopes may use custom stacks.
  scope "/api", TicTacToeWeb do
    pipe_through :api
    post "/createmove", BoardController, :create_move
  end
end
