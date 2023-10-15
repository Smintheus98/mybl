import std / [strutils, strformat]
import global

# usage: (pcre2)
#   /mybl (+|-)\d{1,2}%?/gm

proc handle*(args: seq[string]): Action =
  if args.len == 0:
    return actGet(percent=true)
  
  elif args.len == 1:
    let arg = args[0].strip
  
    if arg == "--help" or arg == "-h":
      helpQuit()
    else:
      let percent = arg.endsWith('%')
      let stract = if percent: arg[0..^2] else: arg[0..^1]
      try:
        case arg[0]:
          of Digits:  return actSet(parseInt(stract), percent)
          of '+':     return actInc(parseInt(stract[1..^1]), percent)
          of '-':     return actDec(parseInt(stract[1..^1]), percent)
          else:       errorQuit fmt"No Valid Argument: {arg}"
      except:
        errorQuit fmt"No Valid Argument: {arg}"

  else:  # args.len > 1:
    errorQuit "Too many arguments"

