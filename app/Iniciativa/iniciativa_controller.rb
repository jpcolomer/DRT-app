require 'rho/rhocontroller'
require 'helpers/browser_helper'

class IniciativaController < Rho::RhoController
  include BrowserHelper

  # GET /Iniciativa
  def index
    @iniciativas = Iniciativa.find(:all)
    render :back => '/app'
  end

  # GET /Iniciativa/{1}
  def show
    @iniciativa = Iniciativa.find(@params['id'])
    if @iniciativa
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Iniciativa/new
  def new
    @iniciativa = Iniciativa.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Iniciativa/{1}/edit
  def edit
    @iniciativa = Iniciativa.find(@params['id'])
    if @iniciativa
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Iniciativa/create
  def create
    @iniciativa = Iniciativa.create(@params['iniciativa'])
    redirect :action => :index
  end

  # POST /Iniciativa/{1}/update
  def update
    @iniciativa = Iniciativa.find(@params['id'])
    @iniciativa.update_attributes(@params['iniciativa']) if @iniciativa
    redirect :action => :index
  end

  # POST /Iniciativa/{1}/delete
  def delete
    @iniciativa = Iniciativa.find(@params['id'])
    @iniciativa.destroy if @iniciativa
    redirect :action => :index  
  end
end
