#!/usr/bin/env bats

load '/usr/local/lib/bats-support/load.bash'
load '/usr/local/lib/bats-file/load.bash'
load '/usr/local/lib/bats-assert/load.bash'

@test "git is configured" {
  assert_file_exist "$HOME/.gitconfig"
  assert_file_exist "$HOME/.gitignore_global"
  run git config --list --global
  assert_output --partial 'Ryan Pfeffer'
}
  

@test "psql client is configured" {
  assert_file_exist "$HOME/.psqlrc"
}

@test "Compatibility fixes for awscli are in place" {
  assert_file_exist "/usr/local/opt/python/bin/python2.7"
  run aws 
}

@test "Fish is installed" {
  run which fish
  [ "$status" -eq 0 ]
  [ "$output"="/usr/local/bin/fish" ]
}

@test "Fish is set as the main shell" {
  [ "$SHELL"="/usr/local/bin/fish" ]
}


@test "Fisherman is installed" {
  assert_file_exist "$HOME/.config/fish/functions/fisher.fish"
}

@test "Vim is configured" {
  assert_file_exist "$HOME/.vimrc"
}

@test "Vundle is installed" {
  assert_file_exist "$HOME/.vim/bundle/Vundle.vim"
}

@test "vim plugins are installed" {
   
  assert_file_exist "$HOME/.vim/bundle/FastFold"
  assert_file_exist "$HOME/.vim/bundle/SimpylFold"
  assert_file_exist "$HOME/.vim/bundle/YouCompleteMe"
  assert_file_exist "$HOME/.vim/bundle/Zenburn"
  assert_file_exist "$HOME/.vim/bundle/csv.vim"
  assert_file_exist "$HOME/.vim/bundle/ctrlp.vim"
  assert_file_exist "$HOME/.vim/bundle/indentpython.vim"
  assert_file_exist "$HOME/.vim/bundle/nerdcommenter"
  assert_file_exist "$HOME/.vim/bundle/nerdtree"
  assert_file_exist "$HOME/.vim/bundle/powerline"
  assert_file_exist "$HOME/.vim/bundle/python-mode"
  assert_file_exist "$HOME/.vim/bundle/syntastic"
  assert_file_exist "$HOME/.vim/bundle/vim-flake8"
  assert_file_exist "$HOME/.vim/bundle/vim-fugitive"
  assert_file_exist "$HOME/.vim/bundle/vim-gitgutter"
  assert_file_exist "$HOME/.vim/bundle/vim-marked"
}

@test "Vim's Completion engine server, YCM, runs when VIM does" {
  screen_session='ycmd.vim.aliveness'
  # First run vim inside a screen and send it to the background
  run screen -S $screen_session -dm vim "$(mktemp)" 
  # Give the ycmd server some time to start up
  sleep 3
  # Check for the ycmd python process
  run "$(ps -e | grep ycmd)"
  assert_output --partial 'ycmd'
  assert_output --partial 'python'
  screen -X -S $screen_session quit
}


