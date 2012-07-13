# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Contrato
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Contrato.
  # enable :sync

  #add model specifc code here
  
  def get_iniciativas
    Inciativa.find(
      :all, 
      :conditions => {
        'contrato_id' => self.object
      }
    )
  end
  
  def get_dotaciones
    Dotacion.find(
      :all,
      :conditions => {
        'contrato_id' => self.object
      }
    )
  end
end
