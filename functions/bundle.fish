function bundle --description 'Ruby bundler with proxy disabled'
  env http_proxy='' https_proxy='' bundle $argv
end
