require 'spec_helper'
require 'json/ext'

describe ElkLogger do
  it 'has a version number' do
    expect(ElkLogger::VERSION).not_to be nil
  end

  it 'has a formmatted output' do
    filename = '/tmp/elklogger_spec.log.elk'
    logger = ElkLogger.new(filename)
    logger.info 'hello test!'
    logger.close

    file = File.open(filename)
    result = JSON.parse file.readlines.last
    file.close

    expect(result.keys).to eq %w(body head timestamp)
    expect(result['head']['counter']).to eq 0
  end
end
