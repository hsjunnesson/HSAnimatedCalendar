# HSAnimatedCalendar version 1.0

A `UIViewController` which display an animated calendar display

Created by Hans Sjunnesson (hans.sjunnesson@gmail.com). Copyright 2010
Hans Sjunnesson. All rights reserved.

## What's this?

The HSAnimatedCalendarViewController is an iPhone `UIViewController`
which uses timers to update the `UIImageViews` the controller
references. These `UIViews` represent the component parts of a date
and time, or the number of years, days, hours, and seconds left to a
target date.

## How do I set this up?

The HSAnimatedCalendarViewController will load its configuration from
a plist-file with the same name as its nib-file. So for instance, a
HSAnimatedCalendarViewController loaded from the file `CountDown.xib`
will expect to load the file `CountDown.plist` as its configuration.

A proper configuration file looks something like this:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Countdown</key>
        <true/>
        <key>CountdownDate</key>
        <date>2010-12-24T00:00:00Z</date>
        <key>transitionType</key>
        <string>fade</string>
        <key>transitionSubType</key>
        <string>right</string>
        <key>transitionDuration</key>
        <real>0.25</real>
    </dict>
    </plist>

If the key `Countdown` is set to true, the controller will display the
number of years, months, days, hours and seconds to the date specified
by the key `CountdownDate`. If the key `Countdown` isn't set, the
controller will display the current date and time, and animate the
view as time progresses.

The key `transitionType` dictates the type of `CATransitions` applied
to the animated numbers. The allowed values are: `fade`, `moveIn`,
`push`, and `reveal`. These are the standard `CATransition` types.

The `transitionSubType` dictates the subtype of the `CATransition`, of
which the following are supported: `right`, `left`, `top`, and
`bottom`

## License

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this program. If not, see
<http://www.gnu.org/licenses/>.

