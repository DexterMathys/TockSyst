class ProveedorsController < ApplicationController
  load_and_authorize_resource :only => [:new, :create, :destroy, :alta, :edit, :update]
  skip_before_action :verify_authenticity_token
  before_filter { authorize! :index, Proveedor }

  def index
    @busqueda = nil
    @proveedores = Proveedor.where(estado: 'Activo')
    @proveedoresBaja = Proveedor.where(estado: 'Inactivo')
  end

  def new

  end

  def create
      @creado = nil
      if Proveedor.create(nombre: params[:Nombre], direccion: params[:Direccion], telefono: params[:Teléfono],
                       deuda: params[:Deuda], estado: 'Activo').valid?
        @creado = true
        @mensaje = "El proveedor se dio de alta exitosamente"
        @alert = "alert-info"
      else
        @creado = false
        @mensaje = "Hubo un error con los datos ingresados"
        @alert = "alert-danger"
      end

      render action:'new'

  end

  def destroy
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

  end

  def alta
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

  end

  def buscar
    @busqueda = true
    @proveedor = Proveedor.find_by(nombre: params[:nombre])
    @proveedores = Proveedor.where(estado: 'Activo')
    @proveedoresBaja = Proveedor.where(estado: 'Inactivo')
    render action: 'index'
  end

  def edit
      @proveedor = Proveedor.find(params[:id])

  end

  def update
      @proveedor = Proveedor.find(params[:id])
      @proveedor.update(nombre: params[:Nombre], direccion: params[:Direccion], telefono: params[:Teléfono],
                        deuda: params[:Deuda], estado: params[:Estado])
      redirect_to '/proveedors'

  end

  def ayuda
    
  end

end
