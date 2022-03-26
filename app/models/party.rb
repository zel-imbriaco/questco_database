
class Party < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :rank
end