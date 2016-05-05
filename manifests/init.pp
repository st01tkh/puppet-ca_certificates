# == Class: ca_certificates
#
# Update CA certificates
#
# === Parameters
#
# === Variables
#
# === Examples
#
#  class { 'ca_certificates':
#    source_url => '',
#  }
#
# === Authors
#
# st01tkh <st01tkh@gmail.com>
#
# === Copyright
#
# Copyright 2016 st01tkh
#


class ca_certificates(
  $src_url = $ca_certificates::params::src_url,
  $cert_pem_path = $ca_certificates::params::cert_pem_path,
  $certs_dir_path = $ca_certificates::params::certs_dir_path
) inherits ca_certificates::params {
  if ($operatingsystem == 'windows') {
    notify {"src_url: $src_url": }
    notify {"cert_pem_path: $cert_pem_path": }
    notify {"certs_dir_path: $certs_dir_path": }
    $cert_pem_dirname = dirname($cert_pem_path)
    $cert_pem_basename = basename($cert_pem_path)
    notify {"cert_pem_dirname: $cert_pem_dirname": }
    $certs_dir_dirname = dirname($certs_dir_path)
    notify {"certs_dir_dirname: $certs_dir_dirname": }
    recursive_directory { "$cert_pem_dirname":
        win_mode => yes
    } ->
    download_file {"download_${cert_pem_path}":
        url => $src_url,
        destination_directory => "$cert_pem_dirname",
        destination_file => "$cert_pem_basename",
    }
    if ($cert_pem_dirname != $certs_dir_dirname) {
        recursive_directory { "$certs_dir_dirname":
            win_mode => yes
        }
    }
    windows_env {'SSL_CERT_FILE':
        ensure    => present,
        variable  => 'SSL_CERT_FILE',
        value     => $cert_pem_path,
        mergemode => 'clobber',
    }
    windows_env {'SSL_CERT_DIR':
        ensure    => present,
        variable  => 'SSL_CERT_DIR',
        value     => $certs_dir_path,
        mergemode => 'clobber',
    }
  } else {
      notify {"$operatingsystem is not supported": }
  }
}
