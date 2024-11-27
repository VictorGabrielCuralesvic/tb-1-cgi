local composer = require( "composer" )
local scene = composer.newScene()


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
    local MARGIN = 50

    -- variáveis de controle de progresso
    local firstPageVisited = composer.getVariable("firstPageVisited") or false
    local secondPageVisited = composer.getVariable("secondPageVisited") or false
    local thirdPageVisited = composer.getVariable("thirdPageVisited") or false
    local fourthdPageVisited = composer.getVariable("fourthdPageVisited") or false
 
    local scientistImage
    local redDots = {}

    -- coordenadas e páginas associadas para cada ponto
    local points = {
        { x = 331, y = 553, page = "Page3" },
        { x = 270, y = 508, page = "Page4" },
        { x = 170, y = 285, page = "Page6" },
        { x = 253, y = 280, page = "Page5" }
    }
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local function updateRedDotsPositions()
    for i, point in ipairs(points) do
        if redDots[i] then
            redDots[i].x = scientistImage.x - 300 + point.x
            redDots[i].y = scientistImage.y - 300 + point.y
        end
    end
end 

local function displayImageBasedOnProgress(sceneGroup)
    if scientistImage then
        scientistImage:removeSelf()
        scientistImage = nil
    end

    if not firstPageVisited then
        --buffon
        scientistImage = display.newImageRect(sceneGroup, "assets/Figura_1_Página_2-removebg-preview.png", 600, 600)
    elseif firstPageVisited and not secondPageVisited then
        -- buffon
        scientistImage = display.newImageRect(sceneGroup, "assets/Figura_1_Página_2-removebg-preview.png", 600, 600)
    elseif secondPageVisited and not thirdPageVisited then
        -- lamarck
        scientistImage = display.newImageRect(sceneGroup, "assets/Figura_2_Página_2-removebg-preview.png", 600, 600)
    elseif thirdPageVisited and not fourthdPageVisited then
        -- darwin
        scientistImage = display.newImageRect(sceneGroup, "assets/Figura_3_Página_2-removebg-preview.png", 600, 600)
    elseif fourthdPageVisited then
        scientistImage = display.newImageRect(sceneGroup, "assets/Figura_Página_2-removebg-preview.png", 600, 600)
        -- ultima
    --[[ else
        scientistImage = display.newImageRect(sceneGroup, "assets/Figura_Página_2-removebg-preview.png", 600, 600) ]]
    end

    scientistImage.x = display.contentCenterX
    scientistImage.y = display.contentCenterY + 400
    updateRedDotsPositions()
    return scientistImage
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    display.setDefault("background", 210/255, 180/255, 140/255)

    local title = display.newText({
        text = "Introdução à Evolução",
        x = display.contentCenterX,
        font = native.systemFontBold,
        fontSize = 50,
        align = "center"
    })
    title:setFillColor(0)
    sceneGroup:insert(title)

    local subtitle = display.newText({
        text = "Ideias Evolucionistas",
        x = display.contentCenterX,
        y = title.y + 60,
        width = display.contentWidth - 2 * MARGIN,
        font = native.systemFontBold,
        fontSize = 35,
        
    })
    subtitle:setFillColor(0)
    sceneGroup:insert(subtitle)

    local description = display.newText({
        text = "A evolução biológica é um processo demorado, que pode levar milhares ou até milhões de anos para ser observado em grande escala. Além dela não seguir um roteiro, assim como os pokémons seguem, mas existe muitas teorias de como ocorre a evolução na nossa realidade. Segundo uma dessas teorias, todos os organismos apresentam um ancestral comum e todas as espécies hoje existentes são resultados de contínuos processos de mudanças. Admita-se, portanto, que todas as espécies não são fixas e estão em constante modificação. Nisso de que as espécies não são fixas e estão em constante modificação, o mundo Pokémon elabora bem. E para entender melhor, vamos adentrar nas duas teorias mais profundas desta temática.",
        x = display.contentCenterX,
        y = subtitle.y + 300,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 28,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

    -- Imagem central
    --[[ local scientistImage = display.newImageRect(sceneGroup, "assets/Figura_Página_2-removebg-preview.png", 600, 600)
    scientistImage.x = display.contentCenterX
    scientistImage.y = display.contentCenterY + 400 ]]

    -- imagem inicial
    displayImageBasedOnProgress(sceneGroup)

    -- Coordenadas e páginas associadas para cada ponto vermelho
    --[[ local points = {
        { x = 331, y = 553, page = "Page3" },
        { x = 270, y = 508, page = "Page5" },
        { x = 170, y = 285, page = "Page4" },
        { x = 253, y = 280, page = "Page5" }
    } ]]

    -- Função para criar pontos interativos
    for i, point in ipairs(points) do
        local redDot = display.newCircle(sceneGroup, scientistImage.x - 300 + point.x, scientistImage.y - 300 + point.y, 10)
        redDot:setFillColor(1, 1, 1, 0.01)
        redDot:addEventListener("tap", function()
            composer.gotoScene(point.page, { effect = "fade", time = 500 })
        end)
        table.insert(redDots, redDot)
    end

    -- Botão para retornar à capa
    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width, btnPrev.height = 100, 100
    btnPrev.x = MARGIN + 50
    btnPrev.y = display.contentHeight - MARGIN + 200
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page1", { effect = "fade", time = 500 })
    end)
end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        if not firstPageVisited then
            firstPageVisited = true
            composer.setVariable("firstPageVisited", true)
        elseif firstPageVisited and not secondPageVisited then
            secondPageVisited = true
            composer.setVariable("secondPageVisited", true)
        elseif secondPageVisited and not thirdPageVisited then
            thirdPageVisited = true
            composer.setVariable("thirdPageVisited", true)
        elseif thirdPageVisited and not fourthdPageVisited then
            fourthdPageVisited = true
            composer.setVariable("fourthdPageVisited", true)
        end

        displayImageBasedOnProgress(sceneGroup)
    end
end

--[[     elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end ]]
 

-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "did" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        if scientistImage then
            scientistImage:removeSelf()
            scientistImage = nil
        end
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