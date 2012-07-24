require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ReporteController < Rho::RhoController
  include BrowserHelper

  # GET /Reporte
  def index
    @reportes = Reporte.find(:all)
    render :back => '/app'
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
  
  def open_external_pdf
    pdf_path = File.join(Rho::RhoApplication::get_base_app_path(), 'public', 'pdfs', 'device-caps.pdf')
    System.open_url(pdf_path)
    redirect :action => :index
  end
  
end
