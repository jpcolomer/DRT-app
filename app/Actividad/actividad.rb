# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Actividad
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Actividad.
  # enable :sync

  #add model specifc code here
  
  def get_date
    Date.strptime(self.fecha_inicio,'%d-%m-%Y')
  end
  
  def get_week
    get_date.cweek
  end
  
end
