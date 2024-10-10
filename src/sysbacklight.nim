import std / [os, sequtils, strutils]

type Path = string

const base: Path = "/sys/class/backlight"

proc findBlDevDirs(): seq[Path] =
  let dirs = base.walkDir().toSeq().mapIt(it.path)
  if dirs.len == 0:
    raise newException(IOError,"No Backlight Device found")
  return dirs

proc findBlDevDir(num: Natural = 0): Path =
  let dirs = findBlDevDirs()
  if dirs.len < num:
    raise newException(IOError,"Device-number not found")
  return dirs[num]

const defaultBlDev = findBlDevDir(0)

proc getBlDevMaxBrightness*(blDev: Path = defaultBlDev): Natural =
  let file = blDev / "max_brightness"
  file.readFile.strip.parseInt()

proc getBlDevBrightness*(blDev: Path = defaultBlDev): Natural =
  let file = blDev / "brightness"
  file.readFile.strip.parseInt()

proc setBlDevBrightness*(value: Natural, blDev: Path = defaultBlDev) =
  let file = blDev / "brightness"
  file.writeFile($value & "\n")

proc clipBrightness*(value: int): Natural =
  let interval = (low: 0, high: getBlDevMaxBrightness())
  if value <= interval.low:
    return interval.low
  elif value >= interval.high:
    return interval.high
  else:
    value
