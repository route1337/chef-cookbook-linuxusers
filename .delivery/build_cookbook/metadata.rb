name 'build_cookbook'
maintainer 'Matthew Ahrenstein'
maintainer_email 'matthew@route1337.com'
license 'mit'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'delivery-truck'
