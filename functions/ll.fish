function ll --description 'll with default options'
  command ls --all --color=auto --classify --group-directories-first\
             --human-readable -l --hide-control-chars $argv
end
