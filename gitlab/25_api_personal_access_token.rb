# Inspired by https://gitlab.com/gitlab-org/gitlab/-/blob/master/db/fixtures/development/25_api_personal_access_token.rb
# frozen_string_literal: true

puts "=======================================".color(:red)
puts "---------------------------------------".color(:red)
puts "Creating api access token for root user".color(:red)
puts "---------------------------------------".color(:red)
puts "=======================================".color(:red)


# Create an api access token for root user with the value:
scopes = Gitlab::Auth.all_available_scopes

Gitlab::Seeder.quiet do
  User.find_by(username: 'root').tap do |user|
    params = {
      scopes: scopes.map(&:to_s),
      name: 'seeded-api-token'
    }

    user.personal_access_tokens.build(params).tap do |pat|
      pat.expires_at = 365.days.from_now
      pat.set_token(ENV['GITLAB_ROOT_PASSWORD'])
      pat.save!
    end
  end

  print 'OK'
end