defmodule NGEOBackend.DataChannel do
  use Phoenix.Channel
  require Logger

  def join("geo:data", message, socket) do
    Process.flag(:trap_exit, true)
    send(self(), {:after_join, message})
    {:ok, socket}
  end

  def join("geo:" <> _private_subtopic, _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({:after_join, msg}, socket) do
    broadcast! socket, "user:entered", %{user: msg["user"]}
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end
  
  def handle_info(:ping, socket) do
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("geo:ping", msg, socket) do
    # Logger.debug(inspect(msg))
    push socket, "geo:ping", %{msg: "pong"}
    {:reply, {:ok, %{msg: "pong"}}, assign(socket, :user, msg["user"])}
  end

  def handle_in("geo:new", msg, socket) do
    # Logger.debug(inspect(msg))
    broadcast! socket, "geo:new", %{user: msg["user"], body: msg["body"]}
    NGEOBackend.Event.insert(msg["user"], msg["body"])
    {:reply, {:ok, %{}}, assign(socket, :user, msg["user"])}
  end

end