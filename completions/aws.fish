function __fish_complete_aws
    set --local --export COMP_SHELL fish
    set --local --export COMP_LINE \
        (commandline --current-process --cut-at-cursor)
    aws_completer | string trim
end

test -x (which aws_completer)
and complete --command aws --no-files --arguments '(__fish_complete_aws)'
