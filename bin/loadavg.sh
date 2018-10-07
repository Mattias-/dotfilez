#!/bin/bash
set -euo pipefail

cut -d " " -f 1-3 /proc/loadavg
