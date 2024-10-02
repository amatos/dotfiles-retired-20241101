#!/usr/bin/env fish

# Local environment variables.
if test -e "$HOME/.local.env"
    source "~/.local.env"
end

# Enable Atuin
if status is-interactive
    atuin init fish | source
end
