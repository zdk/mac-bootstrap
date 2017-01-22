resource_name :brew

action :install do
  execute "brew install #{name}"
end
