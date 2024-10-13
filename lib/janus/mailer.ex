defmodule Janus.Mailer do
  use Swoosh.Mailer, otp_app: :janus

  import Swoosh.Email

  def create_notify_user(user) do
    new()
    |> to({user.name, user.email})
    |> from({"Surveilance Notification", "security-notify@example.com"})
    |> subject("Usuario Hikvision")
    |> html_body(
      "<h3>Ola Sr(a) #{user.name}</h3><p>Este e-mail é uma notificação sobre sua camera Hikvision.</p>"
    )
    |> text_body(
      "Olá Sr(a) #{user.name}.\nEste e-mail é uma notificação sobre sua camera Hikvision."
    )
  end
end
