function fzf_preview --description 'Generates a preview for fzf'
  if string match --quiet --regex binary (file --mime $argv[1])
    echo $argv[1]' is a binary file'
  else
    highlight --out-format truecolor --line-numbers $argv[1] 2> /dev/null;
    or cat $argv[1] 2> /dev/null
  end
end
