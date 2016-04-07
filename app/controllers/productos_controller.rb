class ProductosController < ApplicationController
  #load_and_authorize_resource
  skip_before_action :verify_authenticity_token
  before_filter { authorize! :index, Producto }
  def index
    @busqueda = nil
    @productos = Producto.where(estado: 'Activo')
    @productosBaja = Producto.where(estado: 'Inactivo')
  end

  def new

  end

  def list
    @productos = Producto.where(estado: 'Activo')
  end

  def ayuda
    
  end

  def buscar
    @busqueda = true
    @producto = Producto.find_by(nombre: params[:nombre])
    @productos = Producto.where(estado: 'Activo')
    @productosBaja = Producto.where(estado: 'Inactivo')
    render action: 'index'
  end

  def edit
    @producto = Producto.find(params[:id])
  end

  def update
    @producto = Producto.find(params[:id])
    @producto.update(nombre: params[:Nombre], descripcion: params[:Descripcion], cantidad: params[:Cantidad],
                     precioCompra: params[:PrecioDeCompra], precioVenta: params[:PrecioDeVenta], estado: params[:Estado])
    redirect_to '/stock'
  end

  def destroy
    @antes = Producto.where(estado: 'Activo').count
    Producto.find(params[:id]).update(estado: 'Inactivo')
    @despues = Producto.where(estado: 'Activo').count
    if @antes > @despues
      @mensaje = "El producto se borro exitosamente"
      @alert = "alert-info"
    else
      @mensaje = "No se pudo borrar el producto"
      @alert = "alert-danger"
    end
    @productos = Producto.where(estado: 'Activo')
    @productosBaja = Producto.where(estado: 'Inactivo')
    render action: 'index'
  end

  def alta
    @antes = Producto.where(estado: 'Inactivo').count
    Producto.find(params[:id]).update(estado: 'Activo')
    @despues = Producto.where(estado: 'Inactivo').count
    if @antes > @despues
      @mensaje = "El producto se dio de alta exitosamente"
      @alert = "alert-info"
    else
      @mensaje = "No se pudo dar de alta el producto"
      @alert = "alert-danger"
    end
    @productos = Producto.where(estado: 'Activo')
    @productosBaja = Producto.where(estado: 'Inactivo')
    render action: 'index'
  end

  def create
    @creado = nil
    @antes = Producto.count
    Producto.create(nombre: params[:Nombre], descripcion: params[:Descripcion], cantidad: params[:Cantidad],
                    precioCompra: params[:PrecioDeCompra], precioVenta: params[:PrecioDeVenta], estado: 'Activo')
    @despues = Producto.count
    if @despues > @antes
      @creado = true
      @mensaje = "El producto se dio de alta exitosamente"
      @alert = "alert-info"
    else
      @creado = false
      @mensaje = "Hubo un error con los datos ingresados"
      @alert = "alert-danger"
    end

    render action:'new'
  end

end
