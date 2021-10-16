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
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        if key = "right" and not m.itemsList.hasFocus()
            m.itemsList.setFocus(true)
            return true
        else if key = "left" and not m.keyboard.hasFocus()
            m.keyboard.setFocus(true)
        end if
    end if
    return false
end function