
class Party < ApplicationRecord
  has_many :adventurers

  validates_presence_of :name
  validates_presence_of :rank
end