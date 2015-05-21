# Alias to clear terminal (including all history)
# use it together with .inputrc file.
# So you can map it to ^K, for instance
alias clearx='echo -en \\033c'

bind -x '"\C-K": "clearx"'

export ENV_DIR=~/MVNEnv
export SSH_ASKPASS=ssh-askpass

source ${ENV_DIR}/defineColors.sh
source ${ENV_DIR}/definePrompt.sh

