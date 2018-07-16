function gem --description 'Ruby gem with proxy disabled'
  env http_proxy='' https_proxy='' gem $argv
end
