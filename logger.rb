require 'logger'

module SysLogger
  attr_writer :log
  def log
    @log ||= Logger.new('development.log')
  end
end