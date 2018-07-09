# vim: foldmethod=marker

if status --is-interactive
   and status --is-login
   and [ -z "$XDG_CURRENT_DESKTOP" ]
   and [ -z "$TMUX" ]
   and command --search keychain
  # use keychain to add our rsa key
  eval (keychain --agents ssh --clear --eval id_rsa)
end

# enable vi mode in fish
fish_vi_key_bindings

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Replace the vi mode prompt indicator with an empty function to disable it
function fish_mode_prompt; end

# powerline | powerline/powerline {{{1

if pyenv which powerline > /dev/null ^ /dev/null
  set -l path_tail 'lib/python3.7/site-packages/powerline/bindings/fish'
  set -l powerline_path (string join \
                           '/' \
                           (dirname (dirname (pyenv which powerline))) \
                           $path_tail)
  if [ -x $powerline_path ]
    set fish_function_path $fish_function_path $powerline_path
    powerline-setup
  end
end

# }}}1
