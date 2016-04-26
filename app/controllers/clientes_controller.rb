class ClientesController < ApplicationController
  load_and_authorize_resource :only => [:new, :create, :destroy, :alta, :edit, :update]
  skip_before_action :verify_authenticity_token
  before_filter { authorize! :index, Cliente }

  def index
    @busqueda = nil
    @clientes = Cliente.where(estado: 'Activo')
    @clientesBaja = Cliente.where(estado: 'Inactivo')
  end
  def new

  end

  def create
      @creado = nil
      @antes = Cliente.count
      if Cliente.create(nombre: params[:Nombre], direccion: params[:Direccion], telefono: params[:Teléfono],
                     deuda: params[:Deuda], estado: 'Activo').valid?
        #Si pudo crear el cliente
        @creado = true
        @mensaje = "El cliente se dio de alta exitosamente"
        @alert = "alert-info"
      else
        #Si no pudo crear al cliente
        @creado = false
        @mensaje = "Hubo un error con los datos ingresados"
        @alert = "alert-danger"
      end
      render action:'new'

  end

  def destroy
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

  end

  def alta
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

  end

  def buscar
    @busqueda = true
    @cliente = Cliente.find_by(nombre: params[:nombre])
    @clientes = Cliente.where(estado: 'Activo')
    @clientesBaja = Cliente.where(estado: 'Inactivo')
    render action: 'index'
  end

  def edit
      @cliente = Cliente.find(params[:id])

  end

  def update
      @cliente = Cliente.find(params[:id])
      @cliente.update(nombre: params[:Nombre], direccion: params[:Direccion], telefono: params[:Teléfono],
                      deuda: params[:Deuda], estado: params[:Estado])
      redirect_to '/clientes'

  end

  def ayuda

  end

end
