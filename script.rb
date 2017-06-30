#=========  Get token ===========
ey_api   = EY::CloudClient.new
token    = ey_api.authenticate!(email, password)
app      = EY::CloudClient::App.new(ey_api, {:id => app_id, :name => app_name})
email    = 'nqtien310@gmail.com'
password = 'iRwKnWEGUFUDCqVRLLqBW2pR'
#================================
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
debugger
1
