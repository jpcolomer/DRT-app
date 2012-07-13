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
        "compromiso_reduccion" => "30",
        "compromiso_iniciativas" => "10"
      }
      @area1 = Area.create(vars)
      vars = {
        "nombre" => "Planta",
        "compromiso_reduccion" => "40",
        "compromiso_iniciativas" => "15"
      }
      @area2 = Area.create(vars)
    end
#    @contratos = Contacto.find(:all)
#    if !@contratos && @contratos.empty?
      vars = {
        "empresa_id" => @empresa1.object,
        "area_id" => @area1.object
      }
      @contrato1 = Contrato.create(vars)
      vars = {
        "empresa_id" => @empresa2.object,
        "area_id" => @area2.object
      }
      @contrato2 = Contrato.create(vars)
#    end
    @dotaciones = Dotacion.find(:all)
    if @dotaciones && @dotaciones.empty?
      vars = {
        "contrato_id" => @contrato1.object,
        "fecha" => "01-01-2012",
        "empleados" => "30",
        "recategorizacion" => "1",
        "gestion_dotacional" => "2",
        "nuevos_ingresos_egresos" => "1"
      }
      @dotacion1 = Dotacion.create(vars)
      vars = {
        "contrato_id" => @contrato1.object,
        "fecha" => "01-04-2012",
        "empleados" => "25",
        "recategorizacion" => "2",
        "gestion_dotacional" => "2",
        "nuevos_ingresos_egresos" => "1"
      }
      @dotacion2 = Dotacion.create(vars)
      vars = {
        "contrato_id" => @contrato1.object,
        "fecha" => "01-06-2012",
        "empleados" => "22",
        "recategorizacion" => "0",
        "gestion_dotacional" => "2",
        "nuevos_ingresos_egresos" => "1"
      }
      @dotacion3 = Dotacion.create(vars)
    end
    
    
  end
  
  def pluralize(word,nro)
    nro > 1 ? word + 'es' : word 
  end

end
