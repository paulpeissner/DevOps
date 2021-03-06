#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node['platform_family']
when "debian"
  if node['platform'] == "ubuntu" && node['platform_version'].to_f < 10.10
    package "git-core"
  else
    package "git"
  end
when "rhel","fedora"
  case node['platform_version'].to_i
  when 5
    include_recipe "yum::epel"
  end
  package "git"
when "windows"
  include_recipe 'git::windows'
when "mac_os_x"
  dmg_package "GitOSX-Installer" do
    app node['git']['osx_dmg']['app_name']
    package_id node['git']['osx_dmg']['package_id']
    volumes_dir node['git']['osx_dmg']['volumes_dir']
    source node['git']['osx_dmg']['url']
    checksum node['git']['osx_dmg']['checksum']
    type "pkg"
    action :install
  end
else
  package "git"
end

#Setup user and pull code
execute "Set user name" do
  command "git config --global user.name \"Victor Gajendran\""
  action :run
end

execute "Set user email" do
  command "git config --global user.email \"gsvicky@gmail.com\""
  action :run
end

execute "Pull code" do
  command "git clone https://github.com/gsvicky/DevOps.git"
  cwd "/usr/local/src/"
  action :run
  not_if { ::File.exists?("/usr/local/src/DevOps")}
end





