local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
    local MARGIN = 50

    local audioButton, stopButton
    
    local function playAudio()
        if not audioHandle then
            audioHandle = audio.loadStream("assets/contracapa.mp3")
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
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    display.setDefault("background", 210/255, 180/255, 140/255)

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

    local info = display.newText({
        text = "Autor: Victor Gabriel Vieira Fechine Tavares\nOrientador: Prof. Ewerton Mendonça\nDisciplina: Computação Gráfica e Sistemas Multimídia\n2024.2",
        x = display.contentCenterX,
        y = subtitulo.y + 100,
        font = native.systemFont,
        fontSize = 25,
        align = "center"
    })
    sceneGroup:insert(info)

    local referencias = display.newText({
        text = "Referências:\n- A Origem das Espécies (Charles Darwin)\n- A Grande História da Evolução (Richard Dawkins)\n- A Vida Maravilhosa (Stephen Jay Gould)",
        x = display.contentCenterX,
        y = info.y + 120,
        width = display.contentWidth - 150,
        font = native.systemFont,
        fontSize = 25,
        align = "center"
    })
    referencias:setFillColor(0.2)
    sceneGroup:insert(referencias)

    local btnNext = display.newImage(sceneGroup,"assets/proximo.png")

    btnNext.width = 100
    btnNext.height = 100
    btnNext.x = display.contentWidth - MARGIN
    btnNext.y = display.contentHeight - 100

    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Capa");
        print("Capa")
    end)

    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width = 100
    btnPrev.height = 100
    btnPrev.x = MARGIN
    btnPrev.y = display.contentHeight - 100
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page2", { effect = "fade", time = 500 })
    end)

    local passInfo = display.newText({
        text = "Ir para a Capa",
        x = btnNext.x - 35,
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


    audioButton = display.newImage(sceneGroup, "assets/alto-falante.png") -- Sem "local"
    audioButton.width = 80
    audioButton.height = 80
    audioButton.x = 80
    audioButton.y = 80
    audioButton:addEventListener("tap", playAudio)

    -- Botão de áudio (parar)
    stopButton = display.newImage(sceneGroup, "assets/ferramenta-de-audio-com-alto-falante.png") -- Sem "local"
    stopButton.width = 80
    stopButton.height = 80
    stopButton.x = 80
    stopButton.y = 80
    stopButton.isVisible = false -- Inicialmente invisível
    stopButton:addEventListener("tap", stopAudio)
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene