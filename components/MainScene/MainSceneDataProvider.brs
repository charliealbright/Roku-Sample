function init()
    m.top.setFocus(true)

    m.backgroundImage = m.top.findNode("background")
    m.backgroundImage.observeField("loadStatus", "onLoadStatusChanged")

    m.fadeAnimation = m.top.findNode("imageFadeAnimation")
    m.showAnimation = m.top.findNode("imageShowAnimation")

    m.imageTimer = m.top.findNode("imageTimer")
    m.imageTimer.observeField("fire", "switchImage")

    m.autoNextTimer = m.top.findNode("autoNextTimer")
    m.autoNextTimer.observeField("fire", "showNextImage")

    m.webRequestTask = m.top.findNode("webRequestTask")
    m.webRequestTask.observeField("data", "onDataReceived")
    m.webRequestTask.control = "RUN"

    m.imageIndex = 0
    m.urls = []
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
  m.fadeAnimation.control = "start"
  m.imageTimer.control = "start"
end sub

sub switchImage()
    ?"[url] " + m.urls[m.imageIndex]
    ?"[index] " + m.imageIndex.toStr()
    m.backgroundImage.uri = m.urls[m.imageIndex]
end sub

sub nextImageIndex()
  m.imageIndex++
  if m.imageIndex > 24
    m.imageIndex = 0
  end if
end sub

sub previousImageIndex()
  m.imageIndex--
  if m.imageIndex < 0
    m.imageIndex = 24
  end if
end sub

sub onLoadStatusChanged()
    if (m.backgroundImage.loadStatus = "ready")
        m.showAnimation.control = "start"
    else if (m.backgroundImage.loadStatus = "failed")
        ?"[image load failed, showing next image]"
        showNextImage()
    end if
end sub

sub onDataReceived()
    response = m.webRequestTask.data
    if (response <> invalid)
        ?"[response is valid]"
        for each post in response.data.children
            if (post.data.preview <> invalid)
                m.urls.push(post.data.preview.images[0].source.url)
            else
                m.urls.push(post.data.url)
            end if
        end for
        m.backgroundImage.uri = m.urls[m.imageIndex]
    else
        ?"[response is invalid]"
    end if
end sub
