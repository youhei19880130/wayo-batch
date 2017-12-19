class SendOrderInfoJob < ApplicationJob
  queue_as :default

  def perform
    logger.info('SendOrderInfoJob started.')
    records = []
    Order.during_yesterday.each do |order|
      next if order.details.present?
      order_id = format_order_id(order.order_id)
      email = order.email
      to_name = "#{order.s_firstname}#{order.s_lastname}"
      from_name = "#{order.b_firstname}#{order.b_lastname}"
      country = order.s_country
      zipcode = order.s_zipcode
      state = order.states.find_by(country_code: 'JP').state_descriptions.find_by(lang_code: 'ja').state
      city = order.s_city
      address = order.s_address
      address_2 = order.s_address_2
      tel = order.s_phone
      timestamp = order.timestamp

      order.order_details.each do |o|
        # TODO: type
        # FIXME: sku_name
        # TODO: note...同じ注文の場合は統一しなければいけない
        note = o.order.wayo_orders_extensions.find_by(cscart_wayo_orders_extension: {product_id: o.product_id})&.wrapping_name
        records.push({ order_id: order_id,
                       user_email: email,
                       shipping_name: to_name,
                       shipping_country: country,
                       shipping_zip: zipcode,
                       shipping_state: state,
                       shipping_city: city,
                       shipping_line1: address,
                       shipping_line2: address_2,
                       shipping_tel: tel,
                       sku_name: o.product_description.product,
                       sku_no: o.product_code,
                       unit_price: o.price.to_i,
                       qty: o.amount,
                       ordered_at: Time.at(timestamp).strftime('%Y/%m/%d'),
                       note: note,
                       gift_wrapping: note.present? ? 1 : 0,
                       from_name: to_name == from_name ? '' : from_name
                       })
      end
    end
    logger.info(records)
    csv = Utils::Csv::OrderInfoCsvBuilder::OrderInfoCsvOutput.new
    LogisticsMailer.order_info_mail(csv.output(records).encode("UTF-8")).deliver
    logger.info('SendOrderInfoJob finished.')
  end

  private

  def format_order_id(order_id)
    order = order_id.size
    "#{'0' * (23 - order)}#{order_id}"
  end
end
