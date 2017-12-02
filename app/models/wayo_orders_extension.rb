class WayoOrdersExtension < ApplicationRecord
  self.table_name = 'cscart_wayo_orders_extension'
  self.primary_key = :order_id

  has_many :orders
end
