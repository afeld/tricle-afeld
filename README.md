# Aidan's Tricle

See the [the Tricle gem documentation](https://github.com/artsy/tricle#readme) for general instructions.

## Usage

To preview the app, run

```bash
bundle
# get the GITHUB_TOKEN from https://github.com/settings/tokens/new?scopes=public_repo
# and the MEETUP_KEY from http://www.meetup.com/meetup_api/key/
GITHUB_TOKEN=... MEETUP_KEY=... bundle exec shotgun
open http://localhost:8080
```

## Deploying

See general [deployment instructions](https://github.com/afeld/tricle#deploying), and use SendGrid as the mail provider with `SENDGRID_USERNAME` and `SENDGRID_PASSWORD` environment variables (set automatically by enabling the Heroku Addon: `heroku addons:add sendgrid`).
