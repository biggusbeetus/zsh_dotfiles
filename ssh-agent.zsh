# From https://web.archive.org/web/20210506080335/https://mah.everybody.org/docs/ssh
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" 1> /dev/null
    /usr/bin/ssh-add;
}

function add_azure_key {
  azure_key=~/.ssh/azure_dev
  if [[ -e $github_key ]]; then
    /usr/bin/ssh-add --apple-use-keychain $github_key 1> /dev/null
  else
    echo "No azure dev ssh key found :c"
  fi
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ 1> /dev/null || {
        start_agent;
        add_azure_key;
    }
else
    start_agent;
    add_github_key;
fi
