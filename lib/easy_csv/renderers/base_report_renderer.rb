module EasyCsv

  class BaseReportRenderer

    # fields - Hash. Keys are field header and values are Field.
    def initialize(fields)
      @fields = fields
      @columns = fields_to_columns
      @lines = []
    end

    def render
      max_string_size_for_each_column.each_with_index do |size, index|
        pad_strings(size, index)
      end
      columns_to_lines
      inject_underline
      @lines.join("\n")
    end

    private

    def fields_to_columns
      header.zip(*data)
    end

    def header
      @fields.values.sort_by {|field| field.order}.map(&:header)
    end

    def data
      ds = @fields.values.sort_by {|field| field.order}.map(&:data)
      ds.first.zip(*ds[1..-1])
    end

    def max_string_size_for_each_column
      sizes = []
      @columns.each do |column|
        sizes << column.map(&:size).max
      end
      sizes
    end

    def pad_strings(size, index)
      @columns[index].map! do |string|
        if StringHelper.numeric?(string)
          "%#{size}s" % string
        else
          "%-#{size}s" % string
        end
      end
    end

    def columns_to_lines
      @lines = @columns.first.zip(*@columns[1..-1])
      @lines.map! {|item| item.join(' , ') }
    end

    def inject_underline
      @lines.insert(1, StringHelper.underline(@lines.first))
    end
  end

end
