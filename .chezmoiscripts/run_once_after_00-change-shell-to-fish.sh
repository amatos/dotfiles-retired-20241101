#!/bin/bash

if [ "$SHELL" != "$(which fish)" ]; then
	chsh -s "$(which fish)"
fi
