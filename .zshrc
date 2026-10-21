# Zsh Configuration

# Enable unique paths (Zsh native way to prevent duplicate PATH entries)
typeset -U PATH path
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# History settings (Required for zsh-autosuggestions to remember past commands)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Rust / Cargo
. "$HOME/.cargo/env"

# ─── Modern tool aliases ───
alias cat='bat'
alias grep='rg'
alias find='fdfind'
alias du='dust'
alias ls='eza --long --all --group --group-directories-first --icons --header --time-style long-iso --git'

# ─── Navigation ───
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias back='cd -'

# ─── Safety nets ───
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# ─── Quick look ───
alias h='history | grep '
alias dfh='df -h'
alias duh='du -sh ./* ./.* 2>/dev/null'

# ─── Git shortcuts ───
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate -15'

# ─── Misc ───
alias c='clear'
alias l1='ls -1'
alias serve='python3 -m http.server'

# ─── zoxide ───
eval "$(zoxide init zsh)"

# ─── fzf ───
source <(fzf --zsh)

# Initialize completion for installed binaries
autoload -Uz compinit
compinit

# Source the autosuggestions plugin
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize Starship prompt
eval "$(starship init zsh)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

setopt interactivecomments

# Fetch Command
macchina

# DotFile Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
export PATH="$(ruby -e "print Gem.user_dir")/bin:$PATH"

# System Update Aliase
alias sysu='sudo dnf upgrade --refresh -y'

# Directory where mocks and Obsidian tracker live
export MOCK_DIR="$HOME/Documents/LawPrep/Mocks"

# Run the mock logger from anywhere
alias mocklog="$MOCK_DIR/mocklog.sh"

# Quickly cat a specific week and mock: usage `mockcat <week> <mock>` (e.g., `mockcat 1 4`)
mockcat() {
    local w=$(printf "\%02d" "${1:-1}")
    local m=$(printf "\%02d" "${2:-1}")
    cat "$MOCK_DIR/Week_${w}/Mock_${m}.txt"
}

export MOCK_DIR="$HOME/Documents/LawPrep/Mocks"

# ==============================================================================
# CLAT & AILET Mock Tracker CLI Suite (Multi-Line Simplistic Edition - Zsh Safe)
# ==============================================================================
export MOCK_DIR="$HOME/Documents/LawPrep/Mocks"
alias mocklog="$MOCK_DIR/mocklog.sh"

# Internal helper: strips Obsidian [[path\|alias]] wiki-links and escaped pipes
_mock_clean_stream() {
    sed -E 's/\[\[[^]]*\\\|([^]]*)\]\]/\1/g; s/\\\|/;/g' "$MOCK_DIR/Mock_Tracker.md"
}

# 1. mockavg [clat|ailet|sectional|all]
mockavg() {
    local raw_tag="${1:-clat}"
    _mock_clean_stream | awk -F'|' -v raw="$raw_tag" '
        BEGIN {
            t = tolower(raw)
            tag = (t == "all" ? "#" : "#" t)
        }
        tolower($5) ~ tag {
            sc_col = 0
            for (i = 1; i <= NF; i++) {
                if ($i ~ /\*\*/) { sc_col = i; break }
            }
            if (!sc_col) next
            count++

            raw_sc = $sc_col; gsub(/\*\*| /, "", raw_sc)
            split(raw_sc, sc_parts, "/")
            score = sc_parts[1] + 0
            max_m = (sc_parts[2] ? sc_parts[2] + 0 : 120)

            acc   = $(sc_col + 1); gsub(/%| /, "", acc); acc += 0
            neg   = $(sc_col - 1); gsub(/-| /, "", neg); neg += 0
            unatt = $(sc_col - 2) + 0
            wrong = $(sc_col - 3) + 0
            corr  = $(sc_col - 4) + 0
            att   = $(sc_col - 5) + 0

            sum_s += score; sum_m += max_m; sum_acc += acc; sum_neg += neg
            sum_att += att; sum_corr += corr; sum_wrong += wrong; sum_unatt += unatt

            if (count == 1 || score > best_s) best_s = score
            if (count == 1 || score < low_s)  low_s  = score
            if (count == 1 || acc > best_acc) best_acc = acc
            if (count == 1 || acc < low_acc)  low_acc  = acc
        }
        END {
            if (count > 0) {
                label = (tag == "#" ? "ALL TESTS" : toupper(tag))
                printf "\n  \033[1;36mMOCK ANALYTICS\033[0m  %s\n", label
                printf "  ------------------------------------------------\n"
                printf "  \033[1mTests Logged\033[0m  : %d\n", count
                printf "  \033[1mAvg Score\033[0m     : %.2f / %.1f   (Best: %.2f | Low: %.2f)\n", sum_s/count, sum_m/count, best_s, low_s
                printf "  \033[1mAvg Accuracy\033[0m  : %.1f%%         (Best: %.1f%% | Low: %.1f%%)\n", sum_acc/count, best_acc, low_acc
                printf "  \033[1mAvg Attempted\033[0m : %.1f          (Corr: %.1f | Wrong: %.1f | Unatt: %.1f)\n", sum_att/count, sum_corr/count, sum_wrong/count, sum_unatt/count
                printf "  \033[1mAvg Negatives\033[0m : -%.2f\n\n", sum_neg/count
            } else {
                printf "\n  \033[1;31m[!] No entries found for filter:\033[0m %s\n\n", tag
            }
        }
    '
}

# 2. mocklist [clat|ailet|sectional]
mocklist() {
    local raw_tag="${1:-}"
    _mock_clean_stream | awk -F'|' -v raw="$raw_tag" '
        BEGIN {
            t = tolower(raw)
            tag = (t == "" || t == "all" ? "#" : "#" t)
        }
        tolower($5) ~ tag {
            sc_col = 0
            for (i = 1; i <= NF; i++) {
                if ($i ~ /\*\*/) { sc_col = i; break }
            }
            if (!sc_col) next
            count++

            date_s = $2; gsub(/^ +| +$/, "", date_s)
            week_s = $3; gsub(/^ +| +$/, "", week_s)
            mock_s = $4; gsub(/^ +| +$/, "", mock_s)
            exam_s = $5; gsub(/^ +| +$/, "", exam_s)
            src_s  = $6; gsub(/^ +| +$/, "", src_s)

            score_s = $sc_col; gsub(/\*\*|^ +| +$/, "", score_s)
            acc_s   = $(sc_col + 1); gsub(/^ +| +$/, "", acc_s)
            neg_s   = $(sc_col - 1); gsub(/^ +| +$/, "", neg_s)
            unatt_s = $(sc_col - 2); gsub(/^ +| +$/, "", unatt_s)
            wrong_s = $(sc_col - 3); gsub(/^ +| +$/, "", wrong_s)
            corr_s  = $(sc_col - 4); gsub(/^ +| +$/, "", corr_s)
            att_s   = $(sc_col - 5); gsub(/^ +| +$/, "", att_s)
            brk_s   = $(sc_col + 2); gsub(/;/, " | ", brk_s); gsub(/^ +| +$/, "", brk_s)
            rem_s   = $(sc_col + 3); gsub(/^ +| +$/, "", rem_s)

            printf "\n  \033[1;36m[%s - %s]\033[0m \033[1m%s\033[0m (%s) | %s\n", week_s, mock_s, src_s, exam_s, date_s
            printf "  ------------------------------------------------\n"
            printf "  \033[1mScore\033[0m     : %s   (Acc: %s | Neg: %s)\n", score_s, acc_s, neg_s
            printf "  \033[1mAttempts\033[0m  : %s Attempted (Corr: %s | Wrong: %s | Unatt: %s)\n", att_s, corr_s, wrong_s, unatt_s
            printf "  \033[1mSections\033[0m  : %s\n", brk_s
            printf "  \033[1mRemarks\033[0m   : %s\n", rem_s
        }
        END {
            if (count > 0) printf "\n  \033[2mTotal displayed: %d\033[0m\n\n", count
            else printf "\n  \033[1;31m[!] No matching mocks found.\033[0m\n\n"
        }
    '
}

# 3. mockcat [week] [mock_num] [sec]
mockcat() {
    local target_file=""
    if [[ $# -eq 0 ]]; then
        target_file=$(find "$MOCK_DIR" -maxdepth 2 -name "*.txt" -printf "%T@ %p\n" 2>/dev/null | sort -nr | head -n 1 | cut -d' ' -f2-)
    else
        local w=$(printf "%02d" "$((10#${1:-1}))")
        local m=$(printf "%02d" "$((10#${2:-1}))")
        local prefix="Mock"
        [[ "${3:-}" == "sec" ]] && prefix="Sec"
        target_file="$MOCK_DIR/Week_${w}/${prefix}_${m}.txt"
    fi

    if [[ -z "$target_file" || ! -f "$target_file" ]]; then
        printf "\n  \033[1;31m[!] Report not found:\033[0m %s\n\n" "${target_file:-No .txt files in $MOCK_DIR}"
        return 1
    fi

    awk -F'|' '
        /MOCK REPORT|TEST REPORT/ { gsub(/^ +| +$/, "", $2); title = $2 }
        /TIMELINE/                { gsub(/^ +| +$/, "", $2); time_s = $2 }
        (NR > 6 && $2 !~ /SECTION|Accuracy|Remarks/ && NF >= 7) {
            sec = $2; gsub(/^ +| +$/, "", sec)
            max = $3; gsub(/^ +| +$/, "", max)
            att = $4; gsub(/^ +| +$/, "", att)
            cor = $5; gsub(/^ +| +$/, "", cor)
            wrg = $6; gsub(/^ +| +$/, "", wrg)
            una = $7; gsub(/^ +| +$/, "", una)
            net = $8; gsub(/^ +| +$/, "", net)
            if (sec == "TOTAL") {
                tot_line = sprintf("  \033[1m%-24s\033[0m : %6s / %-4s (Att: %2s | Corr: %2s | Wrong: %2s | Unatt: %2s)", sec, net, max, att, cor, wrg, una)
            } else if (sec != "") {
                sec_lines = sec_lines sprintf("  %-24s : %6s / %-4s (Att: %2s | Corr: %2s | Wrong: %2s | Unatt: %2s)\n", sec, net, max, att, cor, wrg, una)
            }
        }
        /Accuracy/ {
            acc = $2; gsub(/Accuracy *:|^ +| +$/, "", acc)
            neg = $3; gsub(/Negatives Lost *:|^ +| +$/, "", neg)
        }
        /Remarks/ {
            rem = $2; sub(/^ *Remarks *: */, "", rem); gsub(/ +$/, "", rem)
        }
        END {
            printf "\n  \033[1;36m%s\033[0m\n", title
            printf "  \033[2m%s\033[0m\n", time_s
            printf "  --------------------------------------------------------------------------\n"
            printf "%s", sec_lines
            printf "  --------------------------------------------------------------------------\n"
            printf "%s\n", tot_line
            printf "  \033[1mAccuracy\033[0m                 : %s   |   \033[1mNegatives Lost\033[0m : %s\n", acc, neg
            printf "  \033[1mRemarks\033[0m                  : %s\n\n", rem
        }
    ' "$target_file"
}

# 4. mocksec [clat|ailet|sectional]
mocksec() {
    local raw_tag="${1:-clat}"
    _mock_clean_stream | awk -F'|' -v raw="$raw_tag" '
        BEGIN {
            t = tolower(raw)
            tag = (t == "all" ? "#" : "#" t)
        }
        tolower($5) ~ tag {
            sc_col = 0
            for (i = 1; i <= NF; i++) {
                if ($i ~ /\*\*/) { sc_col = i; break }
            }
            if (!sc_col) next
            brk = $(sc_col + 2)
            n = split(brk, parts, ";")
            for (i = 1; i <= n; i++) {
                gsub(/^ +| +$/, "", parts[i])
                split(parts[i], kv, ":")
                sec_name = kv[1]; gsub(/^ +| +$/, "", sec_name)
                split(kv[2], sc_m, "/")
                s_val = sc_m[1] + 0
                m_val = sc_m[2] + 0
                if (m_val > 0) {
                    sec_count[sec_name]++
                    sec_sum_s[sec_name] += s_val
                    sec_sum_m[sec_name] += m_val
                    if (sec_count[sec_name] == 1) order[++num_secs] = sec_name
                }
            }
        }
        END {
            if (num_secs > 0) {
                printf "\n  \033[1;36mSECTIONAL AVERAGES\033[0m (%s)\n", toupper(tag)
                printf "  ------------------------------------------------\n"
                for (i = 1; i <= num_secs; i++) {
                    k = order[i]
                    c = sec_count[k]
                    avg_s = sec_sum_s[k] / c
                    avg_m = sec_sum_m[k] / c
                    pct   = (sec_sum_s[k] / sec_sum_m[k]) * 100
                    printf "  \033[1m%-10s\033[0m : %6.2f / %-5.1f  (%5.1f%% net yield across %d tests)\n", k, avg_s, avg_m, pct, c
                }
                printf "\n"
            } else {
                printf "\n  \033[1;31m[!] No sectional breakdown data found for:\033[0m %s\n\n", tag
            }
        }
    '
}

export PATH="$PATH:/home/rudraasthana/Documents/Kairos/kairos"
export EDITOR=nvim
export VISUAL=nvim
