class HackerHoursRsvps < Tricle::Metric
  def title
    "Hacker Hours RSVPs"
  end

  def size_for_range(start_at, end_at)
    meetups = MEETUPS_BY_START_TIME.items_for_range(start_at, end_at)
    meetups.sum {|event| event['yes_rsvp_count'] }
  end

  def total
    meetups = MEETUPS_BY_START_TIME.all_items
    meetups.sum {|event| event['yes_rsvp_count'] }
  end
end
