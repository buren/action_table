# frozen_string_literal: true

require 'action_table/version'
require 'action_table/railtie'

module ActionTable
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.config
    configuration
  end

  def self.configure
    yield(configuration) if block_given?
    configuration
  end

  class Configuration
    attr_accessor :table_styles
    attr_writer :rails_host_app

    def initialize
      @rails_host_app = nil
      @table_styles = []
    end

    def rails_host_app
      @rails_host_app || raise('rails host app must be configured!')
    end
  end
end
