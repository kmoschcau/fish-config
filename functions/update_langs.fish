function update_langs \
    --description 'Update installed programming languages.'
    if command --query nodenv
        nodenv update
    end

    if command --query npm
        npm update --global
    end

    if command --query pyenv
        pyenv update
    end

    if command --query pip-review
        pip-review --auto
    end

    if command --query rbenv
        rbenv update
    end

    if command --query gem
        gem update
        gem clean
    end

    if command --query rustup
        rustup update
    end
end
