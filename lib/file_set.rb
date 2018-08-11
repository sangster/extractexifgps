require 'pathname'

module ExtractExifGps
  # Enumerates over all the files within one or more given directories,
  # optionally including files in subdirectories.
  class FileSet
    include Enumerable

    # @param dirs [Array,String] one more paths to search
    # @param recursive [Boolean] if this file set should include files from
    #    subdirectories
    def initialize(dirs, recursive: false)
      @dirs = Array(dirs)
      @recursive = recursive
    end

    def each(&block)
      @dirs.flat_map { |d| Pathname.new(d).glob(glob_pattern).select(&:file?) }.
        each(&block)
    end

    private

    def glob_pattern
      @recursive ? '**/*' : '*'
    end
  end
end
