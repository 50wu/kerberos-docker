#!/usr/bin/env bats

@test "Test SSH connection with Kerberos authentication" {
  run ./ssh_test.sh bob krb5-service.example.com '-o PreferredAuthentications=gssapi-with-mic'
  # Success
  [ "$status" -eq 0 ]
}

@test "Test SSH connection with password authentication" {
  run ./ssh_test.sh bob krb5-service.example.com '-o PreferredAuthentications=password' '-t'
  # Time out
  [ "$status" -eq 124 ]
}

@test "Test SSH connection with public key authentication" {
  run ./ssh_test.sh bob krb5-service.example.com '-o PreferredAuthentications=publickey'
  # Permission denied (no pair of keys)
  [ "$status" -eq 255 ]
}

@test "Test SSH connection with false user" {
  run ./ssh_test.sh alice
  # SSH error
  [ "$status" -eq 255 ]
}

@test "Test SSH connection with false server" {
  run ./ssh_test.sh bob krb5-service.example.org
  # SSH error
  [ "$status" -eq 255 ]
}

@test "Test SSH connection with false command" {
  run ./ssh_test.sh bob krb5-service.example.com '-o PreferredAuthentications=gssapi-with-mic' '' 'unknown'
  # Unknown command
  [ "$status" -eq 127 ]
}
