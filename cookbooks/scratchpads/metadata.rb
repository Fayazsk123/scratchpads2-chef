name             'scratchpads'
maintainer       'Simon Rycroft'
maintainer_email 's.rycroft@nhm.ac.uk'
license          'CC BY 4.0'
description      'Installs and configures all services required to run a Scratchpads instance'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
issues_url       'https://github.com/NaturalHistoryMuseum/scratchpads2-chef/issues'
source_url       'https://github.com/NaturalHistoryMuseum/scratchpads2-chef'

depends 'apache2',         '~> 3.0'
depends 'apt',             '~> 2.7'
depends 'database',        '~> 4.0'
depends 'git',             '~> 4.2'
depends 'imagemagick',     '~> 0.2'
depends 'iptables',        '~> 1.0'
depends 'java',            '~> 1.35'
depends 'memcached',       '~> 1.7'
depends 'mmonit',          '~> 0.1'
depends 'monit-ng',        '~> 2.0'
depends 'mysql2_chef_gem', '~> 1.0'
depends 'nfs',             '~> 2.2'
depends 'percona',         '~> 0.16'
depends 'php',             '~> 1.5'
depends 'postfix',         '~> 3.6'
depends 'scratchpads',     '~> 0.1'
depends 'sudo',            '~> 2.7'
depends 'varnish',         '~> 2.2'
