#!/usr/bin/env fish

# Enable Atuin
if status is-interactive
    atuin init fish | source
end
