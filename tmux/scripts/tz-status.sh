#!/usr/bin/env bash
# Emits tmux status-right with NY/UK/TR segments. The segment matching the
# system's IANA timezone (via /etc/localtime) is highlighted; if none match,
# all three render in the dim style.

sys_tz=$(readlink /etc/localtime 2>/dev/null | sed 's|.*/zoneinfo/||')

# Kanagawa Wave palette
bar_bg="#2A2A37"
dim_bg="#717C7C"   # katanaGray
hi_bg="#E6C384"    # carpYellow
fg="#2A2A37"

ny_bg=$dim_bg
uk_bg=$dim_bg
tr_bg=$dim_bg

case "$sys_tz" in
    America/New_York) ny_bg=$hi_bg ;;
    Europe/London)    uk_bg=$hi_bg ;;
    Europe/Istanbul)  tr_bg=$hi_bg ;;
esac

seg() {
    local bg=$1 prev_bg=$2 label=$3 time=$4
    local attrs=""
    [[ "$bg" == "$hi_bg" ]] && attrs=",bold"
    printf '#[fg=%s,bg=%s]#[fg=%s,bg=%s%s] %s %s ' \
        "$bg" "$prev_bg" "$fg" "$bg" "$attrs" "$label" "$time"
}

ny_time=$(TZ=America/New_York date '+%H:%M %Z')
uk_time=$(TZ=Europe/London date '+%H:%M %Z')
tr_time=$(TZ=Europe/Istanbul date '+%H:%M %Z')

printf '#[bg=%s,noitalics,nobold]' "$bar_bg"
seg "$ny_bg" "$bar_bg" "NY" "$ny_time"
seg "$uk_bg" "$ny_bg"  "UK" "$uk_time"
seg "$tr_bg" "$uk_bg"  "TR" "$tr_time"
