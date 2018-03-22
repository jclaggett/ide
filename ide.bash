#!/bin/bash

# Wrap path functions under a single path command.
ide() {
  declare cmd="${FUNCNAME}_${1:-help}"

  if ! type -t $cmd >/dev/null; then
    echo "$FUNCNAME: $1 is not a known command. See '$FUNCNAME help'." >&2
    return 1
  fi

  $cmd "${@:2}"
}

# help. 
ide_help()
{
  cat <<EOF
Integrated Development Environment for the command line. 

commands:

 init       Create a new ide project in the given
            directory.
 run        Launch the ide project in the given
            directory.
 quit       Exit from the current ide shell.
 help       Display this help.
EOF
}

# function to launch a new ide shell.
ide_run()
{
    declare usage="Usage: ide run [DIR] [COMMAND] [ARGS]..."
    declare dir="$1" cmd="${*:2}" path=

    if [[ -z "$dir" ]] ; then
        echo "ide: missing directory"
        echo "$usage"
        return 1
    fi

    if [[ ! -d "$dir" ]] ; then
        echo "ide: invalid directory '$dir'"
        echo "$usage"
        return 1
    fi

    # Normalize the path.
    dir="$(cd "$dir" && echo $PWD)"

    declare -x \
        IDE_HOME="$dir" \
        IDE_DIR="$dir/.ide" \
        IDE_CMD="$cmd"

    # Launch the ide shell, running $cmd inside that shell.
    if [[ -n "$cmd" ]] ; then
        bash -ic "$cmd"
    else
        bash
    fi
}

ide_init()
{
    declare usage="Usage: ide init DIR [module]..."
    declare dir="$1" modules="${*:2}"

    if [[ -z "$dir" ]] ; then
        echo "ide: missing directory"
        echo "$usage"
        return 1
    fi

    if [[ -e "$dir/.ide" ]] ; then
        echo "ide: $dir/.ide already exists."
        echo "$usage"
        return 1
    fi

    mkdir -p "$dir/.ide"

    cat > "$dir/.ide/bashrc" <<-EOF
		#!/bin/bash
		
		if [[ -z "\$IDE_CMD" ]] ; then
		    clear
		    echo "Welcome to the \$IDE_HOME shell!"
		    PS1="\[\033[01;31m\]\${IDE_HOME##*/}\[\033[00m\] \$PS1"
		    tree -Ad -L 3 "\$IDE_HOME"
		fi
		EOF
}


ide_quit() {
    declare usage="Usage: ide quit"
    if [[ -n "$IDE_HOME" ]]; then
        exit
    else
        echo "not an ide shell"
    fi
}


declare +x IDE_CMD  # Supress IDE_CMD

# Define quit as a convenience
alias quit="ide quit"

# Source the .ide file located in IDE_HOME if possible.
if [[ -n "$IDE_HOME" ]] ; then
    cd "$IDE_HOME"

    if [[ -f ".ide/bashrc" ]] ; then
        source ".ide/bashrc"
    fi
fi


