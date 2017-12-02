module Utils
  module Csv
    module BaseCsvBuilder
      # 出力ベース
      class BaseCsvOutput
        def initialize(filename=nil)
            @base_date = Date.today
            @filename = filename
            @records = []
            @type = 'text/csv'
        end
      end
    
      # レコードベース
      class BaseRecord
        def self.header(klass = nil)
          self::FIELDS.map { |field| field[1] || klass.human_attribute_name(field.first) }.join(',')
        end
    
       def to_csv
          ('"' << self.class::FIELDS.map { |field| eval("self.#{field.first}").to_s.gsub(/"/, '""') }.join('","') << '"')
       end
    
       def self.define_field_attr_accessor
         self::FIELDS.each do |field|
           (class << self;
             self;
            end).class_eval { attr_accessor field.first }
            attr_accessor field.first
          end
        end
      end
    end
  end
end
