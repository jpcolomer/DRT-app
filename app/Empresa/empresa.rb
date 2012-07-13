# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
require 'helpers/avance_helper'
class Empresa
  include Rhom::PropertyBag
  include AvanceHelper
  # Uncomment the following line to enable sync with Empresa.
  # enable :sync

  #add model specifc code here
  def get_contratos
    Contrato.find(
      :all, 
      :conditions => {
        'empresa_id' => self.object
      }
    )
  end
end
