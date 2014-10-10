# OS X Status Bar Integration for Thyme

This Gem adds OS X status bar integration to Thyme,
allowing you to always see the remaining time.

![Screenshot (hosted by imgur.com)](http://i.imgur.com/VICYfLF.png)

This works by compiling an Objective-C code that simply displays the text passed via standard input on the status bar when you install the gem, so make sure you have `clang` installed.

<b></b>

:mushroom::alien::cloud::octopus::snail::x::shoe::turtle::angel::trollface::umbrella::star2::bread::apple::rabbit::icecream::nose::tomato::elephant::gun::rabbit2::ant::tomato::icecream::octopus::nose::fish::octopus::rabbit::turtle::heart::yum::mailbox::eyeglasses::rabbit::bike:

<b></b>

## Installation and Usage

First, install the gem:

```bash
gem install thyme_osx_ui
```


Then, modify your `.thymerc` by adding `before`, `tick`, and `after` hooks as follows:

```ruby
before do
  $ui = ThymeOSX::UI.new
end

tick do |seconds_left|
  $ui.tick(seconds_left)
end

after do |seconds_left|
  $ui.destroy
end
```

Now whenever you start a pomodoro with `thyme`, you should see a status bar item.
Clicking on it and selecting "void" will kill the pomodoro.


<b></b>

:moon::angel::cat::octopus::snowman::x::sheep::trollface::angel::trollface::umbrella::star2::banana::angel::rabbit::icecream::nail_care::turtle::eyeglasses::ghost::rabbit2::angel::tomato::icecream::octopus::nose::floppy_disk::octopus::rabbit2::trollface::horse::yum::mushroom::eyes::rocket::balloon:

<b></b>

Customization
-------------

You can subclass the class `ThymeOSX::UI` and override these methods:

- `emoji(seconds_left)` — to change the emoji icon.
- `text(seconds_left)` — to change the text, which include the emoji and time left.
    - So if you want to keep the emoji, you must call `emoji(seconds_left)` yourself.

