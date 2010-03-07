require 'spec'
require 'spec/autorun'

require 'mp3_cropper'

require 'rack/test'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
ENV['APP_ENV'] = "test"

Spec::Runner.configure do |config|
  config.after(:each) do
      repository(:default) do
        while repository.adapter.current_transaction
          repository.adapter.current_transaction.rollback
          repository.adapter.pop_transaction
        end
      end
    end

  config.before(:each) do
    repository(:default) do
      transaction = DataMapper::Transaction.new(repository)
      transaction.begin
      repository.adapter.push_transaction(transaction)
    end
  end
end