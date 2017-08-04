defmodule Ebl.PageController do
  use Ebl.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
