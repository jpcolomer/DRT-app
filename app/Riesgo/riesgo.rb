# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Riesgo
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Riesgo.
  # enable :sync

  #add model specifc code here
  SCREEN_WIDTH = 321
  
  def calculate_xy
    
    x = self.impacto.to_i
    y = 100 - self.probabilidad.to_i
    [x,y]
  end
  
  def draw(bkg_color = '#fff', url = '\#')
    x,y = calculate_xy
    html = "<div id=\"#{self.nemo}\" style=\"position: absolute; top: #{y}%; left: #{x}%\">
            <a href=\"#{url}\" style=\"background: #{bkg_color}\">
            <span class=\"matrix-point-title\">#{self.nemo}</span></a></div>"
  end
end
