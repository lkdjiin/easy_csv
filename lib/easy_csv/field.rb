module EasyCsv

  # Public: A field/column of data.
  class Field

    @@default_header = 'A'

    # Public: Creates a new Field. Same as {Field.new}.
    #
    # header - String title/name of this field.
    #
    # Returns a Field object.
    def self.[](header)
      new(header)
    end

    # Public: Creates a new Field. Same as {Field.[]}.
    #
    # header - String title/name of this field. Default is 'A', then
    #          'B', etc.
    def initialize(header = '')
      if header.empty?
        @header = @@default_header
        @@default_header = @@default_header.next
      else
        @header = header
      end
      @data = []
      @order = 0
    end

    # Public: Get the String header/tile of this field.
    attr_reader :header

    # Public: Get a String with header and data.
    #
    # Examples
    #
    #
    #   field = Field['Foo']
    #   field << 'bépo'
    #   puts field
    #   #=> Foo
    #   #=> bépo
    #
    # Returns a String.
    def to_s
      [ @header, @data ].flatten.join("\n")
    end

    # Public: Add values to the field.
    #
    # values - A list of data (or even a single data).
    #
    # Examples
    #
    #     field = Field['Foo']
    #     field << [111, 222]
    #
    # Returns nothing.
    def <<(values)
      [*values].each {|value| @data << value.to_s }
    end

    # Get all data of this field.
    attr_reader :data

    # Get the Fixnum order of this field inside a report. If #order
    # returns 0, the field is orphan (it isn't attached to a report).
    attr_accessor :order

  end

  # Raise me when you try to render a CSV file whose fields/columns are
  # not of the same size.
  class FieldsSizeError < StandardError
  end
end
