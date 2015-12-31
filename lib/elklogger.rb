require "elklogger/version"
require "elklogger/core_ext/object/try"
require 'date'
require 'json/ext'
require 'socket'
require 'pathname'

class Logger

  class LogDevice
    private

    def add_log_header(file); "\n"; end
  end
end

class Elklogger

  module LoggerInfo
    def ruby_pid; $$.to_s; end

    def thread_name
      Thread.current.inspect.match(/Thread:\w+/).to_s
    end

    # def method_name; __callee__; end
    # def class_name; end

    def ipv4_address
      # First IPv4 address
      # ipv4_addr = Socket.ip_address_list.detect { |intf| intf.ipv4_private? }

      ipv4_addr = Socket.ip_address_list.detect { |intf|
        intf.ipv4? and !intf.ipv4_loopback? and !intf.ipv4_multicast?
        # and !intf.ipv4_private?
      }
      ipv4_addr.ip_address unless ipv4_addr.nil?
    end

    def appname
      app_name = defined?(Settings) && Settings.try(:elklogger).try(:appname)
      app_name ? app_name.strip : 'not-specified'
    end

    # TODO 暂时还没有方案给日期增加数字顺序编号
    def counter_number
      0
    end
  end
  include LoggerInfo

  undef <<
  undef fatal?
  undef fatal
  undef unknown
  undef datetime_format=
  undef datetime_format

  attr_reader :calling_mname, :calling_cname

  def initialize(logdev, shift_age = 0, shift_size = 1048576)
    @calling_mname = nil   # calling method name
    @calling_cname = nil   # calling class name

    super(logdev, shift_age, shift_size)
  end

  def format_message(severity, datetime, progname, msg)
    {
      :body => msg.to_s,
      :head => {
        :app => appname,
        :level => severity,
        :counter => counter_number,
        :tname => thread_name,
        :pid => ruby_pid,
        :mname => calling_mname,
        :cname => calling_cname,
        :ip => ipv4_address.to_s
      },
      :timestamp => datetime.to_datetime.strftime("%Q").to_i
    }.to_json + "\n"
  end

  private

  SEV_LABEL = %w(DEBUG INFO WARN ERROR ANY)

  def add(severity, message = nil, progname = nil, &block)
    caller_info = caller_locations(2, 1).first
    @calling_mname = caller_info.try(:label).to_s

    @calling_cname = caller_info.try(:path).to_s
    if defined?(Rails) && !@calling_cname.empty?
      @calling_cname = Pathname.new(@calling_cname).relative_path_from(Rails.root)
    end
    @calling_cname = @calling_cname.to_s + ":#{caller_info.try(:lineno).to_s}"

    super(severity, message, progname, &block)
  end

  class Configuration
  end

end
