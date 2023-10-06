function ll \
    --description 'll with default options' \
    --wraps ls
    if string match 'Darwin' (uname)
        command ls \
                -a \
                --color=auto \
                -F \
                -h \
                -l \
                -q \
                $argv
    else
        command ls \
                --all \
                --color=auto \
                --classify \
                --group-directories-first \
                --human-readable \
                -l \
                --hide-control-chars \
                $argv
    end
end
