# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
require 'date'
class Iniciativa
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Iniciativa.
   enable :sync

  #add model specifc code here
  belongs_to :contrato_id, 'Contrato'
  def get_avance
    avances = AvanceIniciativa.find(
      :all, 
      :conditions => {
        'iniciativa_id' => self.object
      }
    )
    unless avances.empty?
      avances.sort!{|x,y| y.get_date <=> x.get_date}
      return ((avances.first.valor.to_f / self.compromiso.to_f)*100).to_i
    else
      return 0
    end
  end
  
end
