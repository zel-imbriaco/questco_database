class Adventurer < ApplicationRecord
  belongs_to :party
  
  validates_presence_of :name
  validates_presence_of :level
  validates_presence_of :party_id
end