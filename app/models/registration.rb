require 'digest/sha1'

class Registration < ActiveRecord::Base

  validates :pin_hash, :presence => true
  
  def self.match(r)
    self.where(:name => r[:name], :pin_hash => Digest::SHA1.hexdigest(r[:pin]), :zip => r[:zip], :voter_id => r[:voter_id]).first
  end

  def pin=(v)
    self.pin_hash = Digest::SHA1.hexdigest(v)
  end

end
