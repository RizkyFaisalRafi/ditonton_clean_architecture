#!/bin/sh

# Keluar segera jika ada perintah yang gagal
set -e

# --- 1. Jalankan Test Coverage di Setiap Modul ---
# Hapus folder coverage lama di setiap modul untuk memastikan hasil yang bersih
#find . -type d -name "coverage" -exec rm -rf {} +

# Cari semua modul yang memiliki folder 'test' dan jalankan 'flutter test --coverage'
find . -name "pubspec.yaml" -not -path "./.fvm/*" -exec dirname {} \; | while read dir; do
  if [ -d "$dir/test" ]; then
    echo "--- Generating coverage in $dir ---"
    (cd "$dir" && flutter test --coverage)
  fi
done

# --- 2. Gabungkan Semua Laporan Coverage ---
# Hapus laporan gabungan yang lama jika ada
rm -f coverage/lcov.info

# Buat direktori coverage di root jika belum ada
mkdir -p coverage

# Buat argumen untuk perintah lcov dari setiap file lcov.info yang ditemukan
LCOV_ARGS=""
for file in $(find . -name "lcov.info" -not -path "./coverage/*"); do
    LCOV_ARGS="$LCOV_ARGS -a $file"
done

echo "--- Merging coverage reports ---"
# Jalankan lcov untuk menggabungkan semua file menjadi satu
# Perintah 'lcov $LCOV_ARGS' akan espansi menjadi 'lcov -a file1 -a file2 ...'
lcov $LCOV_ARGS -o coverage/lcov.info

# --- 3. Bersihkan Path Absolut dari Laporan ---
# Ini penting agar laporan bisa dilihat dengan benar di berbagai mesin (termasuk CI/CD)
# Mengganti path absolut (SF:/path/ke/proyek/lib/file.dart) menjadi path relatif (SF:lib/file.dart)
sed -i.bak "s,$(pwd)/,,g" coverage/lcov.info

# --- 4. Hasilkan Laporan HTML ---
echo "--- Generating HTML report ---"
genhtml coverage/lcov.info -o coverage/html --legend -t "Clean Architecture Submission Expert (Faisal)" --function-coverage

echo "--- Coverage report generated in coverage/html ---"
# Buka laporan di browser (opsional, hanya untuk lokal)
open coverage/html/index.html