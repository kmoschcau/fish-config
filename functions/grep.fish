function grep \
    --description 'grep with default options' \
    --wraps grep
    command grep --color=auto --label=STDIN --line-number --initial-tab $argv
end
