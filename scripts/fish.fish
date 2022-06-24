# Install fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# Install fish prompt
fisher install IlanCosman/tide@v6

fish_update_completions
