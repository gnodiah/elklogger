require "elklogger/version"

class Elklogger
  def format_message(severity, datetime, progname, msg)
    Formatter::Format % [severity[0..0], datetime.strftime('%Y-%m-%d'), $$,
                         severity, progname, msg]
  end
end
