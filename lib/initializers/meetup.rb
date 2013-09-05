require 'faraday'
require 'json'
require 'tricle/range_data'

key = ENV['MEETUP_KEY'] || raise("please set MEETUP_KEY - http://www.meetup.com/meetup_api/auth/#keys")
MEETUPS_BY_START_TIME = Tricle::RangeData.new

# http://www.meetup.com/meetup_api/docs/2/events/
response = Faraday.get('http://api.meetup.com/2/events',
  desc: false,
  fields: '',
  format: 'json',
  group_urlname: 'hackerhours',
  key: key,
  limited_events: 'False',
  offset: 0,
  order: 'time',
  page: 200,
  status: 'past',
  time: '-3m,'
)

data = JSON.parse(response.body)
data['results'].each do |event|
  start_at = Time.at(event['time'] / 1000.0)
  MEETUPS_BY_START_TIME.add(start_at, event)
end

MEETUPS_BY_START_TIME.freeze
