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
  
  def get_level_probabilidad
    if self.probabilidad.to_i <= 33
      return "baja"
    elsif self.probabilidad.to_i < 66
      return "media"
    else
      return "alta"
    end
  end  
  
  def get_level_impacto
    if self.impacto.to_i <= 33
      return "bajo"
    elsif self.impacto.to_i < 66
      return "medio"
    else
      return "alto"
    end
  end
  def get_color
    if (self.probabilidad.to_i <= 66 && self.impacto.to_i <= 33) || (self.probabilidad.to_i <= 33 && self.impacto.to_i <= 66)
      return '#14b314'
    elsif (self.probabilidad.to_i >= 33 && self.impacto.to_i >= 66) || (self.probabilidad.to_i >= 66 && self.impacto.to_i >= 33)
      return '#b10f0f'
    else
      return '#f1b30a'
    end
  end
  
  def draw(url = '\#')
    bkg_color = get_color
    x,y = calculate_xy
    html = "<div id=\"#{self.nemo}\" style=\"position: absolute; top: #{y}%; left: #{x}%\">
            <a href=\"#{url}\" style=\"background: #{bkg_color}\">
            <span class=\"matrix-point-title\">#{self.nemo}</span></a></div>"
  end
end
