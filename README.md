# Überauth EveOnline

[![License][license-img]][license]

[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg
[license]: http://opensource.org/licenses/MIT

> EveOnline OAuth2 strategy for Überauth.

## Installation

1. Setup your application at [EVE Developers](https://developers.eveonline.com/).

1. Add `:ueberauth_eve_online` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ueberauth_eve_online, git: "https://github.com/bmartin2015/ueberauth_eve_online.git"}]
    end
    ```

1. Add the strategy to your applications:

    ```elixir
    def application do
      [applications: [:ueberauth_eve_online]]
    end
    ```

1. Add EveOnline to your Überauth configuration:

    ```elixir
    config :ueberauth, Ueberauth,
      providers: [
        eve_online: {Ueberauth.Strategy.EveOnline, []}
      ]
    ```

1.  Update your provider configuration:

    ```elixir
    config :ueberauth, Ueberauth.Strategy.EveOnline.OAuth,
      client_id: System.get_env("EVE_ONLINE_CLIENT_ID"),
      client_secret: System.get_env("EVE_ONLINE_CLIENT_SECRET")
    ```

1.  Include the Überauth plug in your controller:

    ```elixir
    defmodule MyApp.AuthController do
      use MyApp.Web, :controller
      plug Ueberauth
      ...
    end
    ```

1.  Create the request and callback routes if you haven't already:

    ```elixir
    scope "/auth", MyApp do
      pipe_through :browser

      get "/:provider", AuthController, :request
      get "/:provider/callback", AuthController, :callback
    end
    ```

1. You controller needs to implement callbacks to deal with `Ueberauth.Auth` and `Ueberauth.Failure` responses.

For an example implementation see the [Überauth Example](https://github.com/ueberauth/ueberauth_example) application.

## Calling

Depending on the configured url you can initial the request through:

    /auth/eve_online?state=csrf_token_here

Or with scope:

    /auth/eve_online?state=csrf_token_here&scope=publicData

By default the requested scope is "publicData". Scope can be configured either explicitly as a `scope` query value on the request path or in your configuration:

```elixir
config :ueberauth, Ueberauth,
  providers: [
    eve_online: {Ueberauth.Strategy.EveOnline, [default_scope: "publicData esi-skills.read_skills.v1"]}
  ]
```

## License

Please see [LICENSE](https://github.com/bmartin2015/ueberauth_eve_online/blob/master/LICENSE) for licensing details.

