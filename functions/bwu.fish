function bwu \
    --description 'Run `bw unlock (read -s)` with a fancy prompt and set BW_SESSION'
    if not command --query bw
        echo 'bw is not installed!'
        exit 1
    end

    set --global --export BW_SESSION \
        (bw unlock --raw (read --silent --prompt=bw_password_prompt))
end
