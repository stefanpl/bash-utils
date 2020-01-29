# bash-utils
A collection of bash functions for day-to-day usage.

## How to use this:
Right now, a lot of the functions depend on each other, so its best to use them all at once.
The bash utils expect a `BASH_UTILS_LOCATION` variable in your environment. So:
```bash
cd [parent folder]
git clone https://github.com/stefanpl/bash-utils
```

Then set in your .zshenv / .bashrc file:
```bash
BASH_UTILS_LOCATION=[parent folder]/bash-utils
source ${BASH_UTILS_LOCATION}/bootstrap.sh
```

Alternatively, to make your shell files more flexible, you can do something like:
```bash
# Put `export BASH_UTILS_LOCATION=path` in your .env!
source ~/.oh-my-zsh/.env
source ${BASH_UTILS_LOCATION}/bootstrap.sh
```
