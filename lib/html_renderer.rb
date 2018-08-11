require 'erb'

module ExtractExifGps
  HTML_TEMPLATE = 'templates/basic.html.erb'.freeze

  # Render a {FileSet} as an HTML file
  class HtmlRenderer
    attr_reader :search_paths, :title, :files

    # @param files [FileSet]
    # @param template [StringIO,#to_s] A +StringIO+ containing the body of an
    #   ERB template, or the path to a template file
    # @param title [String] The title to use in the rendered HTML file
    # @param search_paths [Array<#to_s>] The directories searched for images
    def initialize(files, template:, title: 'EXIF GPS', search_paths: [])
      @files = files
      @template = template
      @title = title
      @search_paths = search_paths
    end

    def to_s
      erb.result(binding)
    end

    private

    def erb
      ERB.new(read_template, nil, '<>')
    end

    def read_template
      case @template
      when StringIO then @template.read
      else IO.read(@template)
      end
    end
  end
end
