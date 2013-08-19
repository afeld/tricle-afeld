require 'faraday'
require 'tricle/range_data'

MEETUPS_BY_START_TIME = Tricle::RangeData.new

# docs
# http://www.meetup.com/meetup_api/key/
# http://www.meetup.com/meetup_api/docs/2/events/
#
# original URL
# https://api.meetup.com/2/events?&sign=true&status=past&group_urlname=hackerhours&time=-3m,&key=KEY
url = 'http://api.meetup.com/2/events?status=past&order=time&limited_events=False&group_urlname=hackerhours&desc=false&offset=0&format=json&page=200&fields=&time=-3m%2C&sig_id=8818215&sig=df406624ed3e11fa4652094ea3bca75bb5c4fe74'

response = Faraday.get(url)
data = JSON.parse(response.body)
data['results'].each do |event|
  start_at = Time.at(event['time'] / 1000.0)
  MEETUPS_BY_START_TIME.add(start_at, event)
end

MEETUPS_BY_START_TIME.freeze
