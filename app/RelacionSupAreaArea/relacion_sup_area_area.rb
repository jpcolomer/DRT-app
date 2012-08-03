# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class RelacionSupAreaArea
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with RelacionSupAreaArea.
   enable :sync
  
  #add model specifc code here
  belongs_to :area_id, 'Area'
  belongs_to :sup_area_id, 'SupArea'
end
