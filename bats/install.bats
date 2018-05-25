#!/usr/bin/env bats

load '/usr/local/lib/bats-support/load.bash'
load '/usr/local/lib/bats-file/load.bash'
load '/usr/local/lib/bats-assert/load.bash'

@test "git is installed" {
  result="$(which git)"
  [ "$result"="/usr/bin/git" ]
}

@test "python 2 is installed as the default python" {
  result="$(which python)"
  [ "$result"="/usr/local/opt/python@2/bin/python" ]
  result="$(python --version)"
  [ "$result"="Python 2.7.15" ]
}

@test "Python 3 is installed" {
  result="$(which python3)"
  [ "$result"="/usr/local/bin/python3" ]
}

@test "Pipenv is installed" {
  result="$(which pipenv)"
  [ "$result"="/usr/local/bin/pipenv" ]
}

