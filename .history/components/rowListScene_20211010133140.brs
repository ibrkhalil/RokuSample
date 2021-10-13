sub init()
    initGetNodes()
    m.btnGroup.setFocus(true)
    initObservers()
end sub

sub initGetNodes()
    m.btnGroup = m.top.findNode("btnGroup")
    m.start = m.btnGroup.findNode("start")
    m.stopTimer = m.btnGroup.findNode("stopTimer")
    m.reset = m.btnGroup.findNode("reset")
    ' m.timer = m.top.findNode("timer")
    m.timeLabel = m.top.findNode("timeLabel")
end sub

sub initObservers()
    m.start.observeField("buttonSelected", "start")
    m.stopTimer.observeField("buttonSelected", "stopTimer")
    m.reset.observeField("buttonSelected", "reset")
    m.timer = createObject("roTimespan")
    ' m.timer.observeField("fire", "changeText")
end sub

sub start()
    m.timeLabel.text = "00:00"
    m.timer.Mark()
end sub

sub stopTimer()
    time = m.timer.TotalSeconds()
    if time MOD 60 = 0
        seconds = "00"
        minutes = Str(time / 60)
    else
        minutes = Str(INT(time / 60))
        seconds = Str(INT(time MOD 60))
    end if
    minutes = T(minutes)
    seconds = T(seconds)
    if Len(minutes) = 1
        minutes = "0" + minutes
    end if
    if Len(seconds) = 1
        seconds = "0" + seconds
    end if
    m.timeLabel.text = minutes + ":" + seconds
end sub

sub reset()
    m.timer = createObject("roTimeSpan")
end sub