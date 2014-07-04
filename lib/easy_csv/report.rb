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
    end

    attr_reader :name

    def <<(fields)
      [*fields].each {|field| @fields[field.header] = field }
    end

    def field(name)
      @fields[name]
    end

    def to_s
      raise FieldsSizeError
    end

    def debug
      "Foo , Bar\n---------\n  1 ,   1\n  2 , .\n  3 , .\n"
    end
  end
end
