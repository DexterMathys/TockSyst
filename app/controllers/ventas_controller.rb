class VentasController < ApplicationController
  #load_and_authorize_resource
  skip_before_action :verify_authenticity_token
  before_filter { authorize! :index, Venta }

  def index
    @ventas = Venta.all
  end

  def new
    @clientes = Cliente.where(estado: 'Activo')
    ProductoProvisorio.destroy_all
  end

  def vendiendo
    @fecha = params[:fecha]
    @cliente = Cliente.find_by(nombre: params[:cliente])
    @productos = Producto.where(estado: 'Activo')
    @productos_provisorios = ProductoProvisorio.all
  end

  def create
    @productos = ProductoProvisorio.all
    @total = 0
    @productos.each do |producto|
      @prod = Producto.find(producto.id_producto)
      @prod.update(cantidad: (@prod.cantidad - producto.cantidad))
      @total += (@prod.precioVenta * producto.cantidad)
    end
    Venta.create(fecha: params[:fecha], cliente_id: params[:cliente_id], total: @total)
    @productos.each do |producto|
      @prod = Producto.find(producto.id_producto)
      ItemVenta.create(venta_id: Venta.last.id, producto_id: producto.id_producto, cantidad: producto.cantidad, precio_unitario: @prod.precioVenta)
    end
    ProductoProvisorio.destroy_all
    if @total != params[:pago]
      @cliente = Cliente.find(params[:cliente_id])
      @cliente.update(deuda: (@cliente.deuda + (@total - params[:pago].to_i)))
    end
    @mensaje = 'La venta se realizo exitosamente'
    @alert = 'alert-info'
    @ventas = Venta.all
    render action: 'index'
  end

  def buscar
    @busqueda = true
    @producto = Producto.find_by(nombre: params[:nombre])
    @fecha = params[:fecha]
    @cliente = Cliente.find(params[:cliente_id])
    @productos = Producto.where(estado: 'Activo')
    @productos_provisorios = ProductoProvisorio.all
    render action: 'vendiendo'
  end

  def agregar
    @producto = Producto.find(params[:id])
    @fecha = params[:fecha]
    @cliente = Cliente.find(params[:cliente_id])
    @productos = Producto.where(estado: 'Activo')
    ProductoProvisorio.create(id_producto: @producto.id,
                              cantidad: params[:cantidad_vender])
    @productos_provisorios = ProductoProvisorio.all
    render action: 'vendiendo'
  end

  def destroy
    @producto = ProductoProvisorio.find(params[:id])
    @producto.destroy
    @fecha = params[:fecha]
    @cliente = Cliente.find(params[:cliente_id])
    @productos = Producto.where(estado: 'Activo')
    @productos_provisorios = ProductoProvisorio.all
    render action: 'vendiendo'
  end

  def buscar_numero
    @busqueda = true
    @ventas = Venta.all
    @venta = Venta.where(id: params[:numero])
    render action: 'index'
  end

  def buscar_cliente
    @busqueda = true
    @ventas = Venta.all
    @cliente = Cliente.find_by(nombre: params[:cliente])
    if @cliente != nil
      @venta = Venta.where(cliente_id: @cliente.id)
    else
      @venta = nil
    end
    render action: 'index'
  end

  def buscar_fecha
    @busqueda = true
    @ventas = Venta.all
    @venta = Venta.where(fecha: params[:fecha])
    render action: 'index'
  end

  def show
    @venta = Venta.find(params[:id])
    @cliente = Cliente.find(@venta.cliente_id)
    @productos = ItemVenta.where(venta_id: @venta.id)
  end

  def ayuda
    
  end

end
