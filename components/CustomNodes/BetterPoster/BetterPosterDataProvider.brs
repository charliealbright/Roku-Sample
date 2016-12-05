function init()
  m.top.setFocus(true)

  m.top.observeField("bitmapWidth", "updateTranslation")
  m.top.observeField("bitmapHeight", "updateTranslation")
end function

sub onMoveToChanged()
  updateTranslation()
end sub

sub onAnchorChanged()
  updateTranslation()
end sub

sub updateTranslation()

  width = m.top.width
  height = m.top.height

  if width = 0 then width = m.top.bitmapWidth
  if height = 0 then height = m.top.bitmapHeight

  xTranslation = m.top.moveTo[0]
  yTranslation = m.top.moveTo[1]

  x = 0
  y = 0

  anchor = m.top.anchor

  if anchor = "center" then
    x = xTranslation - (width / 2)
    y = yTranslation - (height / 2)
  else if anchor = "center_top" then
    x = xTranslation - (width / 2)
    y = yTranslation
  else if anchor = "center_bottom" then
    x = xTranslation - (width / 2)
    y = yTranslation - height
  else if anchor = "center_left" then
    x = xTranslation
    y = yTranslation - (height / 2)
  else if anchor = "center_right" then
    x = xTranslation - width
    y = yTranslation - (height / 2)
  else if anchor = "top_left" then
    x = xTranslation
    y = yTranslation
  else if anchor = "top_right" then
    x = xTranslation - width
    y = yTranslation
  else if anchor = "bottom_left" then
    x = xTranslation
    y = yTranslation - height
  else if anchor = "bottom_right" then
    x = xTranslation - width
    y = yTranslation - height
  else
    x = xTranslation
    y = yTranslation
  end if

  m.top.translation = [x,y]
end sub
