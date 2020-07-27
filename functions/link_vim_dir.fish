function link_vim_dir --description 'Create links to approriate nvim files in ~/.vim/'
  mkdir --parents ~/.vim/autoload/

  ln --symbolic ~/.config/nvim/autoload/airline/ ~/.vim/autoload/airline
  ln --symbolic ~/.local/share/nvim/site/autoload/plug.vim ~/.vim/autoload/plug.vim
  ln --symbolic ~/.config/nvim/coc-settings.json ~/.vim/coc-settings.json
  ln --symbolic ~/.config/nvim/colors/ ~/.vim/colors
  ln --symbolic ~/.config/nvim/ftplugin/ ~/.vim/ftplugin
  ln --symbolic ~/.local/share/nvim/plugged/ ~/.vim/plugged
  ln --symbolic ~/.config/nvim/ginit.vim ~/.vim/gvimrc
  ln --symbolic ~/.config/nvim/init.vim ~/.vim/vimrc
end
