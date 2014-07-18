module EasyCsv

  # Render the fields ordering of a CSV report.
  class FieldsOrderRenderer

    # Public: Creates a new FieldsOrderRenderer.
    #
    # report - A {Report}.
    def initialize(report)
      @fields = report.fields
      @report_name = report.name
    end

    # Public: Render the fields' ordering of a report.
    #
    # Examples
    #
    #   renderer = FieldsOrderRenderer.new(a_report)
    #   renderer.render
    #   #=> Fields order for Test report
    #   #=> ----------------------------
    #   #=> 1 Name of first field
    #   #=> 2 Name of second field
    #   #=> 3 Name of third field
    #
    # Returns a String.
    def render
      [ header, StringHelper.underline(header), *data ].join("\n")
    end

    private

    def header
      "Fields order for #{@report_name} report"
    end

    def data
      @fields.values.map {|field| "#{field.order} #{field.header}" }.sort
    end

  end

end
