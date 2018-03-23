# ide: shell based integrated development environment.

The goal of ide is to use the standard unix shell concept of a subshell as an
explicit development environment. This means that the subshell has its own
command line history, environment variables and can generally hold state
related to your working environment (e.g., tmux windows and vim buffers).
'projects' all using your existing command line. Projects are simply
directories marked with a .ide subdirectory. See below for a brief explanation.

## Installation:
```bash
    git clone https://github.com/jclaggett/ide
    cat <<EOF >> ~/.bashrc
    EOF
```

## Quick start:

```bash
    ide help

    # Initializing a new IDE
    ide init ~/foo

    # Entering a subshell within the above IDE
    ide run ~/foo

    # Leaving a subshell current IDE (three ways):
    ide quit
    quit  # aliased to ide quit
    exit  # works but you can accidently exit your login shell

    # Running commands in the IDE without entering it:
    ide run ~/foo touch a b c
    ide run ~/foo ls
    ide run ~/foo echo \$PWD
    ide run ~/foo history
```
