module EasyCsv

  # Some helper methods related to String.
  module StringHelper
    extend self

    # Public: Underline a string (make it a title).
    #
    # string - The String to underline.
    #
    # Examples
    #
    #   StringHelper.underline('1234') #=> "----"
    #
    # Returns the String underline.
    def underline(string)
      '-' * string.size
    end

    # Public: Check if a string represents a numeric value.
    #
    # string - The String to check.
    #
    # Returns Boolean.
    def numeric?(string)
      Float(string) != nil rescue false
    end
  end
end
