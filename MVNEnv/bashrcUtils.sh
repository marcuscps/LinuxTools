# Alias to clear terminal (including all history)
# use it together with .inputrc file.
# So you can map it to ^K, for instance
alias clearx='echo -en \\033c'

bind -x '"\C-K": "clearx"'

source ~/MVNEnv/definePrompt.sh

export SSH_ASKPASS=ssh-askpass

