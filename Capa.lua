local composer = require("composer")
local scene = composer.newScene()

local audioHandle
local audioButton, stopButton

local MARGIN = display.contentWidth * 0.065

local function playAudio()
    if not audioHandle then
        audioHandle = audio.loadStream("assets/capa.mp3")
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

    display.setDefault("background", 210 / 255, 180 / 255, 140 / 255)

    local titulo = display.newText({
        text = "ONIS\nVOLVERE\nEVOLUTIO\nEVOLUÇÃO",
        x = display.contentCenterX,
        y = display.contentCenterY - 300,
        width = display.contentWidth - 100,
        font = native.systemFontBold,
        fontSize = 70,
        align = "center"
    })
    titulo:setFillColor(0)
    sceneGroup:insert(titulo)

    local subtitulo = display.newText({
        text = "Evidências da evolução e especiação",
        x = display.contentCenterX,
        y = titulo.y + 200,
        font = native.systemFont,
        fontSize = 30
    })
    sceneGroup:insert(subtitulo)

    local autor = display.newText({
        text = "Autor: Victor Gabriel Vieira Fechine Tavares\n2024.2",
        x = display.contentCenterX,
        y = subtitulo.y + 100,
        font = native.systemFont,
        fontSize = 25,
        align = "center"
    })
    sceneGroup:insert(autor)

    local btnNext = display.newImage(sceneGroup, "assets/proximo.png")
    btnNext.width = 100
    btnNext.height = 100
    btnNext.x = display.contentWidth - MARGIN
    btnNext.y = display.contentHeight - 100
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page1", { effect = "fade", time = 500 })
    end)

--[[     local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width = 100
    btnPrev.height = 100
    btnPrev.x = MARGIN
    btnPrev.y = display.contentHeight - 100
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Capa", { effect = "fade", time = 500 })
    end) ]]

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

--[[     local returnInfo = display.newText({
        text = "Voltar",
        x = btnPrev.x,
        y = btnPrev.y - btnPrev.height / 2 - 10,
        font = native.systemFont,
        fontSize = 20,
        align = "center"
    })
    returnInfo:setFillColor(0)
    sceneGroup:insert(returnInfo) ]]

    audioButton = display.newImage(sceneGroup, "assets/alto-falante.png") -- Sem "local"
    audioButton.width = 80
    audioButton.height = 80
    audioButton.x = 80
    audioButton.y = 80
    audioButton:addEventListener("tap", playAudio)

    stopButton = display.newImage(sceneGroup, "assets/ferramenta-de-audio-com-alto-falante.png") -- Sem "local"
    stopButton.width = 80
    stopButton.height = 80
    stopButton.x = 80
    stopButton.y = 80
    stopButton.isVisible = false -- Inicialmente invisível
    stopButton:addEventListener("tap", stopAudio)
end

scene:addEventListener("create", scene)
return scene
