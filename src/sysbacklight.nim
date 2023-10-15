import std / [os, sequtils, strutils]

type Path = string

const base: Path = "/sys/class/backlight"

proc findBlDevDir(): Path =
  let dirs = base.walkDir().toSeq()
  if dirs.len == 0:
    raise newException(IOError,"No Backlight Device found")
  return dirs[0].path


proc getBlDevMaxBrightness*(): Natural =
  let file = findBlDevDir() / "max_brightness"
  file.readFile.strip.parseInt()

proc getBlDevBrightness*(): Natural =
  let file = findBlDevDir() / "brightness"
  file.readFile.strip.parseInt()

proc setBlDevBrightness*(value: Natural) =
  let file = findBlDevDir() / "brightness"
  file.writeFile($value & "\n")

proc clipBrightness*(value: int): Natural =
  let interval = (low: 0, high: getBlDevMaxBrightness())
  if value <= interval.low:
    return interval.low
  elif value >= interval.high:
    return interval.high
  else:
    value
