# mybl
Simple monitor brightness tool based on system files and independent from X11/Wayland

### Install
To install this program you need a [Nim](https://github.com/nim-lang/Nim/) compiler and the nimble package manager (which comes with Nim).
The recommended method to install it is to use [choosenim](https://github.com/dom96/choosenim).
```
$ git clone ...
$ cd mybl
$ nimble install
```
#### Note
To change the required files the program needs appropriate file permissions.
This could be done by a udev-rule for example.

Another way is to change the ownership of the binary to root and set the s-bit.
The script `rootify.sh` does exactly this.
```
$ ./rootify.sh
```

### Usage:

```
$ mybl -h

mybl - minimal backlight manager based on system files

Usage:
  mybl [OPTION]
Options:
                  - get current backlight (absolute values and percent)
  --help  -h      - show usage
  [+-]<int>[%]    - change backlight absolute or in percent

```

### Examples:
```
$ mybl
14934/21333: 70%
```
```
$ mybl +10%   # increase backlight by 10%
$ mybl -1000  # decrease backlight by an absolute value of 1000
$ mybl 50%    # set backlight to 50%
```

### TODO:
[ ] choose device number on cli
