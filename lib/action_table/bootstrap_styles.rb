# frozen_string_literal: true

module ActionTable
  class BootstrapStyles
    BOOTSTRAP_TABLE_WRAPERS = Set.new(
      %w[
        responsive
        responsive-sm
        responsive-md
        responsive-lg
        responsive-xl
      ],
    ).freeze

    # All the below can be used on <table>, <thead>, <tr>, <td>
    BOOTSTRAP_UTILS = Set.new(
      %w[
        dark
        light
        primary
        success
        danger
        info
        warning
        active
        secondary
      ],
    )

    # .thead-light or .thead-dark
    #       <th scope="row">1</th>
    #   <caption>List of users</caption> # directly under <table>
    BOOTSTRAP_TABLE_STYLES = (
      Set.new(
        %w[
          striped
          sm
          bordered
          hover
          borderless
        ],
      ) + BOOTSTRAP_UTILS
    ).freeze

    def initialize(styles)
      @styles = Array(styles).map { |style| style.to_s.tr('_', '-') }
      @responsive_wrapper_class = nil
      @table_classes = nil

      validate_styles!(@styles)
    end

    def responsive_wrapper_class
      return @responsive_wrapper_class if @responsive_wrapper_class

      wrappers = BOOTSTRAP_TABLE_WRAPERS.select { |style| @styles.include?(style) }
      return if wrappers.empty?

      @responsive_wrapper_class = wrappers.map do |style|
        "table-#{style}" if wrapper_class?(style)
      end.join(' ')
    end

    def table_classes
      return @table_classes if @table_classes

      style_classes = @styles.map do |style|
        "table-#{style}" if table_class?(style)
      end.compact

      @table_classes = "table #{style_classes.join(' ')}"
    end

    private

    def table_class?(style)
      BOOTSTRAP_TABLE_STYLES.include?(style)
    end

    def wrapper_class?(style)
      BOOTSTRAP_TABLE_WRAPERS.include?(style)
    end

    def validate_styles!(styles)
      styles.each do |style|
        next if table_class?(style) || wrapper_class?(style)

        raise(
          ArgumentError,
          "unknown bootstrap style #{style}, must be in #{BOOTSTRAP_TABLE_STYLES}",
        )
      end
    end
  end
end
