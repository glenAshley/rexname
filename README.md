rexname
=======

NPM utility module to rename files using regular expressions.

## Installation

Install globally via NPM

    npm install -g rexname

## Usage

<!-- rexname [-r] [-f] [-c] search replace -->
    rexname <search> <replace>

<!-- - **`-r` recursive**: optional flag to traverse sub-folders. -->
<!-- - **`-f` folders**: optional flag to include folders as well as files. -->
<!-- - **`-c` copy**: optional flag to copy files instead of renaming. -->
- **search**:
    a string or regular expression to match files on.
    e.g. `.txt` or `'/(.*)\.\d{4}/i'`
    (Use quotes when for special characters or spaces)
- **replace**:
    a string used to replace file names.
    Use `$1 $2...` for matched text.
    e.g. `'new $1.$2'`

### Example

filenames

    file1_201208.txt
    file2_201209.txt

rexname command

    rexname '/file(\d+)_(\d{4})(\d{2}).txt/i' '$3-$2-module-$1.js'

result

    2012-08-module-1.js
    2012-09-module-2.js

