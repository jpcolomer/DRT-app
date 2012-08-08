require 'rho/rhocontroller'
require 'rho/rhotabbar'
require 'helpers/browser_helper'
require 'helpers/general_helper'

class RiesgoController < Rho::RhoController
  include BrowserHelper
  include GeneralHelper
  
  def pre_index
    Rho::NativeTabbar.switch_tab(2)
  end
  # GET /Riesgo
  def index
    @riesgos = Riesgo.find(:all)
    render :back => '/app'
  end

  # GET /Riesgo/{1}
  def show
    @riesgo = Riesgo.find(@params['id'])
    if @riesgo
      
      @planes_contingencia = PlanContingencia.find(
        :all, 
        :conditions => {
          'riesgo_id' => @riesgo.object})
      
      
#      @planes_contingencia = PlanContingencia.find(
#        :all,
#        :conditions => {
#          {
#            :name => 'riesgo_id',
#            :op => 'LIKE'
#          } => @riesgo.object
#        }
#      )
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Riesgo/new
  def new
    @riesgo = Riesgo.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Riesgo/{1}/edit
  def edit
    @riesgo = Riesgo.find(@params['id'])
    if @riesgo
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Riesgo/create
  def create
    @riesgo = Riesgo.create(@params['riesgo'])
    redirect :action => :index
  end

  # POST /Riesgo/{1}/update
  def update
    @riesgo = Riesgo.find(@params['id'])
    @riesgo.update_attributes(@params['riesgo']) if @riesgo
    redirect :action => :index
  end

  # POST /Riesgo/{1}/delete
  def delete
    @riesgo = Riesgo.find(@params['id'])
    @riesgo.destroy if @riesgo
    redirect :action => :index  
  end
end
