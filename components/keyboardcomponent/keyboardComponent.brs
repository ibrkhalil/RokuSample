sub init()
    m.keyboardController = m.top.findNode("keyboardController")
    m.keys = ["A", "J", "S", "1", "B", "K", "T", "2", "C", "L", "U", "3", "D", "M", "V", "4", "E", "N", "W", "5", "F", "O", "X", "6", "G", "P", "Y", "7", "H", "Q", "Z", "8", "I", "R", "0", "9"]
    m.symbolsKeys = ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "-", "/", "\", "|", "[", "]", "{", "}", ":", ";", "", "'", ",", ".", "<", ">", "?", "=", "`", "~", "X", "O", "..."]
    m.symbolsFlag = false
    initButtons()
    m.focusIdx = 0
    m.Col1.getChild(0).setFocus(true)
    initObservers()
end sub

sub initButtons()
    m.Col1 = m.keyboardController.findNode("Col1")
    m.Col2 = m.keyboardController.findNode("Col2")
    m.Col3 = m.keyboardController.findNode("Col3")
    m.Col4 = m.keyboardController.findNode("Col4")
    m.Col5 = m.keyboardController.findNode("Col5")
    m.Col6 = m.keyboardController.findNode("Col6")
    m.Col7 = m.keyboardController.findNode("Col7")
    m.Col8 = m.keyboardController.findNode("Col8")
    m.Col9 = m.keyboardController.findNode("Col9")
    m.SYMBOLS = m.keyboardController.findNode("SYMBOLS")
    m.SPACEBAR = m.keyboardController.findNode("SPACEBAR")
    m.DELETE = m.keyboardController.findNode("DELETE")
    m.SEARCH = m.keyboardController.findNode("SEARCH")
    m.textBox = m.top.findNode("textBox")
    it = -1
    for each child in m.keyboardController.getChildren(9, 0)
        it++
        it2 = it + 3
        for i = it to it2
            childButton = createObject("roSGNode", "Button")
            childButton.getChild(1).uri = ""
            childButton.getChild(2).text = m.keys[i]
            childButton.getChild(2).width = 72
            childButton.getChild(2).height = 72
            childButton.getChild(2).font = "font:SmallestBoldSystemFont"
            childButton.getChild(2).horizAlign = "center"
            childButton.iconUri = ""
            childButton.focusedIconUri = ""
            childButton.focusedTextFont = "font:SmallestBoldSystemFont"
            childButton.textFont = "font:SmallestBoldSystemFont"
            child.appendChild(childButton)
        end for
        it = it2
    end for
end sub

sub handleSymbols()
    it = -1
    if m.symbolsFlag
        for each child in m.keyboardController.getChildren(9, 0)
            it++
            it2 = it + 3
            btnIdx = 0
            for i = it to it2
                child.getChild(btnIdx).getChild(2).text = m.keys[i]
                btnIdx++
            end for
            it = it2
        end for
        m.symbolsFlag = false
    else
        for each child in m.keyboardController.getChildren(9, 0)
            it++
            it2 = it + 3
            btnIdx = 0
            for i = it to it2
                child.getChild(btnIdx).getChild(2).text = m.symbolsKeys[i]
                btnIdx++
            end for
            it = it2
        end for
        m.symbolsFlag = true
    end if
end sub

sub initObservers()
    m.Col1.observeField("buttonSelected", "handleItemSelect")
    m.Col2.observeField("buttonSelected", "handleItemSelect")
    m.Col3.observeField("buttonSelected", "handleItemSelect")
    m.Col4.observeField("buttonSelected", "handleItemSelect")
    m.Col5.observeField("buttonSelected", "handleItemSelect")
    m.Col6.observeField("buttonSelected", "handleItemSelect")
    m.Col7.observeField("buttonSelected", "handleItemSelect")
    m.Col8.observeField("buttonSelected", "handleItemSelect")
    m.Col9.observeField("buttonSelected", "handleItemSelect")
    m.DELETE.observeField("buttonSelected", "handleExternalButtonSelect")
    m.SPACEBAR.observeField("buttonSelected", "handleExternalButtonSelect")
    m.SYMBOLS.observeField("buttonSelected", "handleExternalButtonSelect")
    m.SEARCH.observeField("buttonSelected", "handleExternalButtonSelect")
    m.top.textBox = m.textBox
end sub

sub handleExternalButtonSelect(event)
    if event.getRoSGNode().text = "SPACE"
        m.textBox.text += " "
    else if event.getRoSGNode().id = "DELETE"
        m.textBox.text = m.textBox.text.Left(m.textBox.text.Len() - 1)
    else if event.getRoSGNode().id = "DELETE"
        m.top.submit = not m.top.submit
    else if event.getRoSGNode().id = "SEARCH"
        m.top.submit = not m.top.submit
    else
        handleSymbols()
    end if
end sub

sub handleItemSelect(event)
    text = event.getRoSGNode().focusedChild.getChild(2).text
    m.textBox.text += text
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    m.rowIdx = m.keyboardController.getChild(m.focusIdx).buttonFocused
    if press
        if key = "right" and m.focusIdx < 8 and not m.DELETE.hasFocus() and not m.SYMBOLS.hasFocus() and not m.SPACEBAR.hasFocus()
            m.focusIdx++
            m.keyboardController.getChild(m.focusIdx).focusButton = m.rowIdx
            return true
        else if key = "left" and m.focusIdx > 0 and not m.DELETE.hasFocus() and not m.SYMBOLS.hasFocus() and not m.SPACEBAR.hasFocus()
            m.focusIdx--
            m.keyboardController.getChild(m.focusIdx).focusButton = m.rowIdx
            return true
        else if key = "down" and m.focusIdx >= 2 and m.focusIdx <= 5
            m.SPACEBAR.setFocus(true)
            return true
        else if key = "down" and m.focusIdx < 2
            m.SYMBOLS.setFocus(true)
            return true
        else if key = "down" and m.focusIdx = 8
            m.SEARCH.setFocus(true)
        else if key = "down" and m.focusIdx > 5
            m.DELETE.setFocus(true)
            return true
        else if key = "up" and m.focusIdx > 5
            ' Go to the item right above DELETE
            m.keyboardController.getChild(8).focusButton = 3
            m.focusIdx = 8
            return true
        else if key = "up" and m.focusIdx >= 2 and m.focusIdx <= 5
            ' Go to the item right above SPACE
            m.keyboardController.getChild(4).focusButton = 3
            m.focusIdx = 4
            return true
        else if key = "up" and m.focusIdx < 2
            ' Go to the item right above SYMBOLS
            m.keyboardController.getChild(0).focusButton = 3
            m.focusIdx = 0
            return true
        else if key = "right" and m.SPACEBAR.hasFocus()
            m.focusIdx = 8
            m.DELETE.setFocus(true)
            return true
        else if key = "right" and m.SYMBOLS.hasFocus()
            m.focusIdx = 4
            m.SPACEBAR.setFocus(true)
            return true
        else if key = "left" and m.DELETE.hasFocus()
            m.focusIdx = 4
            m.SPACEBAR.setFocus(true)
            return true
        else if key = "left" and m.SPACEBAR.hasFocus()
            m.focusIdx = 0
            m.SYMBOLS.setFocus(true)
            return true
        else if key = "left" and m.SEARCH.hasFocus()
            m.focusIdx = 0
            m.DELETE.setFocus(true)
            return true
        else if key = "right" and m.DELETE.hasFocus()
            m.focusIdx = 0
            m.SEARCH.setFocus(true)
            return true
        end if
    end if
    return false
end function