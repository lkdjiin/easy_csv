module EasyCsv

  # Public: A report is a set of {Field}s.
  class Report

    @@default_name = 1

    # Public: Creates a new Report. Same as {Report.new}.
    #
    # name - String name of this CSV report.
    #
    # Returns a Report object.
    def self.[](name)
      new(name)
    end

    # Public: Creates a new Report. Same as {Report.[]}.
    #
    # name - String name of this CSV report. Default is 'Report #1',
    #        then 'Report #2', etc.
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

    # Public: Get the String name/tile of this report.
    attr_reader :name

    # Public: Get all Field fields/columns.
    attr_reader :fields

    # Public: Add fields to the report.
    #
    # fields - A list of {Field}s (or even a single Field).
    #
    # Examples
    #
    #     field1 = Field['Foo']
    #     field2 = Field['Bar']
    #     report = Report['Report']
    #     report << [field1, field2]
    #
    # Returns nothing.
    def <<(fields)
      [*fields].each do |field|
        field.order = next_sequence
        @fields[field.header] = field
      end
    end

    # Public: Get a Field by name.
    #
    # name - String name of the desired Field.
    #
    # Returns the Field.
    def field(name)
      @fields[name]
    end

    # Public: Get a rendered CSV report, ready to be displayed.
    #
    # Returns a String.
    def to_s
      if @fields.values.map {|field| field.data.size }.uniq.size != 1
        raise FieldsSizeError
      else
        ReadableReportRenderer.new(@fields).render
      end
    end

    # Public: Get a rendered CSV report, even if the fields are not of
    # the same size.
    #
    # Returns a String.
    def debug
      DebugReportRenderer.new(@fields).render
    end

    # Public: Get information about the fields ordering (this is
    # formatted like a report).
    #
    # Returns a String.
    def order
      FieldsOrderRenderer.new(self).render
    end

    # Public: Get a final rendered CSV report.
    #
    # Returns a String.
    def render
      RealReportRenderer.new(@fields).render
    end

    private

    def next_sequence
      @current_sequence += 1
      @current_sequence
    end

  end

end
