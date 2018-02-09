# personal functions for fish shell

function ll --description 'List contents of directory using -aFhl and colors'
  ls -aFhl --color=auto $argv
end

function grep --description 'grep with automatic colors'
  grep --color=auto
end
