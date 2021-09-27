sub init()
    m.itemTitle = m.top.findNode("itemTitle")
    m.watchButton = m.top.findNode("watchButton")
    m.itemDescription = m.top.findNode("itemDescription")
    m.itemTags = m.top.findNode("itemTags")
    m.itemTime = m.top.findNode("itemTime")
    m.ButtonGroup = m.top.findNode("ButtonGroup")
    m.top.ObserveField("content", "handleItemDetails")
end sub

sub handleItemDetails()
    m.ButtonGroup.focusedTextFont = "font:LargeBoldSystemFont"
    m.ButtonGroup.textFont = "font:LargeBoldSystemFont"
    m.ButtonGroup.vertAlignment = "center"
    m.ButtonGroup.horizAlignment = "center"
    m.itemTitle.text = m.top.content.TITLE
    m.itemDescription.text = m.top.content.DESCRIPTION
    m.itemTime.text = "Duration : " + GetTime(m.top.content.time) + " Hour(s)"
    if m.top.content.tags <> invalid
        tagsCount = m.top.content.tags.Count()
        for i = 0 to tagsCount - 1
            if i = tagsCount - 1
                m.itemTags.text += m.top.content.tags[i]
            else
                m.itemTags.text += m.top.content.tags[i] + " - "
            end if
        end for
    else
        m.itemTags.text = "No tags available"
    end if
end sub

function GetTime(length as Integer) as String
    minutes = (length \ 60).ToStr()
    seconds = length MOD 60
    if seconds < 10
        seconds = "0" + seconds.ToStr()
    else
        seconds = seconds.ToStr()
    end if
    return minutes + ":" + seconds
end function