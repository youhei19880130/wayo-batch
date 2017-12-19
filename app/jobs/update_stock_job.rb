class UpdateStockJob < ApplicationJob
  queue_as :default

  def perform(csv_file)
    logger.info('UpdateStockJob started')
    error_count = 0
    CSV.foreach(csv_file.path, headers: true) do |row|
      next if row['total stock count'] == '0'
      sku_no = row['sku_no']
      stock = row['available stock count'].to_i

      unless update_stock(sku_no, stock)
        error_count += 1
      end
    end
    logger.info("UpdateStockJob finishedi. error: #{error_count}")
  end

  private

  def update_stock(sku_no, stock)
    if Product.where(product_code: sku_no, tracking: 'B').exists?
      target = Product.find_by(product_code: sku_no)
    else
      target = ProductOptionsInventory.find_by(product_code: sku_no)
    end
    stock_before = target.amount
    
    return true if stock_before == stock

    target.amount = stock
    if target.save
      logger.info("[UPDATED] sku_no: #{sku_no}, from: #{stock_before}, to: #{stock}")
    else
      logger.error("[ERROR] sku_no: #{sku_no}")
    end
    return true
  rescue => e
    logger.error("UpdateStockJob: #{e}(sku_no: #{sku_no})")
    return false
  end
end
