require 'test_helper'

class ProveedorTest < ActiveSupport::TestCase
  def setup
    @proveedor1 = proveedors(:proveedor1)
    @proveedor2 = Proveedor.last
  end

  def teardown
    @proveedor1 = nil
    @proveedor2 = nil
  end
  
  test "initialize" do
    assert_instance_of(Proveedor, @proveedor1)
  end

  #CRUD
  test "create" do
    assert @proveedor1.save
  end

  test "read" do
    assert_equal(3,@proveedor2.id)
  end

  test "update" do
    @proveedor2.nombre = 'proveedor3b'
    @proveedor2.save
    @proveedor2 = Proveedor.last
    assert_equal('proveedor3b',@proveedor2.nombre)
  end

  test "delete" do
    @proveedor2.estado = 'Inactivo'
    @proveedor2.save
    @proveedor2 = Proveedor.last
    assert_equal('Inactivo',@proveedor2.estado)
  end
end
