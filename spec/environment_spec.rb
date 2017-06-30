require 'spec_helper'
require 'rails_helper'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

describe 'Environment' do
  it 'env_create_success' do
    VCR.use_cassette 'env_create_success', record: :new_episodes do
      token    = 'ddded641ce395aac73a6c829e0cf63b52a15c074'
      acc_name = 'nqtien310'
      app_id   = 52876
      suffix   = Time.now.to_i
      env_name = "testeyromapi_#{suffix}"
      env      = ENV['FRAMEWORK_ENV'] || 'build3'
      region   = 'us-east-1'
      app_stack = 'nginx_unicorn'
      db_stack  = "postgres9_4"
      language  = 'Ruby 2.0.0'
      client    = Ey::Core::Client.new(token: token)
      account   = client.accounts.first(name: acc_name)

      environment_params = {
        'application_id' => app_id,
        'account_id'     => account.id,
        'region'         => region,
        'name'           => env_name,
        'stack_name'     => app_stack,
        'database_stack' => db_stack,
        'language'       => language
      }
      environment = account.environments.create(environment_params)
      environment.boot( { configuration: { type: 'solo' } } )
    end
  end
end
