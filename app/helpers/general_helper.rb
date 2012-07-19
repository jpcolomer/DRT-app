
module GeneralHelper
  def get_color_from_percentage(percentage)
    rojo_max = 33
    amarillo_max = 66
    if percentage <= rojo_max
      return "rojo"
    elsif percentage < amarillo_max
      return "amarillo"
    else
      return "verde"
    end
  end  
end