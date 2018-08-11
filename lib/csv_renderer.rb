require 'csv'

module ExtractExifGps
  # Render a {FileSet} as a CSV file
  class CsvRenderer
    CSV_COLUMNS = %w[Path Latitude Longitude].freeze

    # @param files [FileSet]
    def initialize(files)
      @files = files
    end

    def to_s
      CSV.generate do |csv|
        csv << CSV_COLUMNS

        @files.each do |item|
          csv << [item[:path], item[:lat]&.to_s, item[:lon]&.to_s]
        end
      end
    end
  end
end
