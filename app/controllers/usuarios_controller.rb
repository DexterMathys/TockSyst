class UsuariosController < ApplicationController
  #load_and_authorize_resource :class => false
  skip_before_action :verify_authenticity_token
  before_filter { authorize! :index, :update }

  def index
    @usuarios = User.all
  end

  def update
    @usuario = User.find(params[:id])
    @rol = params[:rol]
    if @usuario.role != @rol
      @antes = @usuario.role
      @usuario.update(role: @rol)
      if @antes != @usuario.role
        @mensaje = 'El tipo de usuario se modificó exitosamente'
        @alert = 'alert-info'
      else
        @mensaje = 'El tipo de usuario no pudo modificarse con &eacute;xito'
        @alert = 'alert-danger'
      end
    else
      @mensaje = 'El tipo de usuario se modificó exitosamente'
      @alert = 'alert-info'
    end
    if @usuario.id == session[:id] && @rol != 'admin'
      redirect_to root_path
    else
      @usuarios = User.all
      render action: 'index'
    end
  end
end
