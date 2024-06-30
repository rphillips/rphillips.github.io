#!/usr/bin/env -S just --justfile

default:
  {{ just_executable() }} --list

serve:
  zola serve

update-theme:
  git submodule update --remote --merge
