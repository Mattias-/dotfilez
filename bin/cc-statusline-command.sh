#!/bin/sh
input=$(cat)
currentdir=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

cyan='\033[36m'
green='\033[32m'
yellow='\033[33m'
#red='\033[31m'
reset='\033[0m'

ctx_used_fmt=$(printf "%.0f%%" "$used")
cost_fmt=$(printf "$%.2f" "$cost")

echo "${currentdir##*/} ${cyan}$model${reset} ${green}${cost_fmt}${reset} ${yellow}${ctx_used_fmt}${reset}"
