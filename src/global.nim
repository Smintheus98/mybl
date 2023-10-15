type
  ActionKind* = enum
    Get Set Inc Dec

  Action* = object
    case kind*: ActionKind:
      of Get:
        discard
      of Set, Inc, Dec:
        value*: Natural
    percent*: bool = false

proc actGet*(percent: bool): Action = Action(kind: Get, percent: percent)
proc actSet*(val: Natural; percent: bool): Action = Action(kind: Set, value: val, percent: percent)
proc actInc*(val: Natural; percent: bool): Action = Action(kind: Inc, value: val, percent: percent)
proc actDec*(val: Natural; percent: bool): Action = Action(kind: Dec, value: val, percent: percent)


const help = """

mybl - minimal backlight manager based on system files

Usage:
  mybl [OPTION]
Options:
                  - get current backlight (absolute values and percent)
  --help  -h      - show usage
  [+-]<int>[%]    - change backlight absolute or in percent
"""

proc errorQuit*(msg: string) =
  stderr.writeLine(msg)
  echo help
  quit(QuitFailure)

proc helpQuit*() =
  echo help
  QuitSuccess.quit

import std/strutils
proc startsWith*(s: string; prefix: set[char]): bool {.deprecated.} =
  for c in prefix:
    if s.startsWith(c):
      return true
  return false

