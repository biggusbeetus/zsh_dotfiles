# From https://web.archive.org/web/20210506080335/https://mah.everybody.org/docs/ssh
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

function add_github_key {
  echo "Adding github key..."
  github_key=~/.ssh/github_key
  if [[ -e github_key ]]; then
    /usr/bin/ssh-add $github_key
    echo added github ssh key
  else
    echo no github ssh key found :c
  fi
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
        add_github_key;
    }
else
    start_agent;
    add_github_key;
fi
