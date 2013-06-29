## About
This is a CLI tool that helps me use SEO techniques on youtube, since I never liked SEO guys too much - I named this tool 'scammer'.

## Expectations
To use this tool you have to have youtube channel with:
- More than 2 videos on your channel
- Talking name of channel - that immediately shows that you are about.

##Idea
Basic idea is very simple.

- you define list of channels that somehow relate to your channel
- go to these channels and find their most popular video
- scan through all comments and find most active users
- start subscribing to these active users, so they will notice you and maybe subscribe back.

## Usage
ruby scammer.rb [options]
------------------------
    -y, --youtube YOUTUBE_ID         Display commenter chart for video
    -h, --help                       Display this screen

## I think my idea is cool because...
Active users on youtube is a good idea, because:
- they are more likely to subscribe to your channel (if you properly defined channel list)
- there is a big probability they will create comments under your video
- there is a big probability they will create a flame war in comments for your video. If they come back to leave comment - you receive +1 view. So they can generate more views then anyone else in youtube world.

I think, spamming everyone with messages is a bad idea. I propose to just subscribe, it's less scammy they to show that you around. And remember, your youtube channel name - should immediately interest them.

## Thanks
- youtube_it gem
- OptionParse gem
- http://www.findnwrite.com/musings/setting-parameters-of-a-ruby-class-through-command-line-arguments/
