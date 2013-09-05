# include all metrics
Dir[File.join(File.dirname(__FILE__), '..', 'metrics', '*.rb')].each{|file| require file }

class WeeklyMetrics < Tricle::Mailer
  default(to: 'aidan.feldman@gmail.com', from: 'aidan.feldman@gmail.com')

  group "GitHub" do
    metric OpenSourceCommits
  end

  group "Meetup" do
    metric HackerHoursRsvps
  end

  list TopHaxors do |haxor|
    %[<a href="http://www.meetup.com/hackerhours/members/#{haxor[:id]}/" target="_blank">#{haxor[:name]}</a>: #{haxor[:rsvps]}]
  end
end
