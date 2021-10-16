sub init()
    initItems()
end sub

sub initItems()
    m.mainParent = m.top.findNode("mainParent")
    m.elapsedTime = m.mainParent.findNode("elapsedTime")
    m.ScrubberFilled = m.mainParent.findNode("ScrubberFilled")
    m.ScrubberContainer = m.mainParent.findNode("ScrubberContainer")
    m.remainingTime = m.mainParent.findNode("remainingTime")
    m.bottomButtons = m.top.findNode("bottomButtons")
    m.back15 = m.bottomButtons.findNode("back15")
    m.playPause = m.bottomButtons.findNode("playPause")
    m.forward15 = m.bottomButtons.findNode("forward15")
    m.CC = m.bottomButtons.findNode("CC")
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ?m.top.opacity
    if press and m.top.opacity = true
        if key = "right" and m.back15.hasFocus()
            m.playPause.setFocus(true)
            return true
        else if key = "right" and m.playPause.hasFocus()
            m.forward15.setFocus(true)
            return true
        else if key = "right" and m.forward15.hasFocus()
            m.CC.setFocus(true)
            return true
        else if key = "right" and m.CC.hasFocus()
            return false
        else if key = "left" and m.CC.hasFocus()
            m.forward15.setFocus(true)
            return true
        else if key = "left" and m.forward15.hasFocus()
            m.playPause.setFocus(true)
            return true
        else if key = "left" and m.playPause.hasFocus()
            m.back15.setFocus(true)
            return true
        else if key = "left" and m.back15.hasFocus()
            return false
        else if key = "up" and m.top.opacity = false
            m.top.opacity = true
            m.back15.setFocus(true)
            return true
        else if key = "down" and m.top.opacity = true
            m.top.opacity = false
            return true
        end if
    end if
    return false
end function