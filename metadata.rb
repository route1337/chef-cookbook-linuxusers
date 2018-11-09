name 'r1337-linux-users'
maintainer 'Matthew Ahrenstein'
maintainer_email 'matthew@route1337.com'
license 'MIT'
description 'Mange users and common groups on Linux systems'
long_description 'Manage the automated adding and removal of users and common groups across Linux systems'
version '0.1.1'
chef_version '>= 13.6.4' if respond_to?(:chef_version)
issues_url 'https://github.com/route1337/chef-cookbook-linuxusers/issues'
source_url 'https://github.com/route1337/chef-cookbook-linuxusers'
depends 'apt'
depends 'users'
depends 'line'
depends 'zap'

%w{ ubuntu centos }.each do |os|
  supports os
end

recipe 'r1337-linux-users::default', 'Call this recipe to run the recipes for user and group management'
recipe 'r1337-linux-users::users', 'Manage the users of the system along with common groups'