RSpec.configure do |config|
  config.before(:each) do
    RubyHome::IdentifierCache.source = Tempfile.new.path
  end
end
