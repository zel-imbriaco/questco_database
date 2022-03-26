class Adventurer < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :level
  validates_presence_of :party_id
end