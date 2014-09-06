require 'faraday'
require 'json'
require 'tricle/range_data'

key = ENV['MEETUP_KEY'] || raise("please set MEETUP_KEY - http://www.meetup.com/meetup_api/auth/#keys")
key.freeze

MEETUPS_BY_START_TIME = Tricle::RangeData.new

# http://www.meetup.com/meetup_api/docs/2/events/
response = Faraday.get('http://api.meetup.com/2/events',
  desc: false,
  format: 'json',
  group_urlname: 'hackerhours',
  key: key,
  limited_events: 'False',
  offset: 0,
  only: 'id,time,yes_rsvp_count',
  order: 'time',
  page: 200,
  status: 'past',
  time: '-3m,'
)

event_ids = []

data = JSON.parse(response.body)
data['results'].each do |event|
  start_at = Time.at(event['time'] / 1000.0)
  MEETUPS_BY_START_TIME.add(start_at, event)

  event_ids << event['id']
end

MEETUPS_BY_START_TIME.freeze


RSVPS_BY_MEETUP_TIME = Tricle::RangeData.new

# http://www.meetup.com/meetup_api/docs/2/rsvps/
response = Faraday.get('http://api.meetup.com/2/rsvps',
  event_id: event_ids.join(','),
  format: 'json',
  key: key,
  only: 'event,member,member_photo',
  rsvp: 'yes'
)

data = JSON.parse(response.body)
data['results'].each do |rsvp|
  start_at = Time.at(rsvp['event']['time'] / 1000.0)
  RSVPS_BY_MEETUP_TIME.add(start_at, rsvp)
end

RSVPS_BY_MEETUP_TIME.freeze
