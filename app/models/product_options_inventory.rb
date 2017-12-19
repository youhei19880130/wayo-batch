class ProductOptionsInventory < ApplicationRecord
  self.table_name = 'cscart_product_options_inventory'
  self.primary_key = :product_code
end
