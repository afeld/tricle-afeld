require 'octokit'
require 'tricle/range_data'

token = ENV['GITHUB_TOKEN'] || raise("please set GITHUB_TOKEN - https://github.com/settings/applications")
client = Octokit::Client.new(login: 'me', oauth_token: token)

GITHUB_COMMITS_BY_TIME = Tricle::RangeData.new

hit_three_months_ago = false
oldest_time = Time.now.beginning_of_week.weeks_ago(13).freeze

(1..30).each do |page|
  events = client.user_public_events('afeld', page: page)

  events.each do |event|
    time = Time.parse(event['created_at']).to_time
    if event['type'] == 'PushEvent'
      event['payload']['commits'].each do |commit|
        GITHUB_COMMITS_BY_TIME.add(time, commit)
      end
    end

    if time < oldest_time
      hit_three_months_ago = true
      break
    end
  end

  break if hit_three_months_ago
end

GITHUB_COMMITS_BY_TIME.freeze
