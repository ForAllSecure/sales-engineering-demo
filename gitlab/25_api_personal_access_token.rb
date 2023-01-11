# Inspired by https://gitlab.com/gitlab-org/gitlab/-/blob/master/db/fixtures/development/25_api_personal_access_token.rb
# frozen_string_literal: true

puts "=======================================".color(:red)
puts "---------------------------------------".color(:red)
puts "Creating api access token for root user".color(:red)
puts "---------------------------------------".color(:red)
puts "=======================================".color(:red)

token = PersonalAccessToken.new
token.user_id = User.find_by(username: 'root').id
token.name = 'api-token-for-testing'
token.scopes = ["api"]
token.set_token(ENV['GITLAB_ROOT_PASSWORD'])
token.save

print 'OK'
