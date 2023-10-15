import std / [os, strformat, math]
import global, arghandler, sysbacklight


proc getBacklight(percent: bool): string =
  if percent:
    let absVal = getBlDevBrightness()
    let maxVal = getBlDevMaxBrightness()
    let percVal = (absVal * 100 / maxVal).round.int
    return fmt"{absVal}/{maxVal}: {percVal}%"
  else:
    return $getBlDevBrightness()

proc setBacklight(value: Natural; percent: bool) =
  if percent:
    setBlDevBrightness((value * getBlDevMaxBrightness() / 100).round.int.clipBrightness)
  else:
    setBlDevBrightness(value.clipBrightness)

proc incBacklight(value: Natural; percent: bool) =
  let currentBacklight = getBlDevBrightness()
  if percent:
    let absAdjust = (value * getBlDevMaxBrightness() / 100).round.Natural
    setBlDevBrightness(clipBrightness(currentBacklight + absAdjust))
  else:
    setBlDevBrightness(clipBrightness(currentBacklight + value))

proc decBacklight(value: Natural; percent: bool) =
  let currentBacklight = getBlDevBrightness()
  if percent:
    let absAdjust = (value * getBlDevMaxBrightness() / 100).round.Natural
    setBlDevBrightness(clipBrightness(currentBacklight - absAdjust))
  else:
    setBlDevBrightness(clipBrightness(currentBacklight - value))




proc main() =
  var action = commandLineParams().handle

  case action.kind:
    of Get: echo getBacklight(action.percent)
    of Set: setBacklight(action.value, action.percent)
    of Inc: incBacklight(action.value, action.percent)
    of Dec: decBacklight(action.value, action.percent)


when isMainModule:
  main()
