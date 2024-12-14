local composer = require("composer")
local scene = composer.newScene()

local MARGIN = display.contentWidth * 0.065

local audioHandle
local audioButton, stopButton

local function playAudio()
    if not audioHandle then
        audioHandle = audio.loadStream("assets/pagina1.mp3")
        audio.play(audioHandle, { loops = -1 })
    end
    audioButton.isVisible = false
    stopButton.isVisible = true
end

local function stopAudio()
    if audioHandle then
        audio.stop()
        audio.dispose(audioHandle)
        audioHandle = nil
    end
    audioButton.isVisible = true
    stopButton.isVisible = false
end

function scene:create(event)
    local sceneGroup = self.view

    display.setDefault("background", 210/255, 180/255, 140/255)

    local pageNumber = display.newText({
        text = "1",
        x = display.contentWidth - MARGIN,
        y = MARGIN,
        font = native.systemFont,
        fontSize = 24,
        align = "right"
    })
    pageNumber:setFillColor(0)
    sceneGroup:insert(pageNumber)

    local title = display.newText({
        text = "Introdução à Evolução",
        x = display.contentCenterX,
        y = MARGIN * 3.5,
        font = native.systemFontBold,
        fontSize = display.contentWidth * 0.07,
        align = "center"
    })
    title:setFillColor(0)
    sceneGroup:insert(title)

    local subtitle = display.newText({
        text = "Conceito da Evolução Biológica",
        x = display.contentCenterX,
        y = title.y + 90,
        width = display.contentWidth - 2 * MARGIN,
        font = native.systemFontBold,
        fontSize = 35,
        
    })
    subtitle:setFillColor(0)
    sceneGroup:insert(subtitle)

    local description = display.newText({
        text = "A evolução biológica é o processo de mudança nas características hereditárias de uma população ao longo de várias gerações. Essas mudanças ocorrem através de variações genéticas, que podem ser benéficas, neutras ou prejudiciais para os organismos em questão. O conceito central da evolução é que todos os seres vivos compartilham um ancestral comum, e, ao longo do tempo, as espécies se modificam em resposta ao ambiente, resultando na diversidade de formas de vida que vemos hoje.\n\nClique no ambiente que você deseja e veja como o ancestral modificou em resposta ao ambiente.",
        x = display.contentCenterX,
        y = subtitle.y + 200,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 22,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

    local oceanIcon = display.newImage(sceneGroup, "assets/onda.png")
    oceanIcon.x = display.contentCenterX - 150
    oceanIcon.y = display.contentHeight - 200
    oceanIcon.width, oceanIcon.height = 100, 100

    local forestIcon = display.newImage(sceneGroup, "assets/floresta.png")
    forestIcon.x = display.contentCenterX + 150
    forestIcon.y = display.contentHeight - 200
    forestIcon.width, forestIcon.height = 100, 100

    local ancestorText = display.newText({
        text = "Ancestral Comum dos Mamíferos",
        x = display.contentCenterX,
        y = display.contentHeight - 300,
        font = native.systemFont,
        fontSize = 22,
        align = "center"
    })
    ancestorText:setFillColor(0)
    sceneGroup:insert(ancestorText)

    local whaleIcon = display.newImage(sceneGroup, "assets/baleia.png")
    whaleIcon.x = display.contentCenterX - 150
    whaleIcon.y = display.contentHeight - 100
    whaleIcon.width, whaleIcon.height = 80, 80
    whaleIcon.isVisible = false

    local monkeyIcon = display.newImage(sceneGroup, "assets/macaco.png")
    monkeyIcon.x = display.contentCenterX + 150
    monkeyIcon.y = display.contentHeight - 100
    monkeyIcon.width, monkeyIcon.height = 80, 80
    monkeyIcon.isVisible = false

    local line1 = display.newLine(sceneGroup, ancestorText.x, ancestorText.y + 20, oceanIcon.x, oceanIcon.y - 50)
    line1:setStrokeColor(0)
    line1.strokeWidth = 2

    local line2 = display.newLine(sceneGroup, ancestorText.x, ancestorText.y + 20, forestIcon.x, forestIcon.y - 50)
    line2:setStrokeColor(0)
    line2.strokeWidth = 2

    local line3 = display.newLine(sceneGroup, oceanIcon.x, oceanIcon.y + 50, whaleIcon.x, whaleIcon.y - 40)
    line3:setStrokeColor(0)
    line3.strokeWidth = 2

    local line4 = display.newLine(sceneGroup, forestIcon.x, forestIcon.y + 50, monkeyIcon.x, monkeyIcon.y - 40)
    line4:setStrokeColor(0)
    line4.strokeWidth = 2

    oceanIcon:addEventListener("tap", function(event)
        whaleIcon.isVisible = true 
        monkeyIcon.isVisible = false 
    end)

    forestIcon:addEventListener("tap", function(event)
        whaleIcon.isVisible = false 
        monkeyIcon.isVisible = true 
    end)

    local btnNext = display.newImage(sceneGroup, "assets/proximo.png")
    btnNext.width, btnNext.height = display.contentWidth * 0.1, display.contentWidth * 0.1
    btnNext.x = display.contentWidth - MARGIN
    btnNext.y = display.contentHeight - MARGIN
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page2", { effect = "fade", time = 500 })
    end)

    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width, btnPrev.height = display.contentWidth * 0.1, display.contentWidth * 0.1
    btnPrev.x = MARGIN
    btnPrev.y = display.contentHeight - MARGIN
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Capa", { effect = "fade", time = 500 })
    end)

    local passInfo = display.newText({
        text = "Avançar",
        x = btnNext.x,
        y = btnNext.y - btnNext.height / 2 - 10,
        font = native.systemFont,
        fontSize = 20,
        align = "center"
    })
    passInfo:setFillColor(0)
    sceneGroup:insert(passInfo)

    local returnInfo = display.newText({
        text = "Voltar",
        x = btnPrev.x,
        y = btnPrev.y - btnPrev.height / 2 - 10,
        font = native.systemFont,
        fontSize = 20,
        align = "center"
    })
    returnInfo:setFillColor(0)
    sceneGroup:insert(returnInfo)

    audioButton = display.newImage(sceneGroup, "assets/alto-falante.png") 
    audioButton.width = display.contentWidth * 0.1
    audioButton.height = display.contentWidth * 0.1
    audioButton.x = 80
    audioButton.y = 80
    audioButton:addEventListener("tap", playAudio)

    stopButton = display.newImage(sceneGroup, "assets/ferramenta-de-audio-com-alto-falante.png")
    stopButton.width = display.contentWidth * 0.1
    stopButton.height = display.contentWidth * 0.1
    stopButton.x = 80
    stopButton.y = 80
    stopButton.isVisible = false
    stopButton:addEventListener("tap", stopAudio)
end

scene:addEventListener("create", scene)
return scene
