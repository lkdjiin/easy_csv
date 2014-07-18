module EasyCsv

  # Final report rendering.
  class RealReportRenderer < BaseReportRenderer

    def render
      columns_to_lines(',')
      @lines.join("\n")
    end

  end

end

