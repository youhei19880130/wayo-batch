class Product < ApplicationRecord
  self.table_name = 'cscart_products'
  self.primary_key = :product_id

  has_many :product_options_inventories
end
