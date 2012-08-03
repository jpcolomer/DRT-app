# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
require 'helpers/avance_helper'
class SupArea
  include Rhom::PropertyBag
  include AvanceHelper
  # Uncomment the following line to enable sync with SupArea.
   enable :sync

  #add model specifc code here
  
  
  def get_areas
    areas_id = RelacionSupAreaArea.find(
      :all,
      :conditions => {
        'sup_area_id' => self.object
      }
    ).map{|rel| rel.area_id}     
  end
  
  def get_contratos
    Contrato.find(
      :all,
      :conditions => {  
        {
          :name => "area_id",
          :op => "IN"
        } => get_areas
      }
    )
  end
  
  def get_compromisos
    areas = Area.find(
      :all,
      :conditions => {  
        {
          :name => "object",
          :op => "IN"
        } => get_areas
      }
    )
    
    @compromiso_reduccion = areas.map{|area| area.compromiso_reduccion.to_i}.reduce(:+)
    @compromiso_iniciativas = areas.map{|area| area.compromiso_iniciativas.to_i}.reduce(:+)
  end
  
  def compromiso_reduccion
    if @compromiso_reduccion
      return @compromiso_reduccion
    else
      get_compromisos
      return @compromiso_reduccion
    end
#    Area.find(
#      :all,
#      :conditions => {  
#        {
#          :name => "object",
#          :op => "IN"
#        } => get_areas
#      }
#    ).map{|area| area.compromiso_reduccion.to_i}.reduce(:+)
  end

  def compromiso_iniciativas
    if @compromiso_iniciativas
      return @compromiso_iniciatvas
    else
      get_compromisos
      return @compromiso_iniciativas
    end
#    Area.find(
#      :all,
#      :conditions => {  
#        {
#          :name => "object",
#          :op => "IN"
#        } => get_areas
#      }
#    ).map{|area| area.compromiso_iniciativas.to_i}.reduce(:+)
  end
    
end
