class HackerHoursRsvps < Tricle::Metric
  def title
    "Hacker Hours RSVPs"
  end

  def size_for_range(start_at, end_at)
    meetups = MEETUPS_BY_START_TIME.items_for_range(start_at, end_at)
    meetups.reduce(0){|sum, event| sum + event['yes_rsvp_count'] }
  end

  def total
    '-'
  end
end
