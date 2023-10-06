function grep \
    --description 'grep with default options' \
    --wraps grep
    if string match --regex --quiet "BSD grep" (command grep --version)
        command grep \
                --color=auto \
                --label=STDIN \
                --line-number \
                $argv
    else
        command grep \
                --color=auto \
                --label=STDIN \
                --line-number \
                --initial-tab \
                $argv
    end
end
