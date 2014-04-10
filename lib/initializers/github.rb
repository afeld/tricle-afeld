require 'octokit'
require 'tricle/range_data'

token = ENV['GITHUB_TOKEN'] || raise("please set GITHUB_TOKEN - https://github.com/settings/applications")

GITHUB_COMMITS_BY_TIME = Tricle::RangeData.new

# GitHub restricts this API to 300 events, so the historical numbers may be low
# http://developer.github.com/v3/activity/events/
client = Octokit::Client.new(auto_traversal: true, login: 'me', access_token: token)
events = client.user_public_events('afeld')

events.each do |event|
  if event['type'] == 'PushEvent'
    time = event['created_at']
    event['payload']['commits'].each do |commit|
      GITHUB_COMMITS_BY_TIME.add(time, commit)
    end
  end
end

GITHUB_COMMITS_BY_TIME.freeze
