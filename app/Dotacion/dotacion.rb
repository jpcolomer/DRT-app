# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Dotacion
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Dotacion.
  # enable :sync

  #add model specifc code here
  
  def get_date
    Date.strptime(self.fecha,'%d-%m-%Y')
  end
end
