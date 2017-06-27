defmodule PhoenixChat.Router do
  use PhoenixChat.Web, :router
  use Coherence.Router  # Added

pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session  # Added
  end

pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true #added whole section
end


  pipeline :api do
    plug :accepts, ["json"]
  end


# Add this block
  scope "/" do
      pipe_through :browser
          coherence_routes
	    end

  # Add this block
    scope "/" do
        pipe_through :protected
	coherence_routes :protected
	      end

  scope "/", PhoenixChat do
      pipe_through :browser
      get "/", PageController, :front
      # add public resources below
	  end
  scope "/", PhoenixChat do
  	pipe_through :browser
	coherence_routes :protected
	get "/chat", PageController, :chat
	end

  scope "/", PhoenixChat do
    pipe_through :protected
    # add protected resources below
	resources "/users", UserController
    	put "/lock/:id", UserController, :lock
    	put "/unlock/:id", UserController, :unlock
    	put "/confirm/:id", UserController, :confirm
	resources "/privates", PhoenixChat.PrivateController
  end
end

