# Default editor
export EDITOR='subl -w'

# Open Sublime Text project
osp() {
	d=$(pwd)
	while ! (find "$d" -mindepth 1 -maxdepth 1 -name '*.sublime-project' | grep --quiet sublime-project) ; do
		d=${d%/*}
		if [ "$d" == "" ]; then break; fi
	done
	if [ "$d" != "" ]; then
		for f in "$d"/*.sublime-project ; do
			echo "Opening $f"
			subl --project "$f"
		done
	else
		echo "No *.sublime-project file found."
	fi
}
