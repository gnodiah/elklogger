require 'fileutils'

# Install ElkLogger's config file.
module Elklogger
  class Generator
    def self.install
      src_root = File.dirname(__FILE__)
      dst_root = FileUtils.pwd #defined?(Rails) ? Rails.root : src_root
      src = "#{src_root}/template/custom_log.conf"
      dst = "#{dst_root}/config/elklogger"

      FileUtils.mkdir_p(dst) unless File.directory?(dst)
      dst += '/custom_log.conf'
      FileUtils.copy_file(src, dst)

      # Automatically generate logstash input files path, it will be
      #   "#{the_current_dir}/log/*.log.elk"
      contents = File.read(dst)
      contents.gsub!('your_ruby_project_absolute_path', dst_root)
      File.open(dst, 'w') { |f| f.write contents }

      # TODO Automatically generate kafka servers

      puts "Created config file: #{File.expand_path(dst)}"
    end
  end
end
