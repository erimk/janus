# Janus

This is a RESTfull API project to manage a system of survailence cameras. Following the proposed [challenge](`desafio.md`).

## Configuration

- Elixir environment. See more in: [https://elixir-lang.org/install.html]
- Postgres database.

## Seeds

- Run `mix ecto.drop && mix setup` to run the seeds with clean database. `mix ecto.setup` creates tables in the database with the following information:
- 1 thousand users with random names.
- 50 cameras for each user, the cameras have random names, the brand of the cameras varies randomly between 4: Intelbras, Hikvision, Giga and Vivotek.
- The 'active' status of each camera varies randomly, allowing users with only 1 active camera and users with multiple active cameras.

## Running the Server

  ** Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

The server is available at [`localhost:4000`](http://localhost:4000) from your browser.

## Endpoints

- Get all users and it's cameras ( get /api/cameras ).
- Send a email to all 'Hikvision's camera brand owners ( post /api/notify-users ).

## Database

  PostgreSQL

  ```Elixir
  username: postgres
  password: postgres
  ```

### Trivia

Inspired in the ancient Roman religion and myth, Janus is the god of beginnings, gates, transitions, time, duality, doorways, passages, frames, and endings.
