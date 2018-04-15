
-- app shortcuts

local app_switch = {'ctrl', 'cmd', 'alt', 'shift'}

function app_shortcut(character, application)
   hs.hotkey.bind(app_switch, character, function() hs.application.launchOrFocus(application) end)
end

app_shortcut('a', 'Activity Monitor')
app_shortcut('b', 'iBooks')
app_shortcut('c', 'Google Chrome')
app_shortcut('d', 'Dash')
app_shortcut('e', 'Emacs')
app_shortcut('j', 'JQBX')
app_shortcut('k', 'Slack')
app_shortcut('l', 'LimeChat')
app_shortcut('m', 'Messages')
app_shortcut('p', '1Password 6')
app_shortcut('s', 'Spotify')
app_shortcut('t', 'iTerm')
app_shortcut('v', 'VLC')
app_shortcut('w', 'Preview')


-- movement shortcuts

local move_switch = {'ctrl', 'alt', 'shift'}

function move_shortcut(name, x_mod, y_mod, w_mod, h_mod)
   hs.hotkey.bind(move_switch, name, function()
      local window = hs.window.focusedWindow()
      local window_frame = window:frame()
      local screen_frame = window:screen():frame()
      window_frame.x = screen_frame.x + x_mod * screen_frame.w
      window_frame.y = screen_frame.y + y_mod * screen_frame.h
      window_frame.w = screen_frame.w * w_mod
      window_frame.h = screen_frame.h * h_mod
      window:setFrame(window_frame)
   end)
end

move_shortcut('H', 0, 0, 0.5, 1)
move_shortcut('L', 0.5, 0, 0.5, 1)
move_shortcut('J', 0, 0.5, 1, 0.5)
move_shortcut('K', 0, 0, 1, 0.5)
move_shortcut('U', 0, 0, 0.67, 1) -- fat left
move_shortcut('E', 0, 0, 0.33, 1) -- squeeze left
move_shortcut('I', 0.33, 0, 0.34, 1) -- squeeze middle
move_shortcut('O', 0.67, 0, 0.33, 1) -- squeeze right
move_shortcut('N', 0, 0, 1, 1) -- full screen
move_shortcut(',', -1, 0, 1, 1) -- left monitor
move_shortcut('.', 1, 0, 1, 1) -- right monitor
