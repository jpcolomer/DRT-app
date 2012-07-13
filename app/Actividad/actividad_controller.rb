require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'date'
require 'json'

class ActividadController < Rho::RhoController
  include BrowserHelper

  # GET /Actividad
  def index
    @actividads = Actividad.find(:all).sort {|x,y| x.get_date <=> y.get_date}
    @semanas = @actividads.map {|x| [x.get_date.cweek, x.get_date.month]}
    render :back => '/app'
  end
  
  def get_semanas_actividad(date)
    mes = date.month
    actividads = Actividad.find(:all).select {|x| x.get_date.month == mes}.sort {|x,y| x.get_date <=> y.get_date}
    puts actividads
    semanas = actividads.map {|x| x.get_date.cweek}.uniq
    min_semanas = semanas.min
    semanas1 = semanas.map do |x|
      actividades_semana = actividads.select{|y| y.get_date.cweek == x }
      nro_actividades = actividades_semana.count
      avance_semana = actividades_semana.map{|y| y.avance.to_f}.reduce(:+)/nro_actividades
      {:avance => avance_semana, :actividades => actividades_semana, :nro_semana =>  x - Date.new(date.year,mes,1).cweek + 1, :nro_actividades => nro_actividades, :mes => mes}
    end
    semanas1
  end
  
  def mes_actual
    date = Date.today
    @semanas = get_semanas_actividad(date)
    @avance_mes = (@semanas.map{|semana| semana[:avance]}.reduce(:+)/@semanas.count).to_i unless @semanas.empty?
    @mes = get_mes_espanol(date.month)
  end
  
  def get_mes_espanol(month)
    dictionary = {1 => 'Enero', 2 => 'Febrero', 3 => 'Marzo', 4 => 'Abril', 5 => 'Mayo', 6 => 'Junio', 7 => 'Julio', 8 => 'Agosto', 9 => 'Septiembre', 10 => 'Octubre', 11 => 'Noviembre', 12 => 'Diciembre'}
    dictionary[month]
  end
  
  def mes_siguiente
    @mes = Date.today.next_month
    @semanas = get_semanas_actividad(@mes)
    @mes = get_mes_espanol(@mes.month)
    
  end
   
  def mostrar_semana
    @semana = Rho::JSON.parse(@params['semana'])
    mes = @semana['mes'].to_i
    @mes = get_mes_espanol(mes)
  end

  # GET /Actividad/{1}
  def show
    @actividad = Actividad.find(@params['id'])
    if @actividad
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Actividad/new
  def new
    @actividad = Actividad.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Actividad/{1}/edit
  def edit
    @actividad = Actividad.find(@params['id'])
    if @actividad
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Actividad/create
  def create
    @actividad = Actividad.create(@params['actividad'])
    redirect :action => :index
  end

  # POST /Actividad/{1}/update
  def update
    @actividad = Actividad.find(@params['id'])
    @actividad.update_attributes(@params['actividad']) if @actividad
    redirect :action => :index
  end

  # POST /Actividad/{1}/delete
  def delete
    @actividad = Actividad.find(@params['id'])
    @actividad.destroy if @actividad
    redirect :action => :index  
  end
end
