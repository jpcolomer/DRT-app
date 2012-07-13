require 'rho/rhocontroller'
require 'helpers/browser_helper'

class EmpresaController < Rho::RhoController
  include BrowserHelper

  # GET /Empresa
  def index
    @empresas = Empresa.find(:all)
    render :back => '/app'
  end

  # GET /Empresa/{1}
  def show
    @empresa = Empresa.find(@params['id'])
    if @empresa
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Empresa/new
  def new
    @empresa = Empresa.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Empresa/{1}/edit
  def edit
    @empresa = Empresa.find(@params['id'])
    if @empresa
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Empresa/create
  def create
    @empresa = Empresa.create(@params['empresa'])
    redirect :action => :index
  end

  # POST /Empresa/{1}/update
  def update
    @empresa = Empresa.find(@params['id'])
    @empresa.update_attributes(@params['empresa']) if @empresa
    redirect :action => :index
  end

  # POST /Empresa/{1}/delete
  def delete
    @empresa = Empresa.find(@params['id'])
    @empresa.destroy if @empresa
    redirect :action => :index  
  end
end
