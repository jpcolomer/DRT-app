require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    #To remove default toolbar uncomment next line:
    #@@toolbar = nil
    super

    # Uncomment to set sync notification callback to /app/Settings/sync_notify.
    # SyncEngine::set_objectnotify_url("/app/Settings/sync_notify")
    SyncEngine.set_notification(-1, "/app/Settings/sync_notify", '')
    
    @empresas = Empresa.find(:all)
    if @empresas && @empresas.empty?
      vars = {
        "nombre" => "Siemmens",
        "responsable" => "Juanito Siemmens"
      }
      @empresa1 = Empresa.create(vars)
      vars = {
        "nombre" => "Bechtel",
        "responsable" => "Pedro Bechtel"
      }
      @empresa2 = Empresa.create(vars)
    end
    @areas = Area.find(:all)
    if @areas && @areas.empty?
      vars = {
        "nombre" => "Mina",
        "compromiso_reduccion" => "150",
        "compromiso_iniciativas" => "20"
      }
      @area1 = Area.create(vars)
      vars = {
        "nombre" => "Planta",
        "compromiso_reduccion" => "70",
        "compromiso_iniciativas" => "15"
      }
      @area2 = Area.create(vars)
    end
    @contratos = Contrato.find(:all)
    if @contratos && @contratos.empty?
      vars = {
        "empresa_id" => @empresa1.object,
        "area_id" => @area1.object
      }
      @contrato1 = Contrato.create(vars)
      vars = {
        "empresa_id" => @empresa2.object,
        "area_id" => @area2.object
      }
      @contrato3 = Contrato.create(vars)
      vars = {
        "empresa_id" => @empresa2.object,
        "area_id" => @area1.object
      }
      @contrato2 = Contrato.create(vars)
    end
    
    @dotaciones = Dotacion.find(:all)
    if @dotaciones && @dotaciones.empty?
      vars = {
        "contrato_id" => @contrato1.object,
        "fecha" => "01-01-2012",
        "empleados" => "1500",
        "recategorizacion" => "0",
        "gestion_dotacional" => "0",
        "nuevos_ingresos_egresos" => "0"
      }
      @dotacion1 = Dotacion.create(vars)
      vars = {
        "contrato_id" => @contrato1.object,
        "fecha" => "01-04-2012",
        "recategorizacion" => "-6",
        "gestion_dotacional" => "-10",
        "nuevos_ingresos_egresos" => "-15"
      }
      vars["empleados"] = (@dotacion1.empleados.to_i + vars["recategorizacion"].to_i + vars["gestion_dotacional"].to_i + vars["nuevos_ingresos_egresos"].to_i).to_s
      @dotacion2 = Dotacion.create(vars)
      vars = {
        "contrato_id" => @contrato1.object,
        "fecha" => "01-06-2012",
        "recategorizacion" => "0",
        "gestion_dotacional" => "-30",
        "nuevos_ingresos_egresos" => "-10"
      }
      vars["empleados"] = (@dotacion2.empleados.to_i + vars["recategorizacion"].to_i + vars["gestion_dotacional"].to_i + vars["nuevos_ingresos_egresos"].to_i).to_s
      @dotacion3 = Dotacion.create(vars)
      vars = {
        "contrato_id" => @contrato2.object,
        "fecha" => "01-01-2012",
        "empleados" => "1600",
        "recategorizacion" => "0",
        "gestion_dotacional" => "0",
        "nuevos_ingresos_egresos" => "0"
      }
      @dotacion1 = Dotacion.create(vars)
      vars = {
        "contrato_id" => @contrato2.object,
        "fecha" => "01-04-2012",
        "recategorizacion" => "-6",
        "gestion_dotacional" => "-10",
        "nuevos_ingresos_egresos" => "-15"
      }
      vars["empleados"] = (@dotacion1.empleados.to_i + vars["recategorizacion"].to_i + vars["gestion_dotacional"].to_i + vars["nuevos_ingresos_egresos"].to_i).to_s
      @dotacion2 = Dotacion.create(vars)
      vars = {
        "contrato_id" => @contrato2.object,
        "fecha" => "01-06-2012",
        "recategorizacion" => "0",
        "gestion_dotacional" => "-30",
        "nuevos_ingresos_egresos" => "-10"
      }
      vars["empleados"] = (@dotacion2.empleados.to_i + vars["recategorizacion"].to_i + vars["gestion_dotacional"].to_i + vars["nuevos_ingresos_egresos"].to_i).to_s
      @dotacion3 = Dotacion.create(vars)
    end
    
    @iniciativas = Iniciativa.find(:all)
    if @iniciativas && @iniciativas.empty?
      vars = {
        "contrato_id" => @contrato1.object,
        "fecha" => "01-01-2012",
        "compromiso" => "50",
      }
      @iniciativa1 = Iniciativa.create(vars)
      vars = {
        "contrato_id" => @contrato2.object,
        "fecha" => "01-01-2012",
        "compromiso" => "40",
      }
      @iniciativa2 = Iniciativa.create(vars)
      vars = {
        "contrato_id" => @contrato2.object,
        "fecha" => "01-05-2012",
        "compromiso" => "30",
      }
      @iniciativa3 = Iniciativa.create(vars)
    end
    
    @avance_iniciativas = AvanceIniciativa.find(:all)
    if @avance_iniciativas && @avance_iniciativas.empty?
      vars = {
        "iniciativa_id" => @iniciativa1.object,
        "fecha" => "01-04-2012",
        "valor" => "5",
      }
      @avance_iniciativa1 = AvanceIniciativa.create(vars)
      vars = {
        "iniciativa_id" => @iniciativa1.object,
        "fecha" => "01-05-2012",
        "valor" => "50",
      }
      @avance_iniciativa2 = AvanceIniciativa.create(vars)
      vars = {
        "iniciativa_id" => @iniciativa2.object,
        "fecha" => "01-02-2012",
        "valor" => "5",
      }
      @avance_iniciativa3 = AvanceIniciativa.create(vars)    
      vars = {
        "iniciativa_id" => @iniciativa2.object,
        "fecha" => "01-04-2012",
        "valor" => "10",
      }
      @avance_iniciativa3 = AvanceIniciativa.create(vars)      
      vars = {
        "iniciativa_id" => @iniciativa2.object,
        "fecha" => "01-05-2012",
        "valor" => "15",
      }
      @avance_iniciativa4 = AvanceIniciativa.create(vars)  
    end
    
    
    @actividades = Actividad.find(:all)
    if @actividades && @actividades.empty?
      vars = {
        "nombre" => "Actividad 1",
        "responsable" => "Pedro Actividad 1",
        "avance" => "60",
        "fecha_inicio" => "01-07-2012",
        "fecha_fin" => "30-07-2012"
      }
      Actividad.create(vars)
    end
    
    @riesgos = Riesgo.find(:all)
    if @riesgos && @riesgos.empty?
      vars = {
        "nemo" => "R001",
        "probabilidad" => "75",
        "impacto" => "30",
        "descripcion" => "descripcion R001",
      }
      @riesgo1 = Riesgo.create(vars)
      vars = {
        "nemo" => "R002",
        "probabilidad" => "35",
        "impacto" => "80",
        "descripcion" => "descripcion R002",
      }
      @riesgo2 = Riesgo.create(vars)   
      
    end

    @planes_contingencia = PlanContingencia.find(:all)
    if @planes_contingencia && @planes_contingencia.empty?
      vars = {
        "riesgo_id" => @riesgo1.object,
        "descripcion" => "descripcion plan de contingencia R001",
      }
      PlanContingencia.create(vars)
      vars = {
        "riesgo_id" => @riesgo2.object,
        "descripcion" => "descripcion plan de contingencia R002",
      }
      PlanContingencia.create(vars)  
      
    end    
  end
  
  def pluralize(word,nro)
    nro > 1 ? word + 'es' : word 
  end
  

end
