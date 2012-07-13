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
  
  def get_dotacion(fecha)
    fecha = fecha.strftime('%d-%m-%Y')
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
        } => fecha
      } 
    )
    dotacion.empleados.to_i
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
      if x.get_date <= fecha
        recategorizacion += dotacion.recategorizacion.to_i
        gestion_dotacional += dotacion.gestion_dotacional.to_i
        nuevos_ingresos_egresos += dotacion.nuevos_ingresos_egresos.to_i
      end
    end
    {:recategorizacion => recategorizacion, :gestion_dotacional => gestion_dotacional, :nuevos_ingresos_egresos => nuevos_ingresos_egresos}
  end
  
  def get_dotaciones_efectos
    dotaciones = get_dotaciones
    fechas = dotaciones.map{|x| x.get_date}.uniq
    fecha_base = fechas.min
    fecha_ultima = fechas.max
    dotacion_base = dotaciones.select{|x| x.get_date === fecha_base}.map{|x| x.empleados.to_i}.reduce(:+)
    dotacion_actual = dotaciones.select{|x| x.get_date === fecha_ultima}.map{|x| x.empleados.to_i}.reduce(:+)
    recategorizacion = 0
    gestion_dotacional = 0
    nuevos_ingresos_egresos = 0
    
    dotaciones.each do |dotacion|
      if x.get_date <= fecha
        recategorizacion += dotacion.recategorizacion.to_i
        gestion_dotacional += dotacion.gestion_dotacional.to_i
        nuevos_ingresos_egresos += dotacion.nuevos_ingresos_egresos.to_i
      end
    end    
    {:fecha_base => fecha_base.strftime('%d-%m-%Y'), :fecha_ultima => fecha_ultima.strftime('%d-%m-%Y'), :dotacion_base => dotacion_base, :dotacion_actual => dotacion_actual,:recategorizacion => recategorizacion, :gestion_dotacional => gestion_dotacional, :nuevos_ingresos_egresos => nuevos_ingresos_egresos}
  end
end