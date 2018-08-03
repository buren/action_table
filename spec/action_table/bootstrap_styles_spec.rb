# frozen_string_literal: true

require 'action_table/bootstrap_styles'

RSpec.describe ActionTable::BootstrapStyles do
  describe '#initialize' do
    it 'raises no ArgumentError for konwn style' do
      expect { described_class.new(:hover) }.not_to raise_error(ArgumentError)
    end

    it 'raises ArgumentError for unkonwn style' do
      expect { described_class.new(:watman) }.to raise_error(ArgumentError)
    end
  end

  describe '#responsive_wrapper_class' do
    it 'returns nil when no responsive styles present' do
      styles = described_class.new(%i[])

      expect(styles.responsive_wrapper_class).to be_nil
    end

    it 'returns correct wrapper classes when responsive styles present' do
      styles = described_class.new(%i[responsive-sm])

      expect(styles.responsive_wrapper_class).to eq('table-responsive-sm')
    end

    it 'returns correct wrapper classes when responsive styles present with underscores' do
      styles = described_class.new(%i[responsive_sm])

      expect(styles.responsive_wrapper_class).to eq('table-responsive-sm')
    end

    it 'ignores table styles' do
      styles = described_class.new(:hover)

      expect(styles.responsive_wrapper_class).to be_nil
    end
  end

  describe '#table_classes' do
    it 'returns correct table style when given non-array argument' do
      styles = described_class.new(:hover)

      expect(styles.table_classes).to eq('table table-hover')
    end

    it 'ignores resposive styles' do
      styles = described_class.new(:responsive)

      expect(styles.table_classes).to eq('table ')
    end

    it 'returns correct table style when given multiple styles' do
      styles = described_class.new(%i[hover striped])

      expect(styles.table_classes).to eq('table table-hover table-striped')
    end
  end
end
