#!/bin/sh

# Keluar segera jika ada perintah yang gagal
set -e

# Skrip ini akan mencari semua modul yang punya folder 'test' dan menjalankannya
find . -name "pubspec.yaml" -not -path "./.fvm/*" -exec dirname {} \; | while read dir; do
  if [ -d "$dir/test" ]; then
    echo "--- Running tests in $dir ---"
    (cd "$dir" && flutter test)
  fi
done