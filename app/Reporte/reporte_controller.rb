require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'helpers/application_helper'

class ReporteController < Rho::RhoController
  include ApplicationHelper
  include BrowserHelper

  def pre_index
    Rho::NativeTabbar.switch_tab(4)
  end
  
  # GET /Reporte
  def index
    @reportes = Reporte.find(:all)
    render :back => '/app'
  end

  def lista_reporte
    @tipo = ['mensuales', 'semanales'][@params['tipo'].to_i]
    @reportes = Reporte.find(
      :all,
      :conditions => {
        'tipo' => ['false', 'true'][@params['tipo'].to_i]
      }
    )
    
  end

  def delete_file
    @reporte = Reporte.find(@params['id'])
  end
  
    
  def do_delete_file
    reporte = Reporte.find(@params['id'])
    file_name = reporte.get_file_location
    File.delete(file_name)
    tipos = {'false' => 0, 'true' => 1}
    WebView.navigate url_for(:action => :lista_reporte, :query => {:tipo => tipos[reporte.tipo]})
  end
  
  def download_file
    if System.get_property('has_network')
      reporte = Reporte.find(@params['id'])
      file_name = reporte.get_file_location
      File.delete(file_name) if reporte.is_downloaded?
      url = "#{reporte.url}?auth_token=#{Session.find(:first).token}"
   
      
      
      Rho::AsyncHttp.download_file(
        :url => url,
        :filename => file_name,
        :headers => {},
        :callback => url_for(:action => :download_callback),
        :callback_param => "tipo=#{reporte.tipo}"
      )
      @response['headers']['Wait-Page'] = 'true'
      render :action => :wait
    else
      Alert.show_popup 'No hay acceso a internet'
      redirect :action => :index
    end
  end
  
  def download_callback
    Alert.show_popup @params.inspect
    if @params["status"] == "ok"
      tipos = {'false' => 0, 'true' => 1}
      WebView.navigate url_for(:action => :lista_reporte, :query => {:tipo => tipos[@params['tipo']]})  
    else
      WebView.navigate url_for(:action => :index)
    end
  end
  # GET /Reporte/{1}
  def show
    @reporte = Reporte.find(@params['id'])
    if @reporte
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Reporte/new
  def new
    @reporte = Reporte.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Reporte/{1}/edit
  def edit
    @reporte = Reporte.find(@params['id'])
    if @reporte
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Reporte/create
  def create
    @reporte = Reporte.create(@params['reporte'])
    redirect :action => :index
  end

  # POST /Reporte/{1}/update
  def update
    @reporte = Reporte.find(@params['id'])
    @reporte.update_attributes(@params['reporte']) if @reporte
    redirect :action => :index
  end

  # POST /Reporte/{1}/delete
  def delete
    @reporte = Reporte.find(@params['id'])
    @reporte.destroy if @reporte
    redirect :action => :index  
  end
  
  def open_file
    reporte = Reporte.find(@params['id'])
    file_name = reporte.get_file_location
    System.open_url(file_name)
#    tipos = {'false' => 0, 'true' => 1}
#    redirect :controller => :Reporte, :action => :index 
  end
end
