#!/usr/bin/env ruby

require 'rbconfig'

BASE_DIR = File.dirname(__FILE__)
BUNDLE_DIR = "vim/bundle"
SUBMODULE_DIR = "submodules"

vim_bundles = [
  'https://github.com/mileszs/ack.vim.git',
  'https://github.com/kien/ctrlp.vim.git',
  'https://github.com/Lokaltog/vim-powerline.git',
  'https://github.com/tpope/vim-rails.git',
  'https://github.com/vim-scripts/ruby-matchit.git',
  'https://github.com/vim-scripts/taglist.vim.git',
  'https://github.com/duganchen/vim-soy.git',
  'https://github.com/Rip-Rip/clang_complete.git',
  'https://github.com/tpope/vim-fugitive.git',
  'https://github.com/scrooloose/syntastic.git',
  'https://github.com/vim-scripts/SearchComplete.git',
  'https://github.com/garbas/vim-snipmate.git',
  'https://github.com/MarcWeber/vim-addon-mw-utils.git',
  'https://github.com/vim-scripts/tlib.git',
  'https://github.com/tsaleh/vim-supertab.git',
  'https://github.com/derekwyatt/vim-scala.git'
]

submodules = [
  'https://github.com/tpope/vim-pathogen.git',
  'https://github.com/zsh-users/zsh-history-substring-search.git',
  'https://github.com/zsh-users/zsh-syntax-highlighting.git',
  'https://github.com/seebi/dircolors-solarized.git',
  'https://github.com/robbyrussell/oh-my-zsh.git'
]

links = {
  '.vimrc' => 'rc.vim',
  '.vim' => 'vim',
  '.zshrc' => 'rc.zsh',
  '.zprofile' => 'zprofile',
  '.tmux.conf' => 'rc.tmux',
  '.vim/autoload' => 'submodules/vim-pathogen/autoload',
  '.Xdefaults' => 'urxvt.rc',
  '.xmonad/xmonad.hs' => 'xmonad.rc',
  '.xmobarrc' => 'xmobar.rc'
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
      puts "Symlinked #{file} -> #{points_to}"
      begin
        File.symlink points_to, file
      rescue
        File.delete file
        File.symlink points_to, file
      end
    end
  }
end

def update_repos
  Dir.glob("#{BASE_DIR}/**/.git").each do |git_dir|
    update_repo(File.expand_path("#{git_dir}/.."))
  end
end

def update_repo(dir)
  p dir
  if File.exists?(dir) && File.directory?(dir)
    puts "Updating #{dir}"
    cwd = Dir.pwd
    Dir.chdir(dir)
    `git pull`
    Dir.chdir(cwd)
  end
end

def install_vim_plugin(repo)
  download_repo(repo, BUNDLE_DIR)
end

def install_submodule(repo)
  download_repo(repo, SUBMODULE_DIR)
end

def download_repo(repo, dir)
  repo_dir = "#{dir}/#{File.basename(repo)}"
  unless File.exists?(repo_dir)
    puts "Adding submodule #{repo}"
    `git submodule add #{repo} #{dir}/#{File.basename(repo)}`
  end
end

update_repos
submodules.each{|b| install_submodule(b)}
link_rc(links)
vim_bundles.each{|b| install_vim_plugin(b)}

