#-*- coding: utf-8 -*-
module Utils
  module Csv
    module OrderInfoCsvBuilder
      class OrderInfoRecord < BaseCsvBuilder::BaseRecord
        FIELDS = [
          [:client_id, "client_id"],
          [:type, "type"],
          [:order_id, "order_id"],
          [:user_email, "user_email"],
          [:shipping_name, "shipping_name"],
          [:shipping_country, "shipping_country"],
          [:shipping_zip, "shipping_zip"],
          [:shipping_state, "shipping_state"],
          [:shipping_city, "shipping_city"],
          [:shipping_line1, "shipping_line1"],
          [:shipping_line2, "shipping_line2"],
          [:shipping_tel, "shipping_tel"],
          [:sku_name, "sku_name"],
          [:sku_no, "sku_no"],
          [:currency, "currency"],
          [:unit_price, "unit_price"],
          [:qty, "qty"],
          [:ordered_at, "ordered_at(UTC)"],
          [:note, "note"],
          [:gift_wrapping, "gift_wrapping"],
          [:from_name, "from_name"]
        ]
        define_field_attr_accessor
    
       def initialize
         @client_id = Settings.tom.client_id
         @type = 'create'
         @order_id = ''
         @user_email = ''
         @shipping_name = ''
         @shipping_country = ''
         @shipping_zip = ''
         @shipping_state = ''
         @shipping_city = ''
         @shipping_line1 = ''
         @shipping_line2 = ''
         @shipping_tel = ''
         @sku_name = ''
         @sku_no = ''
         @currency = 'JPY' # CS-Cartの仕様で固定でOK
         @unit_price = ''
         @qty = ''
         @ordered_at = ''
         @note = ''
         @gift_wrapping = ''
         @from_name = ''
       end
      end
    
      class OrderInfoCsvOutput < BaseCsvBuilder::BaseCsvOutput
        def output(lists)
          @records << OrderInfoRecord.header
          lists.each do |list|
            record = OrderInfoRecord.new
            record.order_id = list[:order_id]
            record.user_email = list[:user_email]
            record.shipping_name = list[:shipping_name]
            record.shipping_country = list[:shipping_country]
            record.shipping_zip = list[:shipping_zip]
            record.shipping_state = list[:shipping_state]
            record.shipping_city = list[:shipping_city]
            record.shipping_line1 = list[:shipping_line1]
            record.shipping_line2 = list[:shipping_line2]
            record.shipping_tel = list[:shipping_tel]
            record.sku_name = list[:sku_name]
            record.sku_no = list[:sku_no]
            record.unit_price = list[:unit_price]
            record.qty = list[:qty]
            record.ordered_at = list[:ordered_at]
            record.note = list[:note]
            record.gift_wrapping = list[:gift_wrapping]
            record.from_name = list[:from_name]
            @records << record.to_csv
          end
          @records.join("\r\n")
        end
      end
    end
  end
end
