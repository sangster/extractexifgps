require 'csv'
require 'exif'

require_relative 'coord'

module ExtractExifGps
  # Reads EXIF data from a given {FileSet} and extracts any available GPS data
  class GpsExtractor
    extend Forwardable
    include Enumerable

    def_delegator :gps_list, :each

    # @param fileset [FileSet]
    def initialize(file_set)
      @file_set = file_set
    end

    private

    def gps_list
      exif_list.map do |item|
        gps = Coord.from_exif(item[:exif])
        { path: item[:path], lat: gps&.[](:lat), lon: gps&.[](:lon) }
      end
    end

    def exif_list
      @file_set.map { |file| { path: file, exif: exif(file) } }
    end

    def exif(path)
      Exif::Data.new(path.binread)
    rescue Exif::Error
      nil
    end
  end
end
