# frozen_string_literal: true

module ActionTable
  class Railtie < Rails::Railtie
    initializer 'action_table.add_helper' do |app|
      ActionTable.configure do |config|
        config.rails_host_app = app
      end

      ActiveSupport.on_load(:action_view) do
        require 'action_table/helper'
        include ActionTable::Helper
      end
    end

    initializer 'action_table.add_views' do |_app|
      ActionController::Base.prepend_view_path "#{__dir__}/views"
    end
  end
end
