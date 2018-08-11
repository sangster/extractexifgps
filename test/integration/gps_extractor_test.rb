require 'helper'
require 'pathname'

module ExtractExifGps
  class GpsExtractorTest < IntegrationTest
    def test_to_csv
      expected = <<-CSV.gsub(/^\s+/, '')
        Path,Latitude,Longitude
        images/image_c.jpg,N 38° 24',W 122° 49.72'
        images/image_a.jpg,N 50° 5.48',W 122° 56.74'
        images/image_b.jpg,,
        images/image_d.jpg,,
      CSV

      Dir.chdir(Pathname.new(__FILE__).join('../..')) do
        extractor = GpsExtractor.new(FileSet.new('images'))
        assert_equal expected, CsvRenderer.new(extractor).to_s
      end
    end

    def test_to_csv__cats
      expected = <<-CSV.gsub(/^\s+/, '')
        Path,Latitude,Longitude
        images/cats/image_e.jpg,"N 59° 55' 29.11829""","E 10° 41' 44.15323"""
      CSV

      Dir.chdir(Pathname.new(__FILE__).join('../..')) do
        extractor = GpsExtractor.new(FileSet.new('images/cats'))
        assert_equal expected, CsvRenderer.new(extractor).to_s
      end
    end
  end
end
