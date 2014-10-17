#!/usr/bin/env ruby

require 'fileutils'

BASE_DIR = File.dirname(__FILE__)

links = {
  'fonts'     => '.fonts',
  'gnome.rc'  => '.gnomerc',
  'tmux.rc'   => '.tmux.conf',
  'urxvt.rc'  => '.Xdefaults',
  'vim'       => '.vim',
  'vim.rc'    => '.vimrc',
  'xmobar.rc' => '.xmobarrc',
  'xmonad.rc' => '.xmonad/xmonad.hs',
  'zprofile'  => '.zprofile',
  'zsh.rc'    => '.zshrc'
}

def delete(file)
  if File.symlink? file then
    File.unlink file
  elsif File.directory? file then
    Dir.delete file
  elsif File.exist?(file)
    File.delete file
  end
end

def link_rc(paths)
  puts "[Linking rc files]"
  paths.each_pair { |points_to, file|
    points_to = File.expand_path "#{BASE_DIR}/#{points_to}"
    file = File.expand_path "~/#{file}"
    delete(file) unless File.identical?(file, points_to) 

    if not File.exists?(file) then 
      puts "Symlinked #{points_to} -> #{file}"
      FileUtils.mkdir_p(File.dirname(file))
      File.symlink points_to, file
    end
  }
end

def update_git
  puts "[Updating git submodules]"
  `git submodule update --init`
end

def install_vim_plugins
  puts "[Updating vim plugins]"
  `vim +BundleInstall +BundleUpdate +qall`
end

link_rc(links)
update_git
install_vim_plugins
