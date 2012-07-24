require 'date'

module DateHelper
  
  def get_date
    Date.strptime(self.fecha,'%s')
  end
  
end