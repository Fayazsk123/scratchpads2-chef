# Apache settings
default['scratchpads']['webserver']['apache']['additional_modules'] = ['expires']
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
default['scratchpads']['webserver']['apache']['templates']['help.scratchpads.eu'] = {
  'source' => 'help.scratchpads.eu.erb',
  'cookbook' => 'scratchpads',
  'servername' => 'help.scratchpads.eu',
  'documentroot' => '/var/www/mediawiki'
}

# PHP settings
default['scratchpads']['webserver']['php']['php5enmod_command'] = '/usr/sbin/php5enmod'
default['scratchpads']['webserver']['php']['session_save_path'] = '/var/www/php-sessions'

# Pear settings
default['scratchpads']['webserver']['php']['pear']['pecl_or_pear_modules_custom_channels'] = {'drush' => 'pear.drush.org'}
default['scratchpads']['webserver']['php']['pear']['pecl_or_pear_modules'] = ['uploadprogress','mailparse','propro','raphf','pecl_http']