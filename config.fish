# enable vi mode in fish
if status --is-interactive
   and status --is-login
  fish_vi_key_bindings
end
