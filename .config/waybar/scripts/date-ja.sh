
#!/usr/bin/env bash

# Output hanya tanggal dalam format Jepang
DATE=$(LC_TIME=ja_JP.UTF-8 date '+%Y年 %-m月 %-d日 (%A)')

# Tambahkan pemisah di depan (nanti jadinya: clock | date)
echo "| $DATE"
