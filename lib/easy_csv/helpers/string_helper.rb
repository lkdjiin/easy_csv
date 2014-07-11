module EasyCsv

  module StringHelper
    extend self

    def underline(string)
      '-' * string.size
    end

    def numeric?(string)
      Float(string) != nil rescue false
    end
  end
end
