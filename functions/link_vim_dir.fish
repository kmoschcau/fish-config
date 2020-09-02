function link_vim_dir --description 'Create links to approriate nvim files in ~/.vim/'
  mkdir --parents ~/.vim/autoload/

  ln --symbolic\
     --target-directory ~/.vim/\
     ~/.config/nvim/after/\
     ~/.config/nvim/coc-settings.json\
     ~/.config/nvim/colors/\
     ~/.config/nvim/ftplugin/\
     ~/.local/share/nvim/plugged/
  ln --symbolic\
     --target-directory ~/.vim/autoload/\
     ~/.config/nvim/autoload/airline/\
     ~/.local/share/nvim/site/autoload/plug.vim
  ln --symbolic ~/.config/nvim/ginit.vim ~/.vim/gvimrc
  ln --symbolic ~/.config/nvim/init.vim ~/.vim/vimrc
end
