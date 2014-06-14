require 'logger'

module Scammer
  module Logging
    attr_writer :log
    def log
      @log ||= Logger.new('development.log', File::CREAT)
    end
  end
end
