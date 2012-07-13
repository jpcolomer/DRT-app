require 'rho/rhocontroller'
require 'helpers/browser_helper'

class AreaController < Rho::RhoController
  include BrowserHelper

  # GET /Area
  def index
    @areas = Area.find(:all)
    render :back => '/app'
  end

  # GET /Area/{1}
  def show
    @area = Area.find(@params['id'])
    if @area
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Area/new
  def new
    @area = Area.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Area/{1}/edit
  def edit
    @area = Area.find(@params['id'])
    if @area
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Area/create
  def create
    @area = Area.create(@params['area'])
    redirect :action => :index
  end

  # POST /Area/{1}/update
  def update
    @area = Area.find(@params['id'])
    @area.update_attributes(@params['area']) if @area
    redirect :action => :index
  end

  # POST /Area/{1}/delete
  def delete
    @area = Area.find(@params['id'])
    @area.destroy if @area
    redirect :action => :index  
  end
end
