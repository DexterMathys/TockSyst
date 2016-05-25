require 'test_helper'

class ItemVentumTest < ActiveSupport::TestCase
  def setup
    @item_venta1 = item_ventas(:item_venta1)
    @item_venta2 = ItemVenta.last
  end

  def teardown
    @item_venta1 = nil
    @item_venta2 = nil
  end

  test "initialize" do
    assert_instance_of(ItemVenta, @item_venta1)
  end

  #CRU
  test "create" do
    assert @item_venta1.save
  end

  test "read" do
    assert_equal(2,@item_venta2.id)
  end

  test "update" do
    @item_venta2.precio_unitario = 3.0
    @item_venta2.save
    @item_venta2 = ItemVenta.last
    assert_equal(3.0,@item_venta2.precio_unitario)
  end
end
