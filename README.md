# Sentrydemo

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Make sure Sentry has source code compiled with `mix sentry.package_source_code`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Generating Sentry Demo Data

  * Set the DSN in your shell `export SENTRY_DSN=<DSN>`
  * Run `curl http://localhost:4000/api/process_order -H 'Content-Type: application/json' -d '{"nails": 5}' -v` to generate an exception
  * In a browser visit
    * http://localhost:4000/handled for handled exception
    * http://localhost:4000/unhandled for unhandled key error in map exception
    * http://localhost:4000/message for capture message
    * http://localhost:4000/exception for manual capture exception

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
