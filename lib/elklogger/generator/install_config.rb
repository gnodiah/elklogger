require 'fileutils'

# Install ElkLogger's config file.
class ElkLogger
  class Generator
    def self.install
      src_root = File.dirname(__FILE__)
      dst_root = FileUtils.pwd #defined?(Rails) ? Rails.root : src_root
      src = "#{src_root}/template/custom_log.conf"
      dst = "#{dst_root}/config/elklogger"

      FileUtils.mkdir_p(dst) unless File.directory?(dst)
      dst += '/custom_log.conf'
      FileUtils.copy_file(src, dst)

      puts "Created config file: #{File.expand_path(dst)}"
    end
  end
end
