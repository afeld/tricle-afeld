class HackerHoursLeaderboard < Tricle::Mailer
  default(to: 'aidan.feldman@gmail.com', from: 'aidan.feldman@gmail.com')

  group "Three-month summary" do
    metric HackerHoursRsvps
  end

  list TopHaxors do |haxor|
    %[<a href="http://www.meetup.com/hackerhours/members/#{haxor[:id]}/" target="_blank">#{haxor[:name]}</a>: #{haxor[:rsvps]}]
  end
end
