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

### run it
``` foreman start ```

### see it
``` open http://localhost:5000 ```

## Notes

### Make a local request like how Slack would
```
curl -s -X POST -H "Content-Type: application/json" -d '{"command": "/pic", "user_name": "sevengenres", "text": "kittens"}' http://localhost:5000/
```
