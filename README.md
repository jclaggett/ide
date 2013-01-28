# IDE: The command line based integrated development environment.

The goal of this project is to provide an easy way to create and use multiple
'projects' all using your existing command line. Projects are simply
directories marked with a .ide subdirectory. See below for a brief explanation.

## Installation:
    git clone https://github.com/jclaggett/ide
    cat ide/bashrc.example >> ~/.bashrc
    edit ~/.bashrc and set IDE\_LIB to the git repo directory created above.

## Quick start:

    # Getting help (two ways):
    ide
    ide help

    # Designating an existing directory (~/foo) as an IDE project:
    ide init ~/foo dev # note: the dev 'module' is optional

    # Entering the newly created project:
    ide run ~/foo

    # Leaving the current project (two ways):
    ide quit
    quit # aliased to ide quit

    # Creating an alias plus variable for quickly invoking the project:
    # Tip: put this command in your .bashrc
    ide define foo ~/foo

    # Above is the really just shorthand for this:
    # foo=~/foo
    # alias foo="ide run $foo"

    # Running commands in the project's environment without entering it:
    # Below assumes 'ide define foo ...'
    foo touch a b c
    foo ls
    foo echo \$PWD
    foo history # foo has it's own history assuming you used the 'dev' module.

## Notes
I'm thinking about renaming `ide run` into `ide shell` and adding `ide cmd`.
The newly named `shell` command would continue to run commands in a subshell or
just enter the subshell if no commands are given. The `cmd` command would
provide a more formal way to interact with the project (which I'm going to
reword as an app). Specifically, apps would publish a list valid commands that
`ide cmd` would invoke.  `ide cmd <dir>` with no following args would be
shorthand for `ide cmd <dir> help`. Why? Well, I want to create applications.

### `ide cmd` Publishing
Publishing commands is accomplished by prefixing the names of commands with the
'${IDE_NAME}_'. These commands may be scripts or functions. Therefore `ide cmd
<dir> <cmd>` is equivilent to running `ide shell <dir> "\${IDE_NAME}_<cmd>"`.
