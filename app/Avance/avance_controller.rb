require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/general_helper'

class AvanceController < Rho::RhoController
  include BrowserHelper
  include GeneralHelper
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
    
    if @params['id']   
      @area = Area.find(@params['id'])
    else
      @area = Area.find(:first)
    end
    @dotacion_efectos = @area.get_dotaciones_efectos
    @iniciativas_avance = @area.get_iniciativas_realizadas_avance
    @fecha_base = Date.strptime(@dotacion_efectos[:fecha_base],'%d-%m-%Y').strftime('%b %Y').downcase
    @p_recat = (@dotacion_efectos[:recategorizacion].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_g_dot = (@dotacion_efectos[:gestion_dotacional].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_ingr_egre = (@dotacion_efectos[:nuevos_ingresos_egresos].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_avance = ((@dotacion_efectos[:dotacion_actual].to_f/@dotacion_efectos[:dotacion_base].to_f - 1) * 100).to_i
    @avance_g_dot_compromiso = (@dotacion_efectos[:gestion_dotacional].abs.to_f/@area.compromiso_reduccion.to_f*100).to_i
    @avance_iniciativas_compromiso = (@iniciativas_avance[:iniciativas_realizadas].abs.to_f/@area.compromiso_iniciativas.to_f*100).to_i
    @compromiso_dot_base = (@area.compromiso_reduccion.to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
  end
  
  def lista_areas
    @areas =  Area.find(:all)
  end

  def empresa
    
    if @params['id']   
      @empresa = Empresa.find(@params['id'])
    else
      @empresa = Empresa.find(:first)
    end
    @dotacion_efectos = @empresa.get_dotaciones_efectos
    @iniciativas_comprometidas = @empresa.get_iniciativas.count
    @fecha_base = Date.strptime(@dotacion_efectos[:fecha_base],'%d-%m-%Y').strftime('%b %Y')
    @p_recat = (@dotacion_efectos[:recategorizacion].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_g_dot = (@dotacion_efectos[:gestion_dotacional].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_ingr_egre = (@dotacion_efectos[:nuevos_ingresos_egresos].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_avance = ((@dotacion_efectos[:dotacion_actual].to_f/@dotacion_efectos[:dotacion_base].to_f - 1) * 100).to_i
  end
  
  def lista_empresas
    @empresas =  Empresa.find(:all)
  end  
  
    
  def get_color_cuadro(valor)
    if valor <= 0
      return "verde"
    else
      return "rojo"
    end
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
