# -- Install REE in /opt
script "ree_installation" do
  interpreter "bash"
  cwd "~"
  code <<-EOH
    wget #{node[:ree][:source]}
    tar zxf #{File.basename(node[:ree][:source])}
    ./#{File.basename(node[:ree][:source], '.tar.gz')}/installer --auto=/opt/#{File.basename(node[:ree][:source], '.tar.gz')}
  EOH
end

#-- Install gems with REE
node[:gems].each do |gem|
  interpreter "bash"
  cwd "~"
  code <<-EOH
    /opt/#{File.basename(node[:ree][:source], '.tar.gz')}/bin/ruby /opt/#{File.basename(node[:ree][:source], '.tar.gz')}/bin/gem install --no-rdoc --no-ri #{gem}
  EOH
end

#-- Update env to include REE GC params
template "/etc/env.d/11ruby" do
  mode 0644
  source "11ruby.erb"
end

#-- Get rid of the RUBYOPT env param
template "/etc/env.d/10rubygems" do
  mode 0644
  source "10rubygems.erb"
end

#-- Update env vars
script "ree_env_update" do
  cwd "~"
  interpreter "bash"
  code <<-EOH
    /usr/sbin/env-update
  EOH
end

#-- Update thins to use the generic ruby
template "/usr/bin/thin" do
  mode 0755
  source "thin.erb"
end

#-- Create the switcher script
template "~/eyruby_switch.rb" do
  mode 0755
  source "eyruby_switch.rb.erb"
end


