require 'logger'

class ElkLogger < Logger
  SUPER_VERSION = VERSION # keep superclass (Logger) version
  VERSION = "0.0.5"
end
