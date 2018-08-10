require 'helper'

class TestExtractExifGps < UnitTest
  def test_version
    refute_nil ExtractExifGps::Version::MAJOR
    refute_nil ExtractExifGps::Version::STRING
  end
end
