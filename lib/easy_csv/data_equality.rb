module EasyCsv

  # Extends == method of the {Field} data.
  module DataEquality

    # Before testing for equality, cast all `other` elements into a
    # String.
    #
    # other - An Array.
    def ==(other)
      other.map!(&:to_s)
      super
    end

  end

end
