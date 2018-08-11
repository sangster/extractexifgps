module ExtractExifGps
  # Represents a single coordinate, either latitude or longitude, in a GPS
  # coordinate.
  class Coord
    GPS_ICONS = %w[° ' "].freeze
    MAX_DECIMALS = 5

    class << self
      # @param [Exif::Data] data
      # @return [Hash<Symbol, Coord>, nil] the pair of GPS coordinates from in
      #   the given EXIF data, or +nil+ if there is none
      def from_exif(data)
        if (gps = data&.[](:gps))&.any?
          { lat: extract(gps, :latitude), lon: extract(gps, :longitude) }
        end
      end

      private

      def extract(gps, dir)
        new(gps[:"gps_#{dir}_ref"], gps[:"gps_#{dir}"])
      end
    end

    # @param dir [#to_s] A charcter representing a cardinal direction: N, E,
    #   S, W
    # @param coords [Array<Number>] An array containing the coordinate 1-3
    # numbers, representing degrees, minutes, and seconds
    def initialize(dir, coords)
      @dir = dir
      @coords = coords
    end

    # @return [String] formats the given coordinate in degrees, minutes, and
    #   secondes. ex: +N 38° 24' 10"+ +W 122° 49' 20"+
    def to_s
      parts = @coords.reject(&:zero?).map(&method(:rational_str)).zip(GPS_ICONS)
      "#{@dir} #{parts.map(&:join).join(' ')}"
    end

    private

    def rational_str(rat)
      format("%.#{MAX_DECIMALS}f", rat).gsub(/\.?0*$/, '')
    end
  end
end
