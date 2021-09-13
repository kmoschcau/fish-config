function link_vim_dir --description 'Create links to approriate nvim files in ~/.vim/'
  mkdir --parents ~/.vim/

  ln --symbolic\
     --target-directory ~/.vim/\
     ~/.config/nvim/after/\
     ~/.config/nvim/autoload/\
     ~/.config/nvim/colors/\
     ~/.config/nvim/ftdetect/\
     ~/.config/nvim/ftplugin/\
     ~/.config/nvim/coc-settings.json
  ln --symbolic ~/.config/nvim/ginit.vim ~/.vim/gvimrc
  ln --symbolic ~/.config/nvim/init.vim ~/.vim/vimrc
end
