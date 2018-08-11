require 'helper'
require 'pathname'

module ExtractExifGps
class FileTestTest < IntegrationTest
    def test_each__flat
      file_set = FileSet.new('test/images')

      assert_equal %w[image_a.jpg image_b.jpg image_c.jpg image_d.jpg],
                   file_set.each.map(&:basename).map(&:to_s).sort
    end

    def test_each__recursive
      file_set = FileSet.new('test/images', recursive: true)

      assert_equal %w[image_a.jpg image_b.jpg image_c.jpg image_d.jpg image_e.jpg],
                   file_set.each.map(&:basename).map(&:to_s).sort
    end
  end
end
