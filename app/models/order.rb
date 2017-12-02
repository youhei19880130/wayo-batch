class Order < ApplicationRecord
  self.table_name = 'cscart_orders'
  self.primary_key = :order_id

  has_many :order_details
  has_many :states, primary_key: :s_state, foreign_key: :code
  has_many :wayo_orders_extensions, foreign_key: :order_id

  scope :during_yesterday, -> { where(timestamp: [Time.now.yesterday.beginning_of_day.to_i..Time.now.yesterday.end_of_day.to_i]) }
end
