# frozen_string_literal: true

require 'set'

module ActionTable
  class View
    include ActionView::Helpers::UrlHelper
    include ActionTable.config.rails_host_app.routes.url_helpers

    attr_reader :rows

    def initialize(
      columns:,
      records:,
      paginate: false,
      links: ActionTable.config.links,
      actions: ActionTable.config.actions
    )
      @columns    = Array(columns).map(&:to_s)
      @rows       = records
      @paginate   = paginate
      @links      = Set.new(Array(links).map(&:to_s)).reject(&:empty?)
      @actions    = Array(actions).map(&:to_s)
    end

    def headers
      @headers ||= @columns.map { |name| t_col(name) }
    end

    # add header column padding for actions
    def actions_header
      @actions_header ||= [''] * @actions.length
    end

    def columns(record)
      attribute_columns = @columns.map do |name|
        title = record.public_send(name)
        if title.present? && @links.include?(name)
          link_to(title, record_path(record))
        else
          title
        end
      end

      actions = t_actions.zip(@actions).map! do |data|
        title, name = data
        link_to(title, record_path(record, action: name))
      end

      attribute_columns + actions
    end

    def paginate?
      @paginate
    end

    def paginate_param_name
      "#{model_name}_page"
    end

    # This must be defined for record_path to work
    def controller
      table_name
    end

    # Contstruct path to record, i.e programs_path(record)
    def record_path(record, action: nil)
      action = nil if action.to_s == 'show'
      path = [action, model_name, 'path'].compact.join('_')
      public_send(path, record)
    end

    private

    def t_actions
      @actions.map { |name| t_action(name) }
    end

    def t_action(name)
      name = name.to_s
      I18n.t("actions.#{name}", default: name.titleize)
    end

    def t_col(col_name)
      if model_name?
        t_key = "activerecord.attributes.#{model_name}.#{col_name}"
        return I18n.t(t_key, default: col_name.titleize)
      end

      col_name.humanize.titleize
    end

    def table_name
      rows.table_name
    end

    def model_name
      table_name.singularize
    end

    def table_name?
      rows.respond_to?(:table_name)
    end
    alias_method :model_name?, :table_name?
  end
end
