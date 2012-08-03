require 'rho/rhocontroller'
require 'helpers/browser_helper'

class SessionController < Rho::RhoController
  include BrowserHelper

  # GET /Session
  def index
    @sessions = Session.find(:all)
    render :back => '/app'
  end

  # GET /Session/{1}
  def show
    @session = Session.find(@params['id'])
    if @session
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Session/new
  def new
    @session = Session.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Session/{1}/edit
  def edit
    @session = Session.find(@params['id'])
    if @session
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Session/create
  def create
    @session = Session.create(@params['session'])
    redirect :action => :index
  end

  # POST /Session/{1}/update
  def update
    @session = Session.find(@params['id'])
    @session.update_attributes(@params['session']) if @session
    redirect :action => :index
  end

  # POST /Session/{1}/delete
  def delete
    @session = Session.find(@params['id'])
    @session.destroy if @session
    redirect :action => :index  
  end
end
