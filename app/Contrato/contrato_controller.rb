require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ContratoController < Rho::RhoController
  include BrowserHelper

  # GET /Contrato
  def index
    @contratos = Contrato.find(:all)
    render :back => '/app'
  end

  # GET /Contrato/{1}
  def show
    @contrato = Contrato.find(@params['id'])
    if @contrato
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Contrato/new
  def new
    @contrato = Contrato.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Contrato/{1}/edit
  def edit
    @contrato = Contrato.find(@params['id'])
    if @contrato
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Contrato/create
  def create
    @contrato = Contrato.create(@params['contrato'])
    redirect :action => :index
  end

  # POST /Contrato/{1}/update
  def update
    @contrato = Contrato.find(@params['id'])
    @contrato.update_attributes(@params['contrato']) if @contrato
    redirect :action => :index
  end

  # POST /Contrato/{1}/delete
  def delete
    @contrato = Contrato.find(@params['id'])
    @contrato.destroy if @contrato
    redirect :action => :index  
  end
end
