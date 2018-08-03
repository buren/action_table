# frozen_string_literal: true

require 'erb'
require 'action_table/view'

module ActionTable
  module Helper
    def action_table(
      records,
      fields,
      styles: %i[bordered striped hover],
      link: :name,
      paginate: false,
      actions: []
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
