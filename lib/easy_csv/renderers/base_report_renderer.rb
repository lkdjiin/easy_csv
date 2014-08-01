module EasyCsv

  # Holds common machinery to render CSV reports.
  class BaseReportRenderer

    # Public: Creates a new BaseReportRenderer.
    #
    # fields - Hash. Keys are field header and values are Field.
    def initialize(fields)
      @fields = fields
      @columns = fields_to_columns
      @lines = []
    end

    # Base method to render a CSV report.
    #
    # Returns a String.
    def render
      pad_columns
      columns_to_lines
      inject_underline
      @lines.join("\n")
    end

    private

    def fields_to_columns
      ReportHeader.headers(@fields).zip(*data)
    end

    def data
      ds = @fields.values.sort_by {|field| field.order}.map(&:data)
      ds.first.zip(*ds[1..-1])
    end

    def pad_columns
      max_string_size_for_each_column.each_with_index do |size, index|
        pad_a_column(size, @columns[index])
      end
    end

    def max_string_size_for_each_column
      @columns.dup.map {|column| column.map(&:size).max }
    end

    def pad_a_column(size, column)
      column.map! {|string| pad_a_string(string, size) }
    end

    def pad_a_string(string, size)
      if StringHelper.numeric?(string)
        "%#{size}s" % string
      else
        "%-#{size}s" % string
      end
    end

    def columns_to_lines(separator = ' , ')
      @lines = @columns.first.zip(*@columns[1..-1])
      @lines.map! {|item| item.join(separator) }
    end

    def inject_underline
      @lines.insert(1, StringHelper.underline(@lines.first))
    end
  end

end
