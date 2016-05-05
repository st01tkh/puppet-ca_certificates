class ca_certificates::params {
  $src_url = 'http://curl.haxx.se/ca/cacert.pem'
  if ($operatingsystem == 'windows') {

    $sysroot = env("SYSTEMROOT")
    $sys32 = file_join_win(["${sysroot}", "System32"])

    $cert_pem_path = file_join_win(["${sys32}", "ssl", "cert.pem"])
    $certs_dir_path = file_join_win(["${sys32}", "ssl", "certs"])

  } else {
      fail("$operatingsystem is not supported")
  }
}
