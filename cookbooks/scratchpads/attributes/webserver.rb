passwords = ScratchpadsEncryptedPasswords.new(node, node['scratchpads']['encrypted_data_bag'])
# Apache settings
#default['scratchpads']['webserver']['apache']['additional_modules'] = ['expires','ssl','dbd','dav','dav_fs','authn_dbd']
default['scratchpads']['webserver']['apache']['additional_modules'] = ['expires','ssl']
default['scratchpads']['webserver']['apache']['templates']['cc-mirror.scratchpads.eu'] = {
  'source' => 'cc-mirror.scratchpads.eu.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'cc-mirror.scratchpads.eu',
  'documentroot' => '/var/www/cc-mirror.scratchpads.eu',
  'files' => {
    'cookbook' => 'scratchpads',
    'source' => 'cc-mirror.scratchpads.eu.tar.gz'
  }
}
# Note, additional files (cache and sites folders) need to be copied to this directory. These
# are handled outside of chef due to the size of the archive (GBs).
default['scratchpads']['webserver']['apache']['templates']['archived-sites'] = {
  'source' => 'archived-sites.erb',
  'cookbook' => 'scratchpads',
  'serveraliaseses' => ['able.myspecies.info','about.e-monocot.org','blackflies.info','nannotax.org','sasarcs.myspecies.info','scicoll.myspecies.info','gpi.myspecies.info'],
  'documentroot' => '/var/www/archived',
  'files' => {
    'cookbook' => 'scratchpads',
    'source' => 'archived-sites.tar.gz'
  }
}
default['scratchpads']['webserver']['apache']['templates']['dungbeetle.co.uk'] = {
  'source' => 'dungbeetle.co.uk.erb',
  'cookbook' => 'scratchpads',
  'documentroot' => '/var/www/dungbeetle.co.uk',
  'servername' => 'dungbeetle.co.uk'
  # FILES - Due to the size of the files required, this will be handled outside of Chef.
}
help_scratchpads_eu_db_user = passwords.find_password 'help.scratchpads.eu', 'user'
help_scratchpads_eu_db_password = passwords.find_password 'help.scratchpads.eu', 'password'
default['scratchpads']['webserver']['apache']['templates']['help.scratchpads.eu'] = {
  'source' => 'help.scratchpads.eu.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'help.scratchpads.eu',
  'documentroot' => '/var/www/mediawiki',
  'database' => {
    'user' => help_scratchpads_eu_db_user,
    'password' => help_scratchpads_eu_db_password,
    'database' => 'helpscratchpadseu'
  }
}
default['scratchpads']['webserver']['apache']['templates']['wiki.scratchpads.eu'] = {
  'source' => 'wiki.scratchpads.eu.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'wiki.scratchpads.eu',
  'documentroot' => '/var/www/mediawiki'
}
default['scratchpads']['webserver']['apache']['templates']['backup.scratchpads.eu'] = {
  'source' => 'backup.scratchpads.eu.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'backup.scratchpads.eu',
  'documentroot' => '/var/aegir/backups'
}
default['scratchpads']['webserver']['apache']['templates']['sandbox.scratchpads.eu'] = {
  'source' => 'sandbox.scratchpads.eu.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'sandbox.scratchpads.eu',
  'documentroot' => '/var/www/sandbox.scratchpads.eu',
  'files' => {
    'source' => 'sandbox-files.tar.gz',
    'cookbook' => 'scratchpads'
  }
}
default['scratchpads']['webserver']['apache']['templates']['fencedine.myspecies.info'] = {
  'source' => 'fencedine.myspecies.info.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'fencedine.myspecies.info',
  'documentroot' => '/var/www/fencedine.myspecies.info',
  'git' => 'https://github.com/NaturalHistoryMuseum/fencedine.git',
}
cite_scratchpads_eu_db_user = passwords.find_password 'cite.scratchpads.eu', 'user'
cite_scratchpads_eu_db_password = passwords.find_password 'cite.scratchpads.eu', 'password'
default['scratchpads']['webserver']['apache']['templates']['cite.scratchpads.eu'] = {
  'source' => 'cite.scratchpads.eu.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'cite.scratchpads.eu',
  'documentroot' => '/var/www/cite.scratchpads.eu',
  'git' => 'https://github.com/NaturalHistoryMuseum/scratchpads-cite.git',
  'templates' => {
    'conf.php' => {
      'source' => 'conf.php.erb',
      'cookbook' => 'scratchpads',
      'path' => '/var/www/cite.scratchpads.eu/conf.php',
      'owner' => node['apache']['user'],
      'group' => node['apache']['group'],
      'mode' => '0755'
    },
  },
  'database' => {
    'user' => cite_scratchpads_eu_db_user,
    'password' => cite_scratchpads_eu_db_password,
    'host' => '',
    'database' => 'citescratchpadseu'
  }
}
apache = ScratchpadsEncryptedPasswords.new(node, 'apache')
git_scratchpads_eu_crt_lines = apache.find_password 'certificates', 'certificate'
git_scratchpads_eu_key_lines = apache.find_password 'certificates', 'key'
git_scratchpads_eu_chain_lines = apache.find_password 'certificates', 'chain'
default['scratchpads']['webserver']['apache']['templates']['git.scratchpads.eu'] = {
  'source' => 'git.scratchpads.eu.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'git.scratchpads.eu',
  'documentroot' => '/var/www/git.scratchpads.eu',
  'templates' => {
    'git.scratchpads.eu.crt' => {
      'source' => 'empty-file.erb',
      'cookbook' => 'scratchpads',
      'path' => '/etc/ssl/certs/git.scratchpads.eu.crt',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      'all_servers' => true,
      'variables' => ({
        :lines => git_scratchpads_eu_crt_lines
      })  
    },
    'git.scratchpads.eu.key' => {
      'source' => 'empty-file.erb',
      'cookbook' => 'scratchpads',
      'path' => '/etc/ssl/private/git.scratchpads.eu.key',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      'all_servers' => true,
      'variables' => ({
        :lines => git_scratchpads_eu_key_lines
      })  
    },
    'git.scratchpads.eu.ca-bundle' => {
      'source' => 'empty-file.erb',
      'cookbook' => 'scratchpads',
      'path' => '/etc/ssl/certs/git.scratchpads.eu.ca-bundle',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
      'all_servers' => true,
      'variables' => ({
        :lines => git_scratchpads_eu_chain_lines
      })  
    }
  }
}

# PHP settings
default['scratchpads']['webserver']['php']['php5enmod_command'] = '/usr/sbin/php5enmod'
default['scratchpads']['webserver']['php']['session_save_path'] = '/var/www/php-sessions'

# Pear settings
default['scratchpads']['webserver']['php']['pear']['pear_modules_custom_channels'] = {'drush' => 'pear.drush.org'}
default['scratchpads']['webserver']['php']['pear']['pecl_modules'] = ['uploadprogress','mailparse']