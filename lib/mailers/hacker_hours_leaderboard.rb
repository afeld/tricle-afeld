class HackerHoursLeaderboard < Tricle::Mailer
  default(to: 'aidan.feldman@gmail.com', from: 'aidan.feldman@gmail.com')

  group "Three-month summary" do
    metric HackerHoursRsvps
  end

  list TopHaxors do |haxor|
    url = "http://www.meetup.com/hackerhours/members/#{haxor[:id]}/"
    <<-HTML
      <a href="#{url}" target="_blank" style="text-decoration:none">
        <img src="#{haxor[:photo]}" width="90" alt="avatar"/>
      </a>
      <a href="#{url}" target="_blank">#{haxor[:name]}:</a>
      #{haxor[:rsvps]}
    HTML
  end
end
