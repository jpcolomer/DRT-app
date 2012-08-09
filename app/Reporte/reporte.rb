# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
require 'helpers/date_helper.rb'
class Reporte
  include Rhom::PropertyBag
  include DateHelper
  # Uncomment the following line to enable sync with Reporte.
  enable :sync

  #add model specifc code here
  def get_date_actualizacion
    Date.strptime(self.fecha_actualizacion,'%s')
  end
  
  def get_tipo
    if self.tipo.eql?(false.to_s)
      return 'mensual'
    elsif self.tipo.eql?(true.to_s)
      return 'semanal'
    end
  end
  

  def get_file_location
    directory = File.join(Rho::RhoApplication::get_user_path(),'pdfs',"#{self.get_tipo}")
    fileName = File.join(directory,"#{self.file_name}.pdf")
  end
  
  def is_downloaded?
    fileName =  get_file_location
    File.exists?(fileName)
    
#    begin 
#      File.open(fileName)
#      return true
#    rescue
#      return false
#    end
  end
  
  def file_updated?
    File.mtime(get_file_location).to_date >=  get_date_actualizacion
  end
  
end
