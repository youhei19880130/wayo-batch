class StateDescription < ApplicationRecord
  self.table_name = 'cscart_state_descriptions'
  self.primary_key = :state_id

  has_many :states
end
