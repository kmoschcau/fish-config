function bwu --description 'Run `bw unlock (read -s)` with a fancy prompt'
  if not command --search --quiet bw
    echo 'bw is not installed!'
    exit 1
  end

  bw unlock (read --silent --prompt=bw_password_prompt)
end
