# frozen_string_literal: true

require 'erb'
require 'action_table/view'

module ActionTable
  module Helper
    # Renders an ActiveRecord collection as a HTML table.
    # @return [String] returns a HTML string representing the ActiveRecord collection.
    # @param [ActiveRecord::Collection]
    #   records ActiveRecord collection to render
    # @param [Array<String>, Array<Symbol>]
    #   table columns (must map to methods on each ActiveRecord instance)
    # @param styles [Array<String>, Array<Symbol>]
    #   no, one or many of bootstrap table styles (table- prefix will be added)
    # @param link [Symbol]
    #   method name for the default name to use for anchor-tags
    # @param paginate [true, false]
    #   whether to render pagination links (default: false)
    # @param actions [Array<String>, Array<Symbol>]
    #   render action lins (show, edit and delete)
    def action_table(
      records,
      fields,
      paginate: false,
      link: ActionTable.config.link_method,
      actions: ActionTable.config.actions,
      styles: ActionTable.config.styles
    )
      action_table = View.new(
        cols: fields,
        records: records,
        paginate: paginate,
        link: link,
        actions: actions,
        styles: styles,
      )

      render('action_table/table', table: action_table)
    end
  end
end
