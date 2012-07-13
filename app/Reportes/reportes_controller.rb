require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ReportesController < Rho::RhoController
  include BrowserHelper

  # GET /Reportes
  def index
    @reporteses = Reportes.find(:all)
    render :back => '/app'
  end

  # GET /Reportes/{1}
  def show
    @reportes = Reportes.find(@params['id'])
    if @reportes
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Reportes/new
  def new
    @reportes = Reportes.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Reportes/{1}/edit
  def edit
    @reportes = Reportes.find(@params['id'])
    if @reportes
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Reportes/create
  def create
    @reportes = Reportes.create(@params['reportes'])
    redirect :action => :index
  end

  # POST /Reportes/{1}/update
  def update
    @reportes = Reportes.find(@params['id'])
    @reportes.update_attributes(@params['reportes']) if @reportes
    redirect :action => :index
  end

  # POST /Reportes/{1}/delete
  def delete
    @reportes = Reportes.find(@params['id'])
    @reportes.destroy if @reportes
    redirect :action => :index  
  end
end
