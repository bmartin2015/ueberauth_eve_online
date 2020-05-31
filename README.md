# UeberauthEveOnline

> An Ueberauth strategy for integrating with EVE Online

## Disclaimer

This is an early draft of the Eve Online strategy. Please be advised that it will probably not be perfect.

Pull requests and feedback are definitely welcome!

## Installation

1. Setup your application at [Register an Application](https://developers.eveonline.com/).

1. Add `:ueberauth_eve_online` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ueberauth_eve_online, git: "https://github.com/bmartin2015/ueberauth_eve_online"}]
    end
    ```

1. Add the strategy to your applications:

    ```elixir
    def application do
      [applications: [:ueberauth_eve_online]]
    end
    ```

1. Add Streamlabs to your Überauth configuration:

    ```elixir
    config :ueberauth, Ueberauth,
      providers: [
        eve_online: {Ueberauth.Strategy.EveOnline, []}
      ]
    ```

1.  Update your provider configuration:

    Use that if you want to read client ID/secret from the environment 
    variables in the compile time:

    ```elixir
    config :ueberauth, Ueberauth.Strategy.EveOnline.OAuth,
      client_id: System.get_env("EVEONLINE_CLIENT_ID"),
      client_secret: System.get_env("EVEONLINE_CLIENT_SECRET")
    ```

    Use that if you want to read client ID/secret from the environment 
    variables in the run time:

    ```elixir
    config :ueberauth, Ueberauth.Strategy.EveOnline.OAuth,
      client_id: {System, :get_env, ["EVEONLINE_CLIENT_ID"]},
      client_secret: {System, :get_env, ["EVEONLINE_CLIENT_SECRET"]}
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

1. Your controller needs to implement callbacks to deal with `Ueberauth.Auth` and `Ueberauth.Failure` responses.

For an example implementation see the [Überauth Example](https://github.com/ueberauth/ueberauth_example) application.

## Calling

Depending on the configured url you can initiate the request through:

    /auth/eve_online

Or with options:

    /auth/eve_online?scope=esi-skills.read_skillqueue.v1

By default the requested scope is "publicData". Scope can be configured either explicitly as a `scope` query value on the request path or in your configuration:

```elixir
config :ueberauth, Ueberauth,
  providers: [
    eve_online: {Ueberauth.Strategy.EveOnline, [default_scope: "donations.read donations.create"]}
  ]
```

See [Eve Online ESI-docs](https://docs.esi.evetech.net/docs/sso/)

## License

Please see [LICENSE](https://github.com/bmartin2015/ueberauth_eve_online/blob/master/LICENSE) for licensing details.

## CCP Copyright Notice

EVE Online and the EVE logo are the registered trademarks of CCP hf. All rights are reserved worldwide. All other trademarks are the property of their respective owners. EVE Online, the EVE logo, EVE and all associated logos and designs are the intellectual property of CCP hf. All artwork, screenshots, characters, vehicles, storylines, world facts or other recognizable features of the intellectual property relating to these trademarks are likewise the intellectual property of CCP hf. CCP hf. has granted permission to DOTLAN EveMaps to use EVE Online and all associated logos and designs for promotional and information purposes on its website but does not endorse, and is not in any way affiliated with, DOTLAN EveMaps. CCP is in no way responsible for the content on or functioning of this website, nor can it be liable for any damage arising from the use of this website.