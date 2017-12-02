# frozen_string_literal: true
module Utils
  class FileUtil
    def self.url_file_handler(url, limit = 5)
      return nil if limit.zero?
      begin
        open(url)
      rescue
        url_file_handler(url, limit - 1)
      rescue
        nil
      end
    end
  end
end
