function init()
  m.top.setFocus(true)

  m.backgroundImage = m.top.findNode("background")

  m.transitionAnimation = m.top.findNode("imageTransitionAnimation")

  m.imageTimer = m.top.findNode("imageTimer")
  m.imageTimer.observeField("fire", "switchImage")

  m.autoNextTimer = m.top.findNode("autoNextTimer")
  m.autoNextTimer.observeField("fire", "showNextImage")


  m.backgrounds = [
    "pkg:/images/background_1.jpg",
    "pkg:/images/background_2.jpg",
    "pkg:/images/background_3.jpg",
    "pkg:/images/background_4.jpg",
    "pkg:/images/background_5.jpg",
    "pkg:/images/background_6.jpg",
    "pkg:/images/background_7.jpg",
    "pkg:/images/background_8.jpg"
  ]

  m.imageIndex = 0

end function

function onKeyEvent(key as String, press as Boolean) as Boolean
  if press then
    if (key = "left") then
      showPreviousImage()
      return true
    else if (key = "right") then
      showNextImage()
      return true
    end if
  end if

  return false
end function

sub showNextImage()
  startAnimation()
  nextImageIndex()
  m.autoNextTimer.control = "start"
end sub

sub showPreviousImage()
  startAnimation()
  previousImageIndex()
  m.autoNextTimer.control = "start"
end sub

sub startAnimation()
  m.transitionAnimation.control = "start"
  m.imageTimer.control = "start"
end sub

sub switchImage()
  m.backgroundImage.uri = m.backgrounds[m.imageIndex]
end sub

sub nextImageIndex()
  m.imageIndex++
  if m.imageIndex > 7
    m.imageIndex = 0
  end if
end sub

sub previousImageIndex()
  m.imageIndex--
  if m.imageIndex < 0
    m.imageIndex = 7
  end if
end sub
