function ll \
    --description 'll with default options' \
    --wraps ls
    command ls --all --color=auto --classify --group-directories-first \
        --human-readable -l --hide-control-chars $argv
end
