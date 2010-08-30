class Ballot < ActiveRecord::Base

  belongs_to :registration

  has_attached_file :pdf, :path => ':rails_root/ballots/:id',
                          :url  => '/' # Disallow external access

end
