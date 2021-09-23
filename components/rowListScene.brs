sub init()
    m.global.addField("http", "node", FALSE)
    m.global.addField("ratio", "float", FALSE)
    m.global.addField("mainScreen", "node", FALSE)
    m.global.mainScreen = m.top
    m.global.http = createObject("roSGNode", "httpTask")
    m.global.http.control = "RUN"
    m.global.ratio = 1
    m.rowList = m.top.findNode("mainRowList")
    m.MainBoldLabel = m.top.findNode("MainBoldLabel")
    m.DateAndDurationLabel = m.top.findNode("DateAndDurationLabel")
    m.DescriptionLabel = m.top.findNode("DescriptionLabel")
    m.CategoryLabel = m.top.findNode("CategoryLabel")
    m.textAnimation = m.top.findNode("heroDetailsAnimation")
    ' m.overlayAnimation = m.top.findNode("mainOverlayAnimation")
    m.rowList.content = createObject("roSGNode", "RowListContent")
    m.rowList.setFocus(true)
    m.top.observeField("HeroDetails","handleHeroDetails")
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

sub handleHeroDetails()
    m.MainBoldLabel.text = m.top.HeroDetails.MainBoldLabel
    m.DateAndDurationLabel.text = m.top.HeroDetails.DateAndDurationLabel
    m.DescriptionLabel.text = m.top.HeroDetails.DescriptionLabel
    m.CategoryLabel.text = m.top.HeroDetails.CategoryLabel
    m.textAnimation.control = "start"
end sub