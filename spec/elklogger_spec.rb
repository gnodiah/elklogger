require 'spec_helper'

describe Elklogger do
  it 'has a version number' do
    expect(Elklogger::VERSION).not_to be nil
  end

  it 'has a formmatted output' do
    filename = '/tmp/elklogger_test.log.elk'
    logger = Elklogger.new(filename)
    logger.info 'hello test!'
    logger.close

    file = File.open(filename)
    reg = /I, \[#{Time.now.strftime('%Y-%m-%d')}#\d+\]  INFO -- : hello test!\n/
    result = file.readlines.last =~ reg
    file.close

    expect(result).not_to be nil
  end
end
