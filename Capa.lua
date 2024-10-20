local composer = require( "composer" )
local Contracapa = require("Contracapa")
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
    local MARGIN = 50
 
 
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

    local autor = display.newText({
        text = "Autor: Victor Gabriel Vieira Fechine Tavares\n2024.2",
        x = display.contentCenterX,
        y = subtitulo.y + 600,
        font = native.systemFont,
        fontSize = 25,
        align = "center"
    })
    sceneGroup:insert(autor)

    local btnNext = display.newImage(sceneGroup,"assets/proximo.png")

    btnNext.width = 100
    btnNext.height = 100

    btnNext.x = MARGIN + 650
    btnNext.y = display.contentHeight - MARGIN - (-200)

    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page1", { effect = "fade", time = 500 })
        print("Page1")
    end)

    local btnPrev = display.newImage(sceneGroup,"assets/proximo.png")

    btnPrev.width = 100
    btnPrev.height = 100

    btnPrev.x = MARGIN + 50
    btnPrev.y = display.contentHeight - MARGIN - (-203)

    btnPrev.rotation = 180

    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Capa", { effect = "fade", time = 500})
        print("Capa")
    end)

 
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