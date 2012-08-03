require 'rho/rhocontroller'
require 'helpers/browser_helper'

class RelacionSupAreaAreaController < Rho::RhoController
  include BrowserHelper

  # GET /RelacionSupAreaArea
  def index
    @relacionsupareaareas = RelacionSupAreaArea.find(:all)
    render :back => '/app'
  end

  # GET /RelacionSupAreaArea/{1}
  def show
    @relacionsupareaarea = RelacionSupAreaArea.find(@params['id'])
    if @relacionsupareaarea
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /RelacionSupAreaArea/new
  def new
    @relacionsupareaarea = RelacionSupAreaArea.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /RelacionSupAreaArea/{1}/edit
  def edit
    @relacionsupareaarea = RelacionSupAreaArea.find(@params['id'])
    if @relacionsupareaarea
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /RelacionSupAreaArea/create
  def create
    @relacionsupareaarea = RelacionSupAreaArea.create(@params['relacionsupareaarea'])
    redirect :action => :index
  end

  # POST /RelacionSupAreaArea/{1}/update
  def update
    @relacionsupareaarea = RelacionSupAreaArea.find(@params['id'])
    @relacionsupareaarea.update_attributes(@params['relacionsupareaarea']) if @relacionsupareaarea
    redirect :action => :index
  end

  # POST /RelacionSupAreaArea/{1}/delete
  def delete
    @relacionsupareaarea = RelacionSupAreaArea.find(@params['id'])
    @relacionsupareaarea.destroy if @relacionsupareaarea
    redirect :action => :index  
  end
end
