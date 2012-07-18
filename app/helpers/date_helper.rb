require 'date'

module DateHelper
  
  def get_date
    Date.strptime(self.fecha,'%d-%m-%Y')
  end
  
end