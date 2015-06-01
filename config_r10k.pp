class { 'r10k':
  sources => {
    'puppet-repo00' => {
      'remote'  => 'https://github.com/eddyhub/puppet-repo00.git',
      'basedir' => "/etc/puppetlabs/code/environments",
      'prefix'  => true,
    },
    'puppet-repo01' => {
      'remote'  => 'https://github.com/eddyhub/puppet-repo01.git',
      'basedir' => "/etc/puppetlabs/code/environments",
      'prefix'  => true,
    },
  },
}
