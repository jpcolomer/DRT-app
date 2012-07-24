# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class PlanContingencia
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with PlanContingencia.
   enable :sync

  #add model specifc code here
  belongs_to :riesgo_id, 'Riesgo'
end
