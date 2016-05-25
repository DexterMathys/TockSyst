require 'test_helper'

class ProductoProvisorioTest < ActiveSupport::TestCase
  def setup
    ProductoProvisorio.create(id_producto: 1, cantidad: 1)
    @producto1 = ProductoProvisorio.last
    ProductoProvisorio.create(id_producto: 2, cantidad: 1)
    @producto2 = ProductoProvisorio.last
  end

  def teardown
    @producto1.delete
    @producto1 = nil
    @producto2 = nil
  end

  test "initialize" do
    assert_instance_of(ProductoProvisorio, @producto1)
  end

  #CRUD
  test "create" do
    assert @producto1.save
  end

  test "read" do
    assert_equal(2,@producto2.id_producto)
  end

  test "update" do
    @producto2.cantidad = 2
    @producto2.save
    @producto2 = ProductoProvisorio.last
    assert_equal(2,@producto2.cantidad)
  end

  test "delete" do
    @producto2.delete
    @producto2 = ProductoProvisorio.last
    assert_equal(1,@producto2.id_producto)
  end
end
