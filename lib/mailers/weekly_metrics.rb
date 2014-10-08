class WeeklyMetrics < Tricle::Mailer
  default(to: 'aidan.feldman@gmail.com', from: 'aidan.feldman@gmail.com')

  group "GitHub" do
    metric OpenSourceCommits
  end

  group "Meetup" do
    metric HackerHoursMembers
    metric HackerHoursRsvps
  end
end
