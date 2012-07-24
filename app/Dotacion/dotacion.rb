# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
require 'helpers/date_helper.rb'
class Dotacion
  include Rhom::PropertyBag
  include DateHelper
  # Uncomment the following line to enable sync with Dotacion.
   enable :sync

  #add model specifc code here
  belongs_to :contrato_id, 'Contrato'
end
