function tree \
    --description 'Show a tree view of directory with some default options' \
    --wraps tree
    command tree -F --dirsfirst -C $argv
end
