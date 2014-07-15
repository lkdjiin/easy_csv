module EasyCsv

  class FieldsOrderRenderer

    def initialize(fields, report_name)
      @fields = fields
      @report_name = report_name
    end

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
