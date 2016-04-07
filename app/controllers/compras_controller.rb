class ComprasController < ApplicationController
  #load_and_authorize_resource
  skip_before_action :verify_authenticity_token
  before_filter { authorize! :index, Compra }

  def index
    @compras = Compra.all
  end

  def new
    @proveedores = Proveedor.where(estado: 'Activo')
    ProductoProvisorio.destroy_all
  end

  def comprando
    @fecha = params[:fecha]
    @proveedor = Proveedor.find_by(nombre: params[:proveedor])
    @productos = Producto.where(estado: 'Activo')
    @productos_provisorios = ProductoProvisorio.all
  end

  def create
    @productos = ProductoProvisorio.all
    @total = 0
    @productos.each do |producto|
      @prod = Producto.find(producto.id_producto)
      @prod.update(cantidad: (@prod.cantidad + producto.cantidad))
      @total += (@prod.precioCompra * producto.cantidad)
    end
    Compra.create(fecha: params[:fecha], proveedor_id: params[:proveedor_id], total: @total)
    @productos.each do |producto|
      @prod = Producto.find(producto.id_producto)
      ItemCompra.create(compra_id: Compra.last.id, producto_id: producto.id_producto, cantidad: producto.cantidad, precio_unitario: @prod.precioCompra)
    end
    ProductoProvisorio.destroy_all
    if @total != params[:pago]
      @proveedor = Proveedor.find(params[:proveedor_id])
      @proveedor.update(deuda: (@proveedor.deuda + (@total - params[:pago].to_i)))
    end
    @mensaje = 'La compra se realizo exitosamente'
    @alert = 'alert-info'
    @compras = Compra.all
    render action: 'index'
  end

  def buscar
    @busqueda = true
    @producto = Producto.find_by(nombre: params[:nombre])
    @fecha = params[:fecha]
    @proveedor = Proveedor.find(params[:proveedor_id])
    @productos = Producto.where(estado: 'Activo')
    @productos_provisorios = ProductoProvisorio.all
    render action: 'comprando'
  end

  def agregar
    @producto = Producto.find(params[:id])
    @fecha = params[:fecha]
    @proveedor = Proveedor.find(params[:proveedor_id])
    @productos = Producto.where(estado: 'Activo')
    ProductoProvisorio.create(id_producto: @producto.id,
                               cantidad: params[:cantidad_comprar])
    @productos_provisorios = ProductoProvisorio.all
    render action: 'comprando'
  end

  def destroy
    @producto = ProductoProvisorio.find(params[:id])
    @producto.destroy
    @fecha = params[:fecha]
    @proveedor = Proveedor.find(params[:proveedor_id])
    @productos = Producto.where(estado: 'Activo')
    @productos_provisorios = ProductoProvisorio.all
    render action: 'comprando'
  end

  def buscar_numero
    @busqueda = true
    @compras = Compra.all
    @compra = Compra.where(id: params[:numero])
    render action: 'index'
  end

  def buscar_proveedor
    @busqueda = true
    @compras = Compra.all
    @proveedor = Proveedor.find_by(nombre: params[:proveedor])
    if @proveedor != nil
      @compra = Compra.where(proveedor_id: @proveedor.id)
    else
      @compra = nil
    end
    render action: 'index'
  end

  def buscar_fecha
    @busqueda = true
    @compras = Compra.all
    @compra = Compra.where(fecha: params[:fecha])
    render action: 'index'
  end

  def show
    @compra = Compra.find(params[:id])
    @proveedor = Proveedor.find(@compra.proveedor_id)
    @productos = ItemCompra.where(compra_id: @compra.id)
  end

  def ayuda
    
  end
end
