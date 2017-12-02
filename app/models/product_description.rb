class ProductDescription < ApplicationRecord
  self.table_name = 'cscart_product_descriptions'
  self.primary_key = :product_id

  has_many :order_details
end
