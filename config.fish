# vim: foldmethod=marker

# enable vi mode in fish
if status --is-interactive
   and status --is-login
  fish_vi_key_bindings
end

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Replace the vi mode prompt indicator with an empty function to disable it
function fish_mode_prompt; end

# powerline | powerline/powerline {{{1
if command --search pyenv > /dev/null 2> /dev/null
  if pyenv which powerline > /dev/null 2> /dev/null
    set --local path_tail 'lib/python3.8/site-packages/powerline/bindings/fish'
    set --local powerline_path\
                (string join '/' \
                             (dirname (dirname (pyenv which powerline))) \
                             $path_tail)
    if test -x $powerline_path
      set --append fish_function_path $powerline_path
      powerline-setup
    end
  end
end
# }}}1
