defmodule EcCart.Server do
  use GenServer

  def init(_) do
    {:ok, EcCart.Cart.new()}
  end

  def start_link do
    GenServer.start_link(EcCart.Server, nil)
  end

  def handle_cast({:add_item, item}, state) do
    {:noreply, EcCart.Cart.add_item(state, item)}
  end

  def handle_cast({:add_adjustment, adjustment}, state) do
    {:noreply, EcCart.Cart.add_adjustment(state, adjustment)}
  end

  def handle_cast({:remove_adjustment, adjustment}, state) do
    {:noreply, EcCart.Cart.remove_adjustment(state, adjustment)}
  end

  def handle_call({:subtotal}, _, state) do
    {:reply, EcCart.Cart.subtotal(state), state}
  end

  def handle_call({:total}, _, state) do
    {:reply, EcCart.Cart.total(state), state}
  end

  def add_item(pid, item) do
    GenServer.cast(pid, {:add_item, item})
  end

  def add_adjustment(pid, adjustment) do
    GenServer.cast(pid, {:add_adjustment, adjustment})
  end

  def remove_adjustment(pid, adjustment) do
    GenServer.cast(pid, {:remove_adjustment, adjustment})
  end

  def subtotal(pid) do
    GenServer.call(pid, {:subtotal})
  end

  def total(pid) do
    GenServer.call(pid, {:total})
  end
end
