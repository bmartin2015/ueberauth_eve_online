defmodule Ueberauth.Strategy.EveOnline do
  @moduledoc """
  Implements an `Ueberauth.Strategy` for Eve Online.
  """
  use Ueberauth.Strategy

  @auth_domain "https://login.eveonline.com/v2/oauth"

  @doc """
  Handle the request step of the strategy.
  """
  @spec handle_request!(Plug.Conn.t()) :: Plug.Conn.t()
  def handle_request!(conn) do
    state = :crypto.strong_rand_bytes(32) |> Base.encode16()

    client_id =
      client_id()
      |> Keyword.get(:client_id)

    params = %{
      response_type: "code",
      client_id: client_id,
      redirect_uri: callback_url(conn),
      state: state,
      # TODO - make dynamic
      scope: "publicData"
    }

    url = "#{@auth_domain}/authorize?" <> URI.encode_query(params)

    conn
    |> fetch_session()
    |> put_session("eve_online_state", state)
    |> redirect!(url)
    |> halt()
  end

  @doc """
  Handle the callback step of the strategy.
  """
  @spec handle_callback!(Plug.Conn.t()) :: Plug.Conn.t()
  def handle_callback!(%Plug.Conn{params: %{"state" => state}} = conn) do
    expected_state =
      conn
      |> fetch_session()
      |> get_session("eve_online_state")

    conn =
      if state == expected_state do
        exchange_code_for_token(conn)
      else
        set_errors!(conn, error("bad_state", "State parameter doesn't match"))
      end

    conn
    |> fetch_session()
    |> delete_session("eve_online_state")
  end

  defp exchange_code_for_token(conn) do
    conn
  end

  defp client_id do
    Application.get_env(:ueberauth, Ueberauth.Strategy.EveOnline.OAuth, :client_id)
  end
end
