class ClientesController < ApplicationController
  #load_and_authorize_resource
  skip_before_action :verify_authenticity_token
  before_filter { authorize! :index, Cliente }

  def index
    @busqueda = nil
    @clientes = Cliente.where(estado: 'Activo')
    @clientesBaja = Cliente.where(estado: 'Inactivo')
  end

  def new
    if is_cliente?

    else
      redirect_to_root
    end
  end

  def create
    if is_cliente?
      @creado = nil
      @antes = Cliente.count
      Cliente.create(nombre: params[:Nombre], direccion: params[:Direccion], telefono: params[:Teléfono],
                     deuda: params[:Deuda], estado: 'Activo')
      @despues = Cliente.count
      if @despues > @antes
        @creado = true
        @mensaje = "El cliente se dio de alta exitosamente"
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
    if is_cliente?
      @antes = Cliente.where(estado: 'Activo').count
      Cliente.find(params[:id]).update(estado: 'Inactivo')
      @despues = Cliente.where(estado: 'Activo').count
      if @antes > @despues
        @mensaje = "El cliente se borro exitosamente"
        @alert = "alert-info"
      else
        @mensaje = "No se pudo borrar el cliente"
        @alert = "alert-danger"
      end
      @clientes = Cliente.where(estado: 'Activo')
      @clientesBaja = Cliente.where(estado: 'Inactivo')
      render action: 'index'
    else
      redirect_to_root
    end
  end

  def alta
    if is_cliente?
      @antes = Cliente.where(estado: 'Inactivo').count
      Cliente.find(params[:id]).update(estado: 'Activo')
      @despues = Cliente.where(estado: 'Inactivo').count
      if @antes > @despues
        @mensaje = "El cliente se dio de alta exitosamente"
        @alert = "alert-info"
      else
        @mensaje = "No se pudo dar de alta el cliente"
        @alert = "alert-danger"
      end
      @clientes = Cliente.where(estado: 'Activo')
      @clientesBaja = Cliente.where(estado: 'Inactivo')
      render action: 'index'
    else
      redirect_to_root
    end
  end

  def buscar
    @busqueda = true
    @cliente = Cliente.find_by(nombre: params[:nombre])
    @clientes = Cliente.where(estado: 'Activo')
    @clientesBaja = Cliente.where(estado: 'Inactivo')
    render action: 'index'
  end

  def edit
    if is_cliente?
      @cliente = Cliente.find(params[:id])
    else
      redirect_to_root
    end
  end

  def update
    if is_cliente?
      @cliente = Cliente.find(params[:id])
      @cliente.update(nombre: params[:Nombre], direccion: params[:Direccion], telefono: params[:Teléfono],
                      deuda: params[:Deuda], estado: params[:Estado])
      redirect_to '/clientes'
    else
      redirect_to_root
    end
  end

  def ayuda

  end

  private
    def is_cliente?
      current_user.role == 'clientes' || current_user.role == 'admin'
    end

    def redirect_to_root
      redirect_to root_path, flash: {error: 'You are not authorized to access this page.'}
    end

end
