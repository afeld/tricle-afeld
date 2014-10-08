class HackerHoursMembers < Tricle::Metric
  def size_for_range(start_at, end_at)
    0 # TODO get real value
  end

  def total
    response = Faraday.get('http://api.meetup.com/2/groups',
      format: 'json',
      group_urlname: 'hackerhours,Hacker-Hours-Boulder,trianglehackerhours',
      key: MEETUP_KEY
    )
    data = JSON.parse(response.body)
    data['results'].sum {|result| result['members'] }
  end
end
