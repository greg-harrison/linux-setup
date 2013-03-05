#!/usr/bin/env ruby

BASE_DIR = File.dirname(__FILE__)

links = {
  '.vimrc'            => 'rc.vim',
  '.vim'              => 'vim',
  '.zshrc'            => 'rc.zsh',
  '.zprofile'         => 'zprofile',
  '.tmux.conf'        => 'rc.tmux',
  '.Xdefaults'        => 'urxvt.rc',
  '.xmonad/xmonad.hs' => 'xmonad.rc',
  '.xmobarrc'         => 'xmobar.rc',
  '.fonts'            => 'fonts',
  '.gnomerc'          => 'rc.gnome'
}

def link_rc(paths)
  paths.each_pair { |file, points_to|
    points_to = File.expand_path "#{BASE_DIR}/#{points_to}"
    file = File.expand_path "~/#{file}"
    if File.exists?(file) && !File.identical?(file, points_to)  then 
      if File.symlink? file then
        File.unlink file
      elsif File.directory? file then
        Dir.delete file
      else
        File.delete file
      end
    end
    if not File.exists?(file) then 
      puts "Symlinked #{points_to} -> #{file}"
      begin
        File.symlink points_to, file
      rescue
        File.delete file
        File.symlink points_to, file
      end
    end
  }
end

`git submodule update --init`
`vim +BundleInstall +qall`
link_rc(links)
