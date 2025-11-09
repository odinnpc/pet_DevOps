# pet_DevOps
# server-stats

A small, portable Bash script that gathers basic server performance stats:
- Total CPU usage
- Total memory usage (free vs used, with percentage)
- Total disk usage (free vs used, with percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage

Stretch stats:
- OS/version info
- Uptime
- Load average
- Logged-in users
- Recent failed login attempts (best-effort; may require root)

## Files
- server-stats.sh — the main script (make executable).

## Quick run (local)
bash
chmod +x server-stats.sh
./server-stats.sh

# Log Archive Tool

A small CLI tool to archive log directories (e.g. `/var/log`) into timestamped `tar.gz` files and record each archive in a log file.

## Features
- Archive a logs directory into `logs_archive_YYYYMMDD_HHMMSS.tar.gz`
- Store archives in a separate directory (default: `<log-dir>/archives`)
- Record each archive action to `archive.log` with timestamp, source dir, archive path and size
- Optional `--keep DAYS` to delete older archives
- `--dry-run` mode to preview actions without making changes

## Files
- `log-archive` — the executable Bash script
- `README.md` — this file
- `.gitignore` — (optional)
- `LICENSE` — MIT

## Usage
Make executable:
bash
chmod +x log-archive


Basic run:
bash
./log-archive /var/log


Specify output directory and keep 30 days of archives:
bash
./log-archive /var/log --out-dir /var/log/archives --keep 30


Dry-run example (no changes):
bash
./log-archive /var/log --dry-run


Crontab example (run daily at 2:10am):
cron
10 2 * * * /path/to/log-archive /var/log --out-dir /var/log/archives --keep 90 >> /var/log/log-archive-cron.log 2>&1


Notes
- If the `--out-dir` is inside the source log directory, the script will exclude it from the archive to avoid recursion.
- The script uses `tar` and `gzip`. It should work on most Linux distributions.
- Archiving `/var/log` usually requires root privileges to read all files; run with `sudo` in that case.
