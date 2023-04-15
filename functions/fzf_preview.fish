function fzf_preview --description 'Generates a preview for fzf'
    if string match --quiet --regex binary (file --mime $argv[1])
        echo $argv[1]' is a binary file'
    else
        if command --query bat
            bat \
                --color always \
                --italic-text always \
                $argv[1] 2>/dev/null
        else
            cat $argv[1] 2>/dev/null
        end
    end
end
