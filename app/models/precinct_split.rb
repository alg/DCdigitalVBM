class PrecinctSplit < ActiveRecord::Base
  
  belongs_to :precinct
  
  validates :precinct_id, :presence => true

end
