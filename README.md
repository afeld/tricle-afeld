# Aidan's Tricle

See the [the Tricle gem documentation](https://github.com/artsy/tricle#readme) for general instructions.

## Usage

To preview the app, run

```bash
bundle
# get the GITHUB_TOKEN from https://github.com/settings/applications
# and the MEETUP_KEY from http://www.meetup.com/meetup_api/key/
GITHUB_TOKEN=... MEETUP_KEY=... bundle exec shotgun
open http://localhost:8080
```

## Deploying

1. Deploy app to Heroku
1. Set up SendGrid with `heroku addons:add sendgrid`
1. Set up Heroku Scheduler to run `rake tricle:emails:send`, or trigger manually with `heroku run rake tricle:emails:send`
