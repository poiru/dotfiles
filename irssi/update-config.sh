#!/bin/bash

set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ssh k "cat ~/.irssi/config" | perl -pe '
  BEGIN{undef $/;}
  s/.*password.*\n//g;
  s/^((channels|ignores|logs|windows) = [\{\(]).*?^([\}\)];)/\1\3/gms;
' > "$script_dir/config"
