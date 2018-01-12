class UpdateTrackingJob < ApplicationJob
  queue_as :default

  def perform(csv_file)
    logger.info('UpdateTrackingJob started')
    CSV.foreach(csv_file.path, headers: true) do |row|
      order_id = row['order_id']
      tracking_no = row['tracking_code']
      tracking_url = row['tracking_url']
    end
    logger.info('UpdateTrackingJob finished')
  end
end
