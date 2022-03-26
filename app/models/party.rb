
class Party < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :rank
  validates_presence_of :active
end