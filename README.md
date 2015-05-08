# Sharp Aquos Remote Control

This gem enables remote control functionality for Sharp Aquos televisions.

## Sharp Aquos Setup

1. Ensure the television is turned on.
2. Hit the 'Menu' button on your remote.
3. Navigate to 'Initial Setup'
4. Navigate to 'Internet Setup'
5. Navigate to 'Aquos Remote Control'
6. Enable the Remote Control functionality.
7. (optional) Go to Detailed Settings and set a username/password.

## How to use this gem

```rb
tv = SharpAquosRemoteControl.new("192.168.1.1")

tv.on
# => "OK"

tv.volume 15
# => "OK"

tv.volume?
# => "15"

tv.mute
# => "OK"

tv.muted?
# => true

tv.unmute
# => "OK"

tv.off
# => "OK"
```

## How this gem works

This gem uses a TCP socket to send messages to your TV over wi-fi. The
messages that are sent can be found in the Sharp user manual. The manual
used specifically for this gem can be found in the repo:
`sharp_manual.pdf`.

The MIT License (MIT)
