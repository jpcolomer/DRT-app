require 'rho/rhocontroller'
require 'helpers/browser_helper'

class AvanceIniciativaController < Rho::RhoController
  include BrowserHelper

  # GET /AvanceIniciativa
  def index
    @avance_iniciativas = AvanceIniciativa.find(:all)
    render :back => '/app'
  end

  # GET /AvanceIniciativa/{1}
  def show
    @avance_iniciativa = AvanceIniciativa.find(@params['id'])
    if @avance_iniciativa
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /AvanceIniciativa/new
  def new
    @avance_iniciativa = AvanceIniciativa.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /AvanceIniciativa/{1}/edit
  def edit
    @avance_iniciativa = AvanceIniciativa.find(@params['id'])
    if @avance_iniciativa
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /AvanceIniciativa/create
  def create
    @avance_iniciativa = AvanceIniciativa.create(@params['avance_iniciativa'])
    redirect :action => :index
  end

  # POST /AvanceIniciativa/{1}/update
  def update
    @avance_iniciativa = AvanceIniciativa.find(@params['id'])
    @avance_iniciativa.update_attributes(@params['avance_iniciativa']) if @avance_iniciativa
    redirect :action => :index
  end

  # POST /AvanceIniciativa/{1}/delete
  def delete
    @avance_iniciativa = AvanceIniciativa.find(@params['id'])
    @avance_iniciativa.destroy if @avance_iniciativa
    redirect :action => :index  
  end
end
