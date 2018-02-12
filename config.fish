# vim: foldmethod=marker

if status --is-interactive
   and status --is-login
   and [ -z "$XDG_CURRENT_DESKTOP" ]
   and [ -z "$TMUX" ]
  # use keychain to add our rsa key
  eval (keychain --agents ssh --clear --eval id_rsa)
end

# Replace the vi mode prompt indicator with an empty function to disable it
function fish_mode_prompt; end

# powerline | powerline/powerline {{{1

set fish_function_path $fish_function_path "$HOME/.pyenv/versions/3.6.3/lib/python3.6/site-packages/powerline/bindings/fish"
powerline-setup

# }}}1
