sub init()
    m.global.addField("http", "node", FALSE)
    m.global.addField("ratio", "float", FALSE)
    m.global.http = createObject("roSGNode", "httpTask")
    m.global.http.control = "RUN"
    m.global.ratio = 1
    m.rows = m.top.getChild(1).getChildren(6, 0)
    m.parent = m.top.findNode("rowListParty")
    m.scrollAnimation = m.top.findNode("scroll")
    for each row in m.rows
        row.content = createObject("roSGNode", "RowListContent")
    end for
    m.rowFocused = 0
    m.rows[0].setFocus(true)
    videoMode = createObject("roDeviceInfo")
    if videoMode.GetVideoMode() = "720p"
        m.global.ratio = 0.66
    end if
    if m.global.ratio = 0.66
        m.rowList.rowHeights = [Cdbl(m.rowList.rowHeights[0] * m.global.ratio) + 10]
        m.rowList.rowItemSpacing = [[5, 0]]
        m.rowList.focusXOffset = [Cdbl(m.rowList.focusXOffset[0] * m.global.ratio) - 50]
        m.rowList.rowItemSize = [[INT(m.rowList.rowItemSize[0][0] * m.global.ratio) + 20, INT(m.rowList.rowItemSize[0][1] * m.global.ratio)]]
        m.rowList.translation = [INT(m.rowList.translation[0] * m.global.ratio), INT(m.rowList.translation[1] / m.global.ratio) - 100]
        m.rowList.rowLabelOffset = [[INT(m.rowList.rowLabelOffset[0][0] * m.global.ratio), INT(m.rowList.rowLabelOffset[0][1] * m.global.ratio) - 6]]
        m.rowList.itemSize = [1400, INT(m.rowList.itemSize[1] * m.global.ratio)]
    end if
end sub

sub animateScroll(direction as String)
    if direction = "down" and m.rowFocused < 4 and m.scrollAnimation.state = "stopped"
        m.rowFocused++
        m.scrollAnimation.getChild(0).keyValue = [[0, m.parent.translation[1]], [0, m.parent.translation[1] - 300]]
        m.parent.getChild(m.rowFocused).setFocus(true)
        m.scrollAnimation.control = "start"
    else if direction = "up" and m.rowFocused = 1 and m.scrollAnimation.state = "stopped"
        m.parent.getChild(m.rowFocused - 1).setFocus(true)
    else if direction = "up" and m.rowFocused > 1 and m.scrollAnimation.state = "stopped"
        m.rowFocused--
        m.scrollAnimation.getChild(0).keyValue = [[0, m.parent.translation[1]], [0, m.parent.translation[1] + 300]]
        m.parent.getChild(m.rowFocused).setFocus(true)
        m.scrollAnimation.control = "start"
    else if direction = "down" and m.rowFocused = 4 and m.scrollAnimation.state = "stopped"
        m.parent.getChild(m.rowFocused + 1).setFocus(true)
        m.rowFocused = 5
    else if direction = "up" and m.rowFocused = 5 and m.scrollAnimation.state = "stopped"
        m.parent.getChild(m.rowFocused - 1).setFocus(true)
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if press
        if key = "down"
            animateScroll(key)
            return true
        else if key = "up"
            animateScroll(key)
            return true
        end if
    end if
end function