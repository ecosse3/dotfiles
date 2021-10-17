#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
  arg1=$2
  echo "$arg1"

	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	if [[ "$style" == "hack" || "$style" == "cuts" ]]; then
		polybar -q top -c "$dir/$style/config.ini" &
		polybar -q bottom -c "$dir/$style/config.ini" &
	elif [[ "$style" == "pwidgets" ]]; then
		bash "$dir"/pwidgets/launch.sh --main
	elif [[ "$arg1" == "twitch" ]]; then
		polybar -q twitch -c "$dir/$style/config.ini" &
	else
		polybar -q main -c "$dir/$style/config.ini" &
	fi
}

if [[ "$1" == "--material" ]]; then
	style="material"
	launch_bar

elif [[ "$1" == "--shades" ]]; then
	style="shades"
	launch_bar

elif [[ "$1" == "--hack" ]]; then
	style="hack"
	launch_bar

elif [[ "$1" == "--docky" ]]; then
	style="docky"
	launch_bar

elif [[ "$1" == "--cuts" ]]; then
	style="cuts"
	launch_bar

elif [[ "$1" == "--shapes" ]]; then
	style="shapes"
	launch_bar

elif [[ "$1" == "--grayblocks" ]]; then
	style="grayblocks"
	launch_bar

elif [[ "$1" == "--blocks" ]]; then
	style="blocks"
	launch_bar twitch

elif [[ "$1" == "--blocks" && "$2" == "--twitch" ]]; then
	style="blocks"
	launch_bar twitch

elif [[ "$1" == "--colorblocks" ]]; then
	style="colorblocks"
	launch_bar

elif [[ "$1" == "--forest" ]]; then
	style="forest"
	launch_bar

elif [[ "$1" == "--pwidgets" ]]; then
	style="pwidgets"
	launch_bar

elif [[ "$1" == "--panels" ]]; then
	style="panels"
	launch_bar

else
	cat <<- EOF
	Usage : launch.sh --theme --option

	Available themes:
	--blocks    --colorblocks    --cuts      --docky
	--forest    --grayblocks     --hack      --material
	--panels    --pwidgets       --shades    --shapes

  Available options:
  --twitch
	EOF
fi
