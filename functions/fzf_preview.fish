function fzf_preview --description 'Generates a preview for fzf'
  if string match --quiet --regex binary (file --mime $argv[1])
    echo $argv[1]' is a binary file'
  else
    if command --search highlight &> /dev/null
      highlight --out-format truecolor \
                --line-numbers \
                --force $argv[1] 2> /dev/null;
    else
      cat $argv[1] 2> /dev/null
    end
  end
end
