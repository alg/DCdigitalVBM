require 'digest/sha1'

class Registration < ActiveRecord::Base

  belongs_to :precinct_split
  
  validates :pin_hash, :presence => true
  validates :precinct_split_id, :presence => true
  
  def self.match(r)
    self.where(:name => r[:name], :pin_hash => Digest::SHA1.hexdigest(r[:pin]), :zip => r[:zip], :voter_id => r[:voter_id]).first
  end

  def pin=(v)
    self.pin_hash = Digest::SHA1.hexdigest(v)
  end

  # Returns the blank ballot PDF
  def blank_ballot
    precinct_split.try(:ballot_style).try(:pdf)
  end
  
end
