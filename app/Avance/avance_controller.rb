require 'rho/rhocontroller'
require 'rho/rhotabbar'
require 'helpers/browser_helper'
require 'helpers/general_helper'

class AvanceController < Rho::RhoController
  include BrowserHelper
  include GeneralHelper
  
  def pre_index
    Rho::NativeTabbar.switch_tab(1)
  end
  # GET /Avance
  def index
    if @params[:dato]
      @dato = @params[:dato].to_sym
    else
      @dato = :empleados
    end
    render :back => '/app'
  end

  def tipo_dato    
    @area_empresa = @params['area_empresa'].to_sym
    @dato = @params['dato'].to_sym
    @id = @params['id']
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
      if @params['is_sup_area']
        @area = SupArea.find(@params['id'])
      else
        @area = Area.find(@params['id'])
      end
    else
      @area = SupArea.find(:first)
    end
    @dato = @params['dato'].to_sym
    @tipo_dato = {:empleados => 'N&deg; personas', :fte => 'FTE'}[@dato]
    @dotacion_efectos = @area.get_dotaciones_efectos :dato => @dato
    @iniciativas_avance = @area.get_iniciativas_realizadas_avance
    @fecha_base = Date.strptime(@dotacion_efectos[:fecha_base],'%d-%m-%Y').strftime('%b %Y').downcase
    @p_recat = (@dotacion_efectos[:recategorizacion].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_g_dot = (@dotacion_efectos[:gestion_dotacional].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_ingr_egre = (@dotacion_efectos[:nuevos_ingresos_egresos].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_avance = ((@dotacion_efectos[:dotacion_actual].to_f/@dotacion_efectos[:dotacion_base].to_f - 1) * 100).to_i
    compromiso_iniciativas = @area.compromiso_iniciativas 
    compromiso_reduccion =  @area.compromiso_reduccion   
    @avance_g_dot_compromiso = (@dotacion_efectos[:gestion_dotacional].abs.to_f/compromiso_reduccion.to_f*100).to_i
    @avance_iniciativas_compromiso = (@iniciativas_avance[:iniciativas_realizadas].abs.to_f/compromiso_iniciativas.to_f*100).to_i
    @compromiso_dot_base = (compromiso_reduccion.to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
  end
  
  def lista_areas
    @areas =  Area.find(:all)
    @sup_areas = SupArea.find(:all)
    @dato = @params['dato'].to_sym
  end

  def empresa
    
    if @params['id']   
      @empresa = Empresa.find(@params['id'])
    else
      @empresa = Empresa.find(:first)
    end
    @dato = @params['dato'].to_sym
    @tipo_dato = {:empleados => 'N&deg; personas', :fte => 'FTE'}[@dato]
    @dotacion_efectos = @empresa.get_dotaciones_efectos :dato => @dato
    @iniciativas_comprometidas = @empresa.get_iniciativas.count
    @fecha_base = Date.strptime(@dotacion_efectos[:fecha_base],'%d-%m-%Y').strftime('%b %Y').downcase
    @p_recat = (@dotacion_efectos[:recategorizacion].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_g_dot = (@dotacion_efectos[:gestion_dotacional].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_ingr_egre = (@dotacion_efectos[:nuevos_ingresos_egresos].to_f/@dotacion_efectos[:dotacion_base].to_f*100).to_i
    @p_avance = ((@dotacion_efectos[:dotacion_actual].to_f/@dotacion_efectos[:dotacion_base].to_f - 1) * 100).to_i
  end
  
  def lista_empresas
    @empresas =  Empresa.find(:all)
    @dato = @params['dato'].to_sym
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
