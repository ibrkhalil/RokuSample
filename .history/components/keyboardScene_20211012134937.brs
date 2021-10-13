sub init()
    m.keyboard = m.top.findNode("myKeyboard")
    m.itemsList = m.top.findNode("searchList")
    m.video = m.top.findNode("video")
    m.itemsList.observeField("itemSelected", "handleItemSelected")
    m.heading = m.top.findNode("heading")
    m.keyboard.setFocus(true)
    m.keyboard.observeField("text", "handleText")
    m.http = createObject("roSGNode", "httpTask")
    m.http.observeFieldScoped("response", "useResponse")
    m.keyboard.textBox.observeField("text", "handleText")
    m.keyboard.observeField("submit", "handleSubmit")
end sub

sub handleText()
    m.text = m.keyboard.textBox.text
end sub

sub handleSubmit()
    m.http.request = { payload: {
            userId: 1,
            title: "WOW, IT WORKED ^_^",
    }, url: "https://youtube.googleapis.com/youtube/v3/search?part=snippet&q=" + m.text + "&maxResults=25&type=video&key=AIzaSyCxEpZ8-3gkiFpoc2SAkPBfcPFqQd6m_dw", requestType: "GET" }
    m.http.control = "RUN"
end sub

sub useResponse()
    m.itemsThatContainString = createObject("roSGNode", "ContentNode")
    items = []
    m.itemsList.numColumns = 3
    for each item in parseJson(m.http.response.body).items
        Content = m.itemsThatContainString.createChild("ContentNode")
        Content.HDPosterUrl = item.snippet.thumbnails.medium.url
        Content.id = item.id.videoId
        items.push(item)
    end for
    if items.count() = 2
        m.itemsList.numColumns = 2
    else if items.count() = 1
        m.itemsList.numColumns = 1
    end if
    ' handle empty text box
    if m.keyboard.textBox.text = ""
        m.itemsList.content = invalid
        m.heading.visible = false
    else
        m.heading.visible = true
        m.itemsList.content = m.itemsThatContainString
        handleHeading()
    end if
end sub

sub handleHeading()
    m.heading.text = "These are the top videos that match " + Chr(34) + m.keyboard.textBox.text + Chr(34)
end sub

sub handleItemSelected()
    playVideo(m.itemsThatContainString.getChild(m.itemsList.itemSelected).id)
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

sub playVideo(id as String)
    m.videoPlaybackTask = createObject("roSGNode", "httpTask")
    m.videoPlaybackTask.request = { payload: {
            userId: 1,
            title: "WOW, IT WORKED ^_^",
    }, url: "https://www.youtube.com/watch?v=" + id, requestType: "GET" }
    m.videoPlaybackTask.control = "RUN"
    m.videoPlaybackTask.observeFieldScoped("response", "handleVideoPlaybackResponse")
end sub

sub handleVideoPlaybackResponse()
    initialPlayerResponseRegEx = createObject("roRegex", "ytInitialPlayerResponse\s*=\s*({.+?})\s*;", "m")
    matches = initialPlayerResponseRegEx.match(m.videoPlaybackTask.response.body)
    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = parseJson(matches[1]).streamingData.formats[0].url
    videoContent.streamformat = "mp4"
    m.video.content = videoContent
    m.video.visible = true
    m.video.seekMode = "accurate"
    m.video.trickPlayBar.textColor = "0x0000FFFF"
    m.video.trickPlayBar.thumbBlendColor = "0x0000FF00"
    m.video.trickPlayBar.filledBarBlendColor = "0x000000FF"
    m.video.setFocus(true)
    m.video.control = "play"
end sub

