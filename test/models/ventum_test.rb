require 'test_helper'

class VentumTest < ActiveSupport::TestCase
  def setup
    @venta1 = ventas(:venta1)
    @venta2 = Venta.last
  end

  def teardown
    @venta1 = nil
    @venta2 = nil
  end
  
  test "initialize" do
    assert_instance_of(Venta, @venta1)
  end

  #CRU
  test "create" do
    assert @venta1.save
  end

  test "read" do
    assert_equal(2,@venta2.id)
  end

  test "update" do
    @venta2.cliente_id = 1
    @venta2.save
    @venta2 = Venta.last
    assert_equal(1,@venta2.cliente_id)
  end
end
