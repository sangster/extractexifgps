require 'csv'
require 'exif'
require 'pathname'

require_relative 'coords'

module ExtractExifGps
  class DirectoryFilesExtractor
    CSV_COLUMNS = ['Path', 'Latitude', 'Longitude'].freeze

    def initialize(dir_path)
      @dir_path = dir_path
    end

    def to_csv
      CSV.generate do |csv|
        csv << CSV_COLUMNS

        gps_list.each do |item|
          csv << [ item[:path],
            item[:gps]&.[](:lat)&.to_s,
            item[:gps]&.[](:lon)&.to_s
          ]
        end
      end
    end

    private

    def gps_list
      exif_list.map do |item|
        { path: item[:path], gps: Coords.from_exif(item[:exif]) }
      end
    end

    def exif_list
      files.map { |file| { path: file, exif: exif(file) } }
    end

    def files
      Pathname.new(@dir_path).glob('*').select(&:file?)
    end

    def exif(path)
      Exif::Data.new(path.binread)
    rescue Exif::Error
      nil
    end
  end
end
