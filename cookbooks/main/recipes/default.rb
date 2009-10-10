# -- Install REE in /opt
script "REE installation" do
  interpreter "bash"
  code <<-EOH
    cd ~
    mkdir src
    cd src
    wget #{node[:ree_source]}
    tar zxf #{File.basename(node[:ree_source])}
    sudo ./#{File.basename(node[:ree_source], '.tar.gz')}/installer --auto=/opt/#{File.basename(node[:ree_source], '.tar.gz')}
  EOH
end

#-- Install gems with REE
node[:gems].each do |gem|
  script "REE gem install of #{gem[:name]}" do
    interpreter "bash"
    code <<-EOH
      sudo /opt/#{File.basename(node[:ree_source], '.tar.gz')}/bin/ruby /opt/#{File.basename(node[:ree_source], '.tar.gz')}/bin/gem install --no-rdoc --no-ri #{gem[:name]} --version '#{gem[:version] || '>0.0.0'}'
    EOH
  end
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

#-- Clean up chef artifacts with 10rubygems 
script "Ensure RUBYOPTS is not picked up" do
  interpreter "bash"
  code <<-EOH
    sudo rm -f /etc/env.d/10rubygems.chef*
  EOH
end

#-- Update env vars
script "ree_env_update" do
  interpreter "bash"
  code <<-EOH
    sudo /usr/sbin/env-update
  EOH
end

#-- Update thins to use the generic ruby
template "/usr/bin/thin" do
  mode 0755
  source "thin.erb"
end



#-- Create the switcher script
template "/home/#{node[:user] || File.basename(Dir.glob("/home/*").first)}/eyruby_switch.rb" do
  mode 0755
  source "eyruby_switch.rb.erb"
end

