local composer = require("composer")
local scene = composer.newScene()

local MARGIN = 50

-- Função de criação da cena
function scene:create(event)
    local sceneGroup = self.view

    display.setDefault("background", 210/255, 180/255, 140/255)

    -- Título
    local title = display.newText({
        text = "Introdução à Evolução",
        x = display.contentCenterX,
        --[[ y = MARGIN, ]]
        --[[ width = display.contentHeight - 200, ]]
        font = native.systemFontBold,
        fontSize = 50,
        align = "center"
    })
    title:setFillColor(0)
    sceneGroup:insert(title)

    -- Subtítulo
    local subtitle = display.newText({
        text = "Conceito da Evolução Biológica",
        x = display.contentCenterX,
        y = title.y + 80,
        width = display.contentWidth - 2 * MARGIN,
        font = native.systemFontBold,
        fontSize = 35,
        
    })
    subtitle:setFillColor(0)
    sceneGroup:insert(subtitle)

    -- Texto explicativo
    local description = display.newText({
        text = "A evolução biológica é o processo de mudança nas características hereditárias de uma população ao longo de várias gerações. Essas mudanças ocorrem através de variações genéticas, que podem ser benéficas, neutras ou prejudiciais para os organismos em questão. O conceito central da evolução é que todos os seres vivos compartilham um ancestral comum, e, ao longo do tempo, as espécies se modificam em resposta ao ambiente, resultando na diversidade de formas de vida que vemos hoje.\n\nClique no ambiente que você deseja e veja como o ancestral modificou em resposta ao ambiente.",
        x = display.contentCenterX,
        y = subtitle.y + 260,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 28,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

    -- Ícones de ambiente: mar e floresta
    local oceanIcon = display.newImage(sceneGroup, "assets/onda.png")
    oceanIcon.x = display.contentCenterX - 150
    oceanIcon.y = display.contentHeight - 200
    oceanIcon.width, oceanIcon.height = 100, 100

    local forestIcon = display.newImage(sceneGroup, "assets/floresta.png")
    forestIcon.x = display.contentCenterX + 150
    forestIcon.y = display.contentHeight - 200
    forestIcon.width, forestIcon.height = 100, 100

    -- Texto de ancestral comum
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

    -- Ícones dos animais: baleia e macaco (inicialmente invisíveis)
    local whaleIcon = display.newImage(sceneGroup, "assets/baleia.png")
    whaleIcon.x = display.contentCenterX - 150
    whaleIcon.y = display.contentHeight - 100
    whaleIcon.width, whaleIcon.height = 80, 80
    whaleIcon.isVisible = false -- torna a baleia invisível inicialmente

    local monkeyIcon = display.newImage(sceneGroup, "assets/macaco.png")
    monkeyIcon.x = display.contentCenterX + 150
    monkeyIcon.y = display.contentHeight - 100
    monkeyIcon.width, monkeyIcon.height = 80, 80
    monkeyIcon.isVisible = false -- torna o macaco invisível inicialmente

    -- Linhas de evolução conectando ancestral aos ambientes e aos animais
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

    -- Interações ao clicar nos ícones de ambiente
    oceanIcon:addEventListener("tap", function(event)
        whaleIcon.isVisible = true -- torna a baleia visível
        monkeyIcon.isVisible = false -- esconde o macaco
    end)

    forestIcon:addEventListener("tap", function(event)
        whaleIcon.isVisible = false -- esconde a baleia
        monkeyIcon.isVisible = true -- torna o macaco visível
    end)

    -- Botão próximo
    local btnNext = display.newImage(sceneGroup, "assets/proximo.png")
    btnNext.width, btnNext.height = 100, 100
    btnNext.x = display.contentWidth - MARGIN - 50
    btnNext.y = display.contentHeight - MARGIN + 200
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page2", { effect = "fade", time = 500 })
    end)

    -- Botão anterior
    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width, btnPrev.height = 100, 100
    btnPrev.x = MARGIN + 50
    btnPrev.y = display.contentHeight - MARGIN + 200
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Capa", { effect = "fade", time = 500 })
    end)
end

scene:addEventListener("create", scene)
return scene
