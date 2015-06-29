# Elasticsearch _All_ The Tweets

###Getting setup

I'm assuming you've got the repository checked out and you already have a [twitter app](https://apps.twitter.com/) created with read access.

**Install Elasticsearch**

1. Make sure you've got your Mac with [brew](http://brew.sh/) installed (if you happen to be using a windows machine, you should go out and get a Mac)
2. Install elasticsearch with brew
```bash
$ brew install elasticsearch && brew info elasticsearch
```
3. Start elastic search
```bash
$ ln -sfv /usr/local/opt/elasticsearch/*.plist ~/Library/LaunchAgents
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
```
At this point you should have elasitic search up and running. You will need to run
```bash
$ launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist
```
again if you restart your machine.

**Create Your Settings File**

The settings.json file has the following structure:

```json
{
    "twitterApiKey":"<your key here>",
    "twitterApiSecret":"<your secret here>",
    "twitterAccessToken":"<your access token here>",
    "twitterAccessSecret":"<your access secret here>",
    "esHost":"localhost:9200"
}
```

All keys starting with `twitter` come from the app you created on <https://apps.twitter.com/>

`esHost` is the location of your elastic search instance. Host: localhost and port: 9200 are the default settings.

Create the settings file and take note of it's location.

### Starting Meteor
After elasticsearch has been installed/running and you've created a valid settings.json file you can start the meteor server.

```bash
$ meteor --settings path/to/meteor/settings.json
```

Soon after starting the server you'll start collecting and indexing tweets. When the machine has collected 10,000 tweets it will stop collecting and indexing data. At this point you can go to <http://localhost:3000> to test it out!
