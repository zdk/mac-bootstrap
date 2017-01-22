package "git"
package "tree"
package "vim"

# Oh-My-ZSH
git "/Users/di/.oh-my-zsh" do
  repository 'git://github.com/robbyrussell/oh-my-zsh.git'
  user "di"
  reference "master"
  action :sync
end

execute "cp /Users/di/.zshrc /Users/di/.zshrc.orig" do
  only_if { File.exists?("/Users/di/.zshrc") }
end

execute "cp /Users/di/.oh-my-zsh/templates/zshrc.zsh-template /Users/di/.zshrc"

template "/Users/di/.zshrc" do
  source "zshrc.erb"
  owner "di"
  mode "644"
  action :create_if_missing
  variables({
    theme: "sunrise",
    plugins: "git bundler osx rake ruby",
  })
end

#Ruby
brew "rbenv"
brew "ruby-build"
