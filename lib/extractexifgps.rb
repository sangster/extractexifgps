module ExtractExifGps
  module Version
    MAJOR = 1
    MINOR = 0
    PATCH = 0
    BUILD = nil

    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end
end

require_relative 'cli'
require_relative 'gps_extractor'
