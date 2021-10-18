sub init()
    m.itemPoster = m.top.findNode("imagePoster")
end sub

sub showContent()
    m.itemPoster.uri = m.top.itemContent.HDPOSTERURL
end sub