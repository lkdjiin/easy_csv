module EasyCsv

  class Field

    @@default_header = 'A'

    def self.[](header)
      new(header)
    end

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

    attr_reader :header

    def to_s
      [ @header, @data ].flatten.join("\n")
    end

    def <<(values)
      [*values].each {|value| @data << value.to_s }
    end

    attr_reader :data

    attr_accessor :order

  end

  class FieldsSizeError < StandardError
  end
end
