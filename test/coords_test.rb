require 'helper'

class TestCoords < UnitTest
  def test_from_exif__missing
    assert_nil ExtractExifGps::Coords.from_exif(nil)
    assert_nil ExtractExifGps::Coords.from_exif({})
    assert_nil ExtractExifGps::Coords.from_exif(gps: {})
  end

  def test_from_exif__present
    assert_equal({lat: %{N 38°}, lon: %{W 122°} },
      from_exif(gps:
        {gps_latitude_ref: "N", gps_latitude: [(38/1), (0/1), (0/1)],
         gps_longitude_ref: "W", gps_longitude: [(122/1), (0/1), (0/1)]}
      )
    )

    assert_equal({lat: %{N 38° 24'}, lon: %{W 122° 49'} },
      from_exif(gps:
        {gps_latitude_ref: "N", gps_latitude: [(38/1), (24/1), (0/1)],
         gps_longitude_ref: "W", gps_longitude: [(122/1), (1243/25), (0/1)]}
      )
    )

    assert_equal({lat: %{N 38° 24' 10"}, lon: %{W 122° 49' 20"} },
      from_exif(gps:
        {gps_latitude_ref: "N", gps_latitude: [(38/1), (24/1), (0/1), (10/1)],
         gps_longitude_ref: "W", gps_longitude: [(122/1), (1243/25), (0/1), (20/1)]}
      )
    )
  end

  def test_to_s__integers
    assert_equal %{N 1°}, coords('N', 1).to_s
    assert_equal %{N 1° 2'}, coords('N', 1, 2).to_s
    assert_equal %{N 1° 2' 3"}, coords('N', 1, 2, 3).to_s
  end

  def test_to_s__floats_short
    assert_equal %{N 0.5°}, coords('N', 1/2r).to_s
    assert_equal %{N 0.5° 0.25'}, coords('N', 1/2r, 2/8r).to_s
    assert_equal %{N 0.5° 0.25' 0.1875"}, coords('N', 1/2r, 2/8r, 3/16r).to_s
  end

  def test_to_s__floats_long
    assert_equal %{N 0.33333°}, coords('N', 1/3r).to_s
    assert_equal %{N 0.33333° 0.16667'}, coords('N', 1/3r, 1/6r).to_s
    assert_equal %{N 0.33333° 0.16667' 0.08333"}, coords('N', 1/3r, 1/6r, 1/12r).to_s
  end

  private

  def from_exif(data)
    coords = ExtractExifGps::Coords.from_exif(data)
    {lat: coords[:lat].to_s, lon: coords[:lon].to_s}
  end

  def coords(dir, *coords)
    ExtractExifGps::Coords.new(dir, coords)
  end
end
