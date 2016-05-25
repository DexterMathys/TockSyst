require 'test_helper'

class CompraTest < ActiveSupport::TestCase
  def setup
    @compra1 = compras(:compra1)
    @compra2 = Compra.last
  end

  def teardown
    @compra1 = nil
    @compra2 = nil
  end

  test "initialize" do
    assert_instance_of(Compra, @compra1)
  end

  #CRU
  test "create" do
    assert @compra1.save
  end

  test "read" do
    assert_equal(2,@compra2.id)
  end

  test "update" do
    @compra2.proveedor_id = 1
    @compra2.save
    @compra2 = Compra.last
    assert_equal(1,@compra2.proveedor_id)
  end
end
