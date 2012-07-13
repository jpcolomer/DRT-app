require 'rho/rhocontroller'
require 'helpers/browser_helper'

class AvanceController < Rho::RhoController
  include BrowserHelper

  # GET /Avance
  def index
    render :back => '/app'
  end

  def get_iniciativas_dotaciones(contratos)
    iniciativas = []
    dotaciones = []
    contratos.each do |contrato|
      iniciativas << contrato.get_iniciativas
      dotaciones << contrato.get_dotaciones
    end
    [iniciativas, dotaciones]
  end
  
  def area
    @area = Area.find(:first)
    @fecha_base = @area.get_fecha_base
    
   
    dotaciones = @area.get_dotaciones
    fechas = dotaciones.map{|x| x.get_date}
    fecha_base = fechas.min
    fecha_ultima = fechas.max
    @dotacion_efectos = @area.get_dotaciones_efectos

  end
  
  # GET /Avance/{1}
  def show
    @avance = Avance.find(@params['id'])
    if @avance
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Avance/new
  def new
    @avance = Avance.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Avance/{1}/edit
  def edit
    @avance = Avance.find(@params['id'])
    if @avance
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Avance/create
  def create
    @avance = Avance.create(@params['avance'])
    redirect :action => :index
  end

  # POST /Avance/{1}/update
  def update
    @avance = Avance.find(@params['id'])
    @avance.update_attributes(@params['avance']) if @avance
    redirect :action => :index
  end

  # POST /Avance/{1}/delete
  def delete
    @avance = Avance.find(@params['id'])
    @avance.destroy if @avance
    redirect :action => :index  
  end
end
