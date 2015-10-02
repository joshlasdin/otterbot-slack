# otterbot-slack
Otterbot for Slack

![dancing otter](http://i.imgur.com/NaMiw.gif)

## Requirements

This app uses Ruby 2.1.3

## How To Run It Locally

### clone it
```git clone git@github.com:joshlasdin/otterbot-slack.git```

### own it
``` cd otterbot-slack ```

### install the gems
``` bundle ```

### setup .env
You'll need to set the WEBHOOK_URL and CHANNEL variables in the .env. These come from Slack in the Incoming Webhooks Integration page. CHANNEL should start with a #. See .env.example for how the file should look.

### run it
``` foreman start -f Procfile.dev ```

### see it
``` open http://localhost:5000 ```

## Notes

### Make a local request like how Slack would
```
curl -X POST -d 'token=gIkuvaNzQIHg97ATvDxqgjtO&team_id=T0001&team_domain=example&channel_id=C2147483705&channel_name=test&user_id=U2147483697&user_name=Steve&command=/weather&text=94070' http://localhost:5000/
```
