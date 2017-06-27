defmodule PhoenixChat.PageController do
  use PhoenixChat.Web, :controller

  def chat(conn, _params) do
    render conn, "chat.html"
  end
  def front(conn, _params) do
      render(conn, "front.html")
      end
end
