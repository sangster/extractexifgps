require 'helper'

module ExtractExifGps
  class CsvRendererTest < UnitTest
    def test_to_s__empty_set
      assert_equal "Path,Latitude,Longitude\n", render([])
    end

    def test_to_s__simple
      assert_equal "Path,Latitude,Longitude\na,b,c\n",
                   render([item('a', 'b', 'c')])
      assert_equal "Path,Latitude,Longitude\na,b,c\n1,2,3\n",
                   render([item('a', 'b', 'c'), item('1', '2', '3')])
    end

    def test_to_s__no_gps
      assert_equal "Path,Latitude,Longitude\na,,\n",
                   render([item('a')])
      assert_equal "Path,Latitude,Longitude\na,,\n1,,\n",
                   render([item('a'), item('1')])
    end

    private

    def render(set)
      CsvRenderer.new(set).to_s
    end

    def item(*parts)
      { path: parts[0], lat: parts[1], lon: parts[2] }
    end
  end
end
