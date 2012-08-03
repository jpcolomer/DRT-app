require 'rho/rhocontroller'
require 'helpers/browser_helper'

class SupAreaController < Rho::RhoController
  include BrowserHelper

  # GET /SupArea
  def index
    @supareas = SupArea.find(:all)
    render :back => '/app'
  end

  # GET /SupArea/{1}
  def show
    @suparea = SupArea.find(@params['id'])
    if @suparea
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /SupArea/new
  def new
    @suparea = SupArea.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /SupArea/{1}/edit
  def edit
    @suparea = SupArea.find(@params['id'])
    if @suparea
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /SupArea/create
  def create
    @suparea = SupArea.create(@params['suparea'])
    redirect :action => :index
  end

  # POST /SupArea/{1}/update
  def update
    @suparea = SupArea.find(@params['id'])
    @suparea.update_attributes(@params['suparea']) if @suparea
    redirect :action => :index
  end

  # POST /SupArea/{1}/delete
  def delete
    @suparea = SupArea.find(@params['id'])
    @suparea.destroy if @suparea
    redirect :action => :index  
  end
end
