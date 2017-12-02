class State < ApplicationRecord
  self.table_name = 'cscart_states'
  self.primary_key = :state_id

  has_many :orders
  has_many :state_descriptions
end
