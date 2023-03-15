if status --is-interactive
    and status --is-login
    # enable vi mode in fish
    fish_vi_key_bindings

    # make the selection inclusive
    set fish_cursor_selection_mode inclusive
end

# silence the greeting
set --global fish_greeting
