require 'helper'

module ExtractExifGps
  class HtmlRendererTest < UnitTest
    def test_to_s__empty_set
      assert_equal expected_lines('TITLE: EXIF GPS', 'PATHS:', 'FILES:'),
                   render([])
    end

    def test_to_s__simple
      assert_equal expected_lines('TITLE: EXIF GPS', 'PATHS:', 'FILES:', '  a|b|c'),
                   render([item('a', 'b', 'c')])
      assert_equal expected_lines('TITLE: EXIF GPS', 'PATHS:', 'FILES:', '  a|b|c', '  1|2|3'),
                   render([item('a', 'b', 'c'), item('1', '2', '3')])
    end

    def test_to_s__no_gps
      assert_equal expected_lines('TITLE: EXIF GPS', 'PATHS:', 'FILES:', '  a||'),
                   render([item('a')])
      assert_equal expected_lines('TITLE: EXIF GPS', 'PATHS:', 'FILES:', '  a||', '  1||'),
                   render([item('a'), item('1')])
    end

    def test_to_s__title
      assert_equal expected_lines('TITLE: TEST', 'PATHS:', 'FILES:', '  a|b|c'),
                   render([item('a', 'b', 'c')], title: 'TEST')
    end

    def test_to_s__search_path
      assert_equal expected_lines('TITLE: EXIF GPS', 'PATHS:', '  path', 'FILES:', '  a|b|c'),
                   render([item('a', 'b', 'c')], search_paths: %w[path])
    end

    def test_to_s__search_paths
      assert_equal expected_lines('TITLE: EXIF GPS', 'PATHS:', '  a', '  b', 'FILES:', '  a|b|c'),
                   render([item('a', 'b', 'c')], search_paths: %w[a b])
    end

    private

    def render(set, args = {})
      HtmlRenderer.new(set, {template: template_stub}.merge(args)).to_s.strip
    end

    def item(*parts)
      { path: parts[0], lat: parts[1], lon: parts[2] }
    end

    def template_stub
      StringIO.new <<ERB
TITLE: <%= title %>
PATHS:
<% search_paths.each do |path| %>
  <%= path %>
<% end %>
FILES:
<% files.each do |item| %>
  <%= item[:path] %>|<%= item[:lat] %>|<%= item[:lon] %>
<% end %>
ERB
    end

    def expected_lines(*lines)
      lines.join("\n")
    end
  end
end
