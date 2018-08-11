require 'thor'

require_relative 'csv_renderer'
require_relative 'html_renderer'
require_relative 'file_set'

module ExtractExifGps
  # Defines the CLI interface for this application.
  #
  # You can get information about command-line options with
  # +extractexifgps help+ or +extractexifgps help <command>+ to information
  # pertaining to the particular command.
  class Cli < Thor
    default_command :csv
    map '-C' => :csv
    map '-H' => :html

    class_option :recursive, type: :boolean, aliases: %w[-r],
                             desc: 'Recursively search subdirectories'
    class_option :output, type: :string, aliases: %w[-o],
                          desc: 'Write to OUTPUT instead of stdout'

    desc 'csv [OPTION]... [DIR]...',
         'Export EXIF GPS data from the images in DIR in CSV format'
    def csv(*dirs)
      extractor = ExtractExifGps::GpsExtractor.new(
        FileSet.new(dirs.empty? ? ['.'] : dirs, recursive: options[:recursive])
      )

      $stdout.reopen(options[:output], 'w') if options[:output]
      puts CsvRenderer.new(extractor)
    end

    option :template, type: :string, aliases: %w[-t],
                      desc: 'Generate the HTML with TEMPLATE'
    desc 'html [OPTION]... [DIR]...',
         'Export EXIF GPS data from the images in DIR in HTML format'
    def html(*dirs)
      search_paths = dirs.empty? ? ['.'] : dirs
      extractor = ExtractExifGps::GpsExtractor.new(
        FileSet.new(search_paths, recursive: options[:recursive])
      )

      template = options[:template] || template_path('templates/basic.html.erb')

      $stdout.reopen(options[:output], 'w') if options[:output]
      puts HtmlRenderer.new(extractor,
                            search_paths: search_paths,
                            template: template)
    end

    private

    def template_path(path)
      Pathname.new(__FILE__).join('../../').join(path)
    end
  end
end
