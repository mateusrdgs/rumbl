defmodule RumblWeb.UserController do
  use Phoenix.Component

  use RumblWeb, :controller

  alias Rumbl.Accounts

  def index(conn, _params) do
    users = Accounts.list_users()

    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id} = _params) do
    user = Accounts.get_user_by(%{id: id})

    render(conn, :show, user: user)
  end
end
