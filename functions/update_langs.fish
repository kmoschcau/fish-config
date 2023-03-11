function update_langs \
         --description 'Update installed programming languages.'
  if command --search nodenv &> /dev/null
    nodenv update
  end

  if command --search npm &> /dev/null
    npm update --global
  end

  if command --search pyenv &> /dev/null
    pyenv update
  end

  if command --search pip-review &> /dev/null
    pip-review --auto
  end

  if command --search rbenv &> /dev/null
    rbenv update
  end

  if command --search gem &> /dev/null
    gem update
    gem clean
  end

  if command --search rustup &> /dev/null
    rustup update
  end
end
