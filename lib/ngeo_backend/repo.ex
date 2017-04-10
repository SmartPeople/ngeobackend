defmodule NGEOBackend.Repo do
    use Ecto.Repo, otp_app: :ngeo_backend
    use Scrivener, page_size: 10
  end