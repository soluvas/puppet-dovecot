/**
 * $auth_includes: deny, master, system, sql, ldap, passwdfile,
 * checkpassword, vpopmail, static
 */
class dovecot (
  $auth_includes = ['system']
) {
  package { ['dovecot-imapd', 'dovecot-pop3d']: }
  service { dovecot:
  	ensure  => running,
  	require => Package['dovecot-imapd', 'dovecot-pop3d'],
  }

  file { '/etc/dovecot/conf.d/10-auth.conf':
  	content => template('dovecot/10-auth.conf.erb'),
  	mode    => 0644,
  	owner   => root,
  	group   => root,
  	require => Package['dovecot-imapd', 'dovecot-pop3d'],
  	notify  => Service['dovecot'],
  }
}
