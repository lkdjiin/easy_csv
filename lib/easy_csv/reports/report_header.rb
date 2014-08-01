module EasyCsv

  # Public: Represent the header of a CSV report.
  class ReportHeader

    # Public: Get the report's header.
    #
    # fields - Array of {Field}s.
    #
    # Examples
    #
    #   ReportHeader.headers(some_fields)
    #   #=> [ 'Product ID', 'Name', 'Description', 'Price']
    #
    # Returns an Array of String.
    def self.headers(fields)
      fields.values.sort_by {|field| field.order}.map(&:header)
    end

    # Public: Create a new ReportHeader object. A such object is needed
    # for make equality testing easier.
    #
    # fields - Array of {Field}s.
    def initialize(fields)
      @fields = fields
    end

    # Public: Test the equality between two headers. This allow
    # developers to test either with a string or with an array.
    #
    # object - The second header.
    #
    # Examples
    #
    #   a_report.header == 'Foo,Bar,Baz'     #=> true
    #   a_report.header == %w( Foo Bar Baz ) #=> true
    #
    # Returns true if the two headers are equal.
    def ==(object)
      headers = ReportHeader.headers(@fields)
      case object.class.name
      when 'String' then headers.join(',') == object
      when 'Array' then headers == object
      end
    end

  end

end
