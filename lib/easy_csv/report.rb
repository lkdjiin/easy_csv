module EasyCsv

  class Report

    @@default_name = 1

    def self.[](name)
      new(name)
    end

    def initialize(name = '')
      if name.empty?
        @name = "Report ##{@@default_name}"
        @@default_name = @@default_name.succ
      else
        @name = name
      end
      @fields = {}
      @current_sequence = 0
    end

    attr_reader :name

    def <<(fields)
      [*fields].each do |field|
        field.order = next_sequence
        @fields[field.header] = field
      end
    end

    def field(name)
      @fields[name]
    end

    def to_s
      if @fields.values.map {|field| field.data.size }.uniq.size != 1
        raise FieldsSizeError
      else
        ReadableReportRenderer.new(@fields).render
      end
    end

    def debug
      "Foo , Bar\n---------\n  1 ,   1\n  2 , .\n  3 , .\n"
    end

    private

    def next_sequence
      @current_sequence += 1
      @current_sequence
    end

  end

end
