require 'rho/rhocontroller'
require 'helpers/browser_helper'

class DotacionController < Rho::RhoController
  include BrowserHelper

  # GET /Dotacion
  def index
    @dotacions = Dotacion.find(:all)
    render :back => '/app'
  end

  # GET /Dotacion/{1}
  def show
    @dotacion = Dotacion.find(@params['id'])
    if @dotacion
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Dotacion/new
  def new
    @dotacion = Dotacion.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Dotacion/{1}/edit
  def edit
    @dotacion = Dotacion.find(@params['id'])
    if @dotacion
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Dotacion/create
  def create
    @dotacion = Dotacion.create(@params['dotacion'])
    redirect :action => :index
  end

  # POST /Dotacion/{1}/update
  def update
    @dotacion = Dotacion.find(@params['id'])
    @dotacion.update_attributes(@params['dotacion']) if @dotacion
    redirect :action => :index
  end

  # POST /Dotacion/{1}/delete
  def delete
    @dotacion = Dotacion.find(@params['id'])
    @dotacion.destroy if @dotacion
    redirect :action => :index  
  end
end
