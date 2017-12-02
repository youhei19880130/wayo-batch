class OrderDetail < ApplicationRecord
  self.table_name = 'cscart_order_details'
  self.primary_key = :item_id

  belongs_to :order
  belongs_to :product_description, foreign_key: :product_id
end
