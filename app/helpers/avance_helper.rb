require 'date'
module AvanceHelper
  
  def get_contratos
    Contrato.find(
      :all, 
      :conditions => {
        'area_id' => self.object
      }
    )
  end
  
  def get_dotaciones
    Dotacion.find(
      :all,
      :conditions => {  
        {
          :name => "contrato_id",
          :op => "IN"
        } => get_contratos.map{|x| x.object}
      }
    )
  end
  
  def get_fecha_base
    get_dotaciones.map {|x| x.get_date}.min
  end
  
  def get_ultima_fecha
    get_dotaciones.map {|x| x.get_date}.max
  end
  
  def get_dotacion(fecha, tipo_dato_hash = {:dato => :empleados})
    fecha_tmp = fecha.strftime('%d-%m-%Y')
    dotacion = Dotacion.find(
      :all,
      :conditions => {
        {
          :name => "contrato_id",
          :op => "IN"
        } => get_contratos.map{|x| x.object},
        {
          :name => "fecha",
          :op => "LIKE"
        } => fecha_tmp
      } 
    )
    if tipo_dato_hash[:dato] == :empleados
      return dotacion.map{|x| x.empleados.to_i}.reduce(:+)
    elsif tipo_dato_hash[:dato] == :fte
      return dotacion.map{|x| x.fte.to_i}.reduce(:+)
    end
    
  end
  
  def get_dotacion_base
    get_dotacion(get_fecha_base)
  end
  
  def get_dotacion_actual
    get_dotacion(get_ultima_fecha)
  end
  
  def get_efectos(fecha)
    recategorizacion = 0
    gestion_dotacional = 0
    nuevos_ingresos_egresos = 0
    get_dotaciones.each do |dotacion|
      if dotacion.get_date <= fecha
        recategorizacion += dotacion.recategorizacion.to_i
        gestion_dotacional += dotacion.gestion_dotacional.to_i
        nuevos_ingresos_egresos += dotacion.nuevos_ingresos_egresos.to_i
      end
    end
    {:recategorizacion => recategorizacion, :gestion_dotacional => gestion_dotacional, :nuevos_ingresos_egresos => nuevos_ingresos_egresos}
  end
  
  def get_iniciativas
    Iniciativa.find(
      :all,
      :conditions => {  
        {
          :name => "contrato_id",
          :op => "IN"
        } => get_contratos.map{|x| x.object}
      }
    )    
  end
  
  def get_dotaciones_efectos(tipo_dato_hash = {:dato => :empleados})
    dotaciones = get_dotaciones
    unless dotaciones.empty?
      fechas = dotaciones.map{|x| x.get_date}
      fecha_base = fechas.min
      fecha_ultima = fechas.max
      
      recategorizacion = 0
      gestion_dotacional = 0
      nuevos_ingresos_egresos = 0
      
      if tipo_dato_hash[:dato] == :empleados
        dotacion_base = dotaciones.select{|x| x.get_date == fecha_base}.map{|x| x.empleados.to_i}.reduce(:+)
          
          dotaciones.each do |dotacion|
            if dotacion.get_date <= fecha_ultima
              recategorizacion += dotacion.recategorizacion.to_i
              gestion_dotacional += dotacion.gestion_dotacional.to_i
              nuevos_ingresos_egresos += dotacion.nuevos_ingresos_egresos.to_i
            end
          end
          
      elsif tipo_dato_hash[:dato] == :fte
        dotacion_base = dotaciones.select{|x| x.get_date == fecha_base}.map{|x| x.fte.to_i}.reduce(:+)
         
        dotaciones.each do |dotacion|
          if dotacion.get_date <= fecha_ultima
            recategorizacion += dotacion.recategorizacion_fte.to_i
            gestion_dotacional += dotacion.gestion_dotacional_fte.to_i
            nuevos_ingresos_egresos += dotacion.nuevos_ingresos_egresos_fte.to_i
          end
        end 
          
      end
        
      dotacion_actual = dotacion_base + recategorizacion + gestion_dotacional + nuevos_ingresos_egresos
      
      return {:fecha_base => fecha_base.strftime('%d-%m-%Y'), :fecha_ultima => fecha_ultima.strftime('%d-%m-%Y'), :dotacion_base => dotacion_base, :dotacion_actual => dotacion_actual,:recategorizacion => recategorizacion, :gestion_dotacional => gestion_dotacional, :nuevos_ingresos_egresos => nuevos_ingresos_egresos}
    else
      return {:fecha_base => Date.today.strftime('%d-%m-%Y'), :fecha_ultima => Date.today.strftime('%d-%m-%Y'), :dotacion_base => -100, :dotacion_actual => -100,:recategorizacion => 0, :gestion_dotacional => 0, :nuevos_ingresos_egresos => 0}
    end
  end
  
  def get_iniciativas_realizadas
    get_iniciativas.select{|iniciativa| iniciativa.get_avance == 100}.count
  end
  
  def get_iniciativas_realizadas_avance
    iniciativas = get_iniciativas
    unless iniciativas.empty?
      iniciativas_realizadas = iniciativas.select{|iniciativa| iniciativa.get_avance == 100}.count
      avance = iniciativas.map{|iniciativa| iniciativa.get_avance}.reduce(:+)
      return {:iniciativas_realizadas => iniciativas_realizadas, :avance => avance}
    else
      return {:iniciativas_realizadas => 0, :avance => 0}
    end
  end
  
  
  def get_color_from_efecto(efecto)
    valor_divisor = 0
    if efecto > valor_divisor
      return "rojo"
    else
      return "verde"
    end  
  end
end