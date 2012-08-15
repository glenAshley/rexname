rexname
=======

NPM utility module to rename files/folders using regular expressions.

## Installation

Install globally via NPM

    npm install -g rexname

## Usage

    rexname [-r] [-f] [-c] search replace

- **`-r` recursive**: optional flag to traverse sub-folders.
- **`-f` folders**: optional flag to include folders as well as files.
- **`-c` copy**: optional flag to copy files instead of renaming.
- **search**: a string or regular expression to match files on.
- **replace**: a string used replace file/folder names. Use `$1 $2...` for matched text.

### Example

filenames

    file1_201208.txt
    file2_201209.txt

rexname command

    rexname '/file(\d+)_(\d{4})(\d{2}).txt/i' '$3-$2-module-$1.js'

result

    2012-08-module-1.js
    2012-09-module-2.js

