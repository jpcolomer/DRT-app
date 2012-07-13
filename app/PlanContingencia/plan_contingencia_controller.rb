require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class PlanContingenciaController < Rho::RhoController
  include BrowserHelper

  # GET /PlanContingencia
  def index
    @plancontingencium = PlanContingencia.find(:all)
    render :back => '/app'
  end

  # GET /PlanContingencia/{1}
  def show
    @plancontingencia = PlanContingencia.find(@params['id'])
    if @plancontingencia
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /PlanContingencia/new
  def new
    @riesgo = Riesgo.find(@params['riesgo_id'].to_s) || Riesgo.find(:first)
    @plancontingencia = PlanContingencia.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /PlanContingencia/{1}/edit
  def edit
    @plancontingencia = PlanContingencia.find(@params['id'])
    if @plancontingencia
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /PlanContingencia/create
  def create
    @plancontingencia = PlanContingencia.create(@params['plancontingencia'])
    redirect :action => :index
  end

  # POST /PlanContingencia/{1}/update
  def update
    @plancontingencia = PlanContingencia.find(@params['id'])
    @plancontingencia.update_attributes(@params['plancontingencia']) if @plancontingencia
    redirect :action => :index
  end

  # POST /PlanContingencia/{1}/delete
  def delete
    @plancontingencia = PlanContingencia.find(@params['id'])
    @plancontingencia.destroy if @plancontingencia
    redirect :action => :index  
  end
end
