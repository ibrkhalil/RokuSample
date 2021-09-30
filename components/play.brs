sub init()
    m.video = m.top.findNode("video")
    m.content = createObject("roSGNode", "ContentNode")
    m.content.url = "https://r3---sn-hgn7rnee.googlevideo.com/videoplayback?expire=1633011943&ei=h3RVYZy3NMnkxgL_qrCgBQ&ip=103.123.250.116&id=o-APON_3doBmhNhHt9HALI4Y81IuEsplX4PRgbENp2YO16&itag=22&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&ns=34x2BrLCRvFHsKvxEJbdFdUG&cnr=14&ratebypass=yes&dur=156.734&lmt=1606723531770015&fexp=24001373,24007246&c=WEB&txp=5535432&n=yz8oJUF-_jcidN5&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIga-i4MRfEO7631sUpQhEVee1UU67uiulVpeTqYvJ-qzICIQCR6DdG0jOQR1kNCk8zes0KmDjjAhgw2D5t8bcrGAr7kg%3D%3D&title=Night%20Lovell%20-%20Still%20Cold%20%2F%20AMG%20DEMON&rm=sn-jx25uoxu-jb3s7l,sn-npozs7s&req_id=aeafe855b6bea3ee&redirect_counter=2&cms_redirect=yes&ipbypass=yes&mh=kG&mip=156.215.91.1&mm=29&mn=sn-hgn7rnee&ms=rdu&mt=1632989563&mv=m&mvi=3&pl=22&lsparams=ipbypass,mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRQIgZ8O2Yl019mdq9nxYPMzw1RnKnzYLygoQL0J5miaWN2oCIQDNUyMS0uA1HTCQNGlhjuolun0Sl6A5v03pbDVRsX5f4g%3D%3D"
    m.content.title = "Black Car"
    m.content.streamformat = "mp4"
    m.video.content = m.content
    play()
end sub

sub play()
    m.video.control = "play"
end sub