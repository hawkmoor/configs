#!/bin/bash
exe=`dmenu_path | dmenu -nb '#ffffff' -nf '#181818' -sb '#181818' -sf '#ffffff'` && eval "exec $exe"
