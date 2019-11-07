function bwu --description 'Run `bw unlock (read -s)` with a fancy prompt'
  bw unlock (read --silent --prompt=bw_password_prompt)
end
