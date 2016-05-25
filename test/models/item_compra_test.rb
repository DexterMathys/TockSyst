require 'test_helper'

class ItemCompraTest < ActiveSupport::TestCase
  def setup
    @item_compra1 = item_compras(:item_compra1)
    @item_compra2 = ItemCompra.last
  end

  def teardown
    @item_compra1 = nil
    @item_compra2 = nil
  end

  test "initialize" do
    assert_instance_of(ItemCompra, @item_compra1)
  end

  #CRU
  test "create" do
    assert @item_compra1.save
  end

  test "read" do
    assert_equal(2,@item_compra2.id)
  end

  test "update" do
    @item_compra2.precio_unitario = 3.0
    @item_compra2.save
    @item_compra2 = ItemCompra.last
    assert_equal(3.0,@item_compra2.precio_unitario)
  end
end
