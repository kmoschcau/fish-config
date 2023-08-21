function update_langs \
    --description 'Update installed programming languages.'

    # Go =======================================================================
    if command --query goenv
        echo "Updating goenv"
        pushd "$HOME/.goenv"
        git pull
        popd
    end

    # node.js ==================================================================
    if command --query nodenv
        nodenv update
    end

    if command --query npm
        npm update --global
    end

    # PHP ======================================================================
    if command --query phpenv
        phpenv update
    end

    # Python ===================================================================
    if command --query pyenv
        pyenv update
    end

    if command --query pip-review
        pip-review --auto
    end

    # Ruby =====================================================================
    if command --query rbenv
        rbenv update
    end

    if command --query gem
        gem update
        gem clean
    end

    # Rust =====================================================================
    if command --query rustup
        rustup update
    end
end
