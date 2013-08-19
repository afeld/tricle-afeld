require 'octokit'
require 'tricle/range_data'

GITHUB_COMMITS_BY_TIME = Tricle::RangeData.new

hit_three_weeks_ago = false
oldest_time = Time.now.beginning_of_week.weeks_ago(3).freeze

(1..30).each do |page|
  events = Octokit.user_public_events('afeld', page: page)

  events.each do |event|
    time = Time.parse(event['created_at']).to_time
    if event['type'] == 'PushEvent'
      event['payload']['commits'].each do |commit|
        GITHUB_COMMITS_BY_TIME.add(time, commit)
      end
    end

    hit_three_weeks_ago = true if time < oldest_time
  end

  break if hit_three_weeks_ago
end

GITHUB_COMMITS_BY_TIME.freeze
