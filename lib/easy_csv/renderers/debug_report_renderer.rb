module EasyCsv

  # Report rendering even if the size of the columns are not the same.
  class DebugReportRenderer < BaseReportRenderer

    # Public: Creates a new DebugReportRenderer.
    #
    # fields - Hash. Keys are field header and values are Field.
    def initialize(fields)
      super
      nil_to_dot
    end

    private

    def nil_to_dot
      @columns.each do |column|
        column.map! do |element|
          element.nil? ? '.' : element
        end
      end
    end

  end

end
