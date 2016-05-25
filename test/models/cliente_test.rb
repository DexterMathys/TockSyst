require 'test_helper'

class ClienteTest < ActiveSupport::TestCase
  def setup
    @cliente1 = clientes(:cliente1)
    @cliente2 = Cliente.last
  end

  def teardown
    @cliente1 = nil
    @cliente2 = nil
  end
  
  test "initialize" do
    assert_instance_of(Cliente, @cliente1)
  end

  #CRUD
  test "create" do
    assert @cliente1.save
  end

  test "read" do
    assert_equal(3,@cliente2.id)
  end

  test "update" do
    @cliente2.nombre = 'cliente3b'
    @cliente2.save
    @cliente2 = Cliente.last
    assert_equal('cliente3b',@cliente2.nombre)
  end

  test "delete" do
    @cliente2.estado = 'Inactivo'
    @cliente2.save
    @cliente2 = Cliente.last
    assert_equal('Inactivo',@cliente2.estado)
  end
end
