class ProveedorsController < ApplicationController
  #load_and_authorize_resource
  skip_before_action :verify_authenticity_token
  before_filter { authorize! :index, Proveedor }

  def index
    @busqueda = nil
    @proveedores = Proveedor.where(estado: 'Activo')
    @proveedoresBaja = Proveedor.where(estado: 'Inactivo')
  end

  def new
    if is_proveedor?

    else
      redirect_to_root
    end
  end

  def create
    if is_proveedor?
      @creado = nil
      @antes = Proveedor.count
      Proveedor.create(nombre: params[:Nombre], direccion: params[:Direccion], telefono: params[:Teléfono],
                       deuda: params[:Deuda], estado: 'Activo')
      @despues = Proveedor.count
      if @despues > @antes
        @creado = true
        @mensaje = "El proveedor se dio de alta exitosamente"
        @alert = "alert-info"
      else
        @creado = false
        @mensaje = "Hubo un error con los datos ingresados"
        @alert = "alert-danger"
      end

      render action:'new'
    else
      redirect_to_root
    end

  end

  def destroy
    if is_proveedor?
      @antes = Proveedor.where(estado: 'Activo').count
      Proveedor.find(params[:id]).update(estado: 'Inactivo')
      @despues = Proveedor.where(estado: 'Activo').count
      if @antes > @despues
        @mensaje = "El proveedor se borro exitosamente"
        @alert = "alert-info"
      else
        @mensaje = "No se pudo borrar el proveedor"
        @alert = "alert-danger"
      end
      @proveedores = Proveedor.where(estado: 'Activo')
      @proveedoresBaja = Proveedor.where(estado: 'Inactivo')
      render action: 'index'
    else
      redirect_to_root
    end

  end

  def alta
    if is_proveedor?
      @antes = Proveedor.where(estado: 'Inactivo').count
      Proveedor.find(params[:id]).update(estado: 'Activo')
      @despues = Proveedor.where(estado: 'Inactivo').count
      if @antes > @despues
        @mensaje = "El proveedor se dio de alta exitosamente"
        @alert = "alert-info"
      else
        @mensaje = "No se pudo dar de alta el proveedor"
        @alert = "alert-danger"
      end
      @proveedores = Proveedor.where(estado: 'Activo')
      @proveedoresBaja = Proveedor.where(estado: 'Inactivo')
      render action: 'index'
    else
      redirect_to_root
    end

  end

  def buscar
    @busqueda = true
    @proveedor = Proveedor.find_by(nombre: params[:nombre])
    @proveedores = Proveedor.where(estado: 'Activo')
    @proveedoresBaja = Proveedor.where(estado: 'Inactivo')
    render action: 'index'
  end

  def edit
    if is_proveedor?
      @proveedor = Proveedor.find(params[:id])
    else
      redirect_to_root
    end
  end

  def update
    if is_proveedor?
      @proveedor = Proveedor.find(params[:id])
      @proveedor.update(nombre: params[:Nombre], direccion: params[:Direccion], telefono: params[:Teléfono],
                        deuda: params[:Deuda], estado: params[:Estado])
      redirect_to '/proveedors'
    else
      redirect_to_root
    end

  end

  def ayuda
    
  end
  private
    def is_proveedor?
      current_user.role == 'proveedores' || current_user.role == 'admin'
    end

    def redirect_to_root
      redirect_to root_path, flash: {error: 'You are not authorized to access this page.'}
    end
end
