require 'test_helper'

class ProductoTest < ActiveSupport::TestCase
  def setup
    @producto1 = productos(:producto1)
    @producto2 = Producto.last
  end

  def teardown
    @producto1 = nil
    @producto2 = nil
  end

  test "initialize" do
    assert_instance_of(Producto, @producto1)
  end

  #CRUD
  test "create" do
    assert @producto1.save
  end

  test "read" do
    assert_equal(4,@producto2.id)
  end

  test "update" do
    @producto2.nombre = 'producto4b'
    @producto2.save
    @producto2 = Producto.last
    assert_equal('producto4b',@producto2.nombre)
  end

  test "delete" do
    @producto2.estado = 'Inactivo'
    @producto2.save
    @producto2 = Producto.last
    assert_equal('Inactivo',@producto2.estado)
  end
end
