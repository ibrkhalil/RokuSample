sub init()
    m.keyboardController = m.top.findNode("keyboardController")
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
    m.textBox = m.top.findNode("textBox")
    m.Col1.buttons = [" A ", "J", "S", "1"]
    m.Col2.buttons = ["B", "K", "T", "2"]
    m.Col3.buttons = ["C", "L", "U", "3"]
    m.Col4.buttons = ["D", "M", "V", "4"]
    m.Col5.buttons = ["E", "N", "W", "5"]
    m.Col6.buttons = ["F", "O", "X", "6"]
    m.Col7.buttons = ["G", "P", "Y", "7"]
    m.Col8.buttons = ["H", "Q", "Z", "8"]
    m.Col9.buttons = ["I", "R", "0", "9"]
    for i = 0 to 3
        for each child in m.keyboardController.getChildren(9, 0)
            child.getChild(i).removeChild(1)
            child.getChild(i).getChild(2).width = 68
            child.getChild(i).getChild(2).height = 68
            child.getChild(i).getChild(2).horizAlign = "center"
            ?child.getChild(i).getChild(2)
        end for
    end for
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
    m.top.textBox = m.textBox
end sub

sub handleExternalButtonSelect(event)
    if event.getRoSGNode().text = "SPACE"
        m.textBox.text += " "
    else
        m.textBox.text = m.textBox.text.Left(m.textBox.text.Len() - 1)
    end if
end sub

sub handleItemSelect(event)
    text = event.getRoSGNode().getChild(event.getData()).text
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
        end if
    end if
    return false
end function