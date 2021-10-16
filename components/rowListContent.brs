sub init()
    m.global.http.request = { payload: {
            userId: 1,
            title: "WOW, IT WORKED ^_^",
    }, url: "https://alghool.net/RokuDev/data.json", requestType: "GET" }
    m.global.http.observeFieldScoped("response", "useResponse")
end sub

sub useResponse()
    itemNode = m.top.createChild("ContentNode")
    itemNode.title = m.global.http.response.body[0].TITLE
    for each itemData in m.global.http.response.body[0].data
        itemDetails = itemNode.createChild("ContentNode")
        itemDetails.title = itemData.title
        itemDetails.HDPosterUrl = itemData.thumbnail
        itemDetails.description = itemData.longDescription
    end for
end sub