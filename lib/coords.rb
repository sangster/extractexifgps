module ExtractExifGps
  class Coords
    GPS_ICONS = %w{° ' "}.freeze
    MAX_DECIMALS = 5

    class << self
      # @param [Exif::Data] data
      # @return [Hash<Symbol, Coords>, nil] the pair of GPS coordinates from in
      #   the given EXIF data, or +nil+ if there is none
      def from_exif(data)
        if (gps = data&.[](:gps))&.any?
          {lat: extract(gps, :latitude), lon: extract(gps, :longitude)}
        end
      end

      private

      def extract(gps, dir)
        new(gps[:"gps_#{dir}_ref"], gps[:"gps_#{dir}"])
      end
    end

    def initialize(dir, coords)
      @dir = dir
      @coords = coords
    end

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
