defmodule RumblWeb.SessionController do
  use RumblWeb, :controller

  def new(conn, _) do
    render(conn, "new.html",
      form_data: Phoenix.Component.to_form(%{"username" => nil, "password" => nil})
    )
  end

  def create(conn, %{"username" => username, "password" => password}) do
    case Rumbl.Accounts.authenticate_by_username_and_pass(username, password) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: "/users")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html",
          form_data: Phoenix.Component.to_form(%{"username" => nil, "password" => nil})
        )
    end
  end

  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: "/")
  end
end
