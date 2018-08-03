# frozen_string_literal: true

require 'action_table/version'
require 'action_table/railtie' if defined?(Rails)

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
    attr_accessor :styles, :actions, :links
    attr_writer :rails_host_app

    def initialize
      @rails_host_app = nil
      @styles = []
      @actions = []
      @links = []
    end

    def rails_host_app
      @rails_host_app || raise('rails host app must be configured!')
    end
  end
end
