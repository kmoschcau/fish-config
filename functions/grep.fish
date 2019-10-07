function grep --description 'grep with default options'
  command grep --color=auto --label=STDIN --line-number --initial-tab $argv
end
