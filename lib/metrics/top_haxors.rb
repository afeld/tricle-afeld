class TopHaxors < Tricle::Metric
  def items_for_range(start_at, end_at)
    haxors_by_id = {}

    rsvps = RSVPS_BY_MEETUP_TIME.all_items
    rsvps.each do |rsvp|
      member = rsvp['member']
      member_id = member['member_id']
      haxors_by_id[member_id] ||= { id: member_id, rsvps: 0 }
      haxors_by_id[member_id][:name] ||= member['name']
      haxors_by_id[member_id][:rsvps] += 1
    end

    # by number of "yes" RSVPs, descending
    haxors_by_id.values.sort_by{|rsvp| -1 * rsvp[:rsvps] }.first(15)
  end
end
