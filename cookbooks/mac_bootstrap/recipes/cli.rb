package "git"
package "tree"
package "vim"

# Ruby
brew "rbenv"
brew "ruby-build"

# Vim Vundle
bash "Install Vundle" do
  code <<-EOH
mkdir -p ~/.vim/bundle/ && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall +qall
  EOH
  not_if { File.exists?("/Users/di/.vim/bundle") }
end


# AWS
brew "awscli"
