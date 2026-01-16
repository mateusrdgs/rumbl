defmodule RumblWeb.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Rumbl.Accounts.get_user(user_id)

    conn
    |> assign(:current_scope, user)
  end

  def login(conn, user) do
    conn
    |> configure_session(renew: true)
    |> put_session(:user_id, user.id)
    |> assign(:current_scope, user)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
