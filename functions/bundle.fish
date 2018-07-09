function bundle --description 'Ruby bundler with proxy disabled'
  set -l http_proxy
  set -l https_proxy
  command bundle $argv
end
