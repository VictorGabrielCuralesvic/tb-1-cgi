local composer = require("composer")
local scene = composer.newScene()

local MARGIN = display.contentWidth * 0.065

local audioHandle
local audioButton, stopButton

local function playAudio()
    if not audioHandle then
        audioHandle = audio.loadStream("assets/pagina4.mp3")
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
        text = "4",
        x = display.contentWidth - MARGIN,
        y = MARGIN,
        font = native.systemFont,
        fontSize = 24,
        align = "right"
    })
    pageNumber:setFillColor(0)
    sceneGroup:insert(pageNumber)

    local title = display.newText({
        text = "Ideia Evolucionista de Lamarck",
        x = display.contentCenterX,
        y = 80,
        font = native.systemFontBold,
        fontSize = 30
    })
    title:setFillColor(0, 0, 0)
    sceneGroup:insert(title)

    -- Descrição
    local description = display.newText({
        text = "O Lamarckismo, a teoria de Lamarck, baseava-se em dois pontos principais: a transmissão dos caracteres adquiridos e a lei do uso e desuso. Segundo esse naturalista, estruturas utilizadas com frequência desenvolvem-se e aquelas que não são utilizadas atrofiam-se. De acordo com as ideias propostas por Lamarck, o pescoço da girafa tornou-se comprido em decorrência da necessidade de se alcançarem folhas nos ramos mais altos.\nDe acordo com as ideias desse biólogo, as girafas esticavam seus pescoços a fim de conseguirem alimento, fazendo com que essa parte do corpo ficasse cada vez mais forte e maior. Essas mudanças, segundo o lamarckismo, eram passadas aos descendentes. Assim, fazendo com que os descendentes apresentassem, ao longo do tempo, pescoços cada vez maiores, uma vez que continuavam a se esforçar, e essas mudanças continuavam a ser transmitidas.\n Toque na cabeça e arraste o pescoço da girafa para ela chegar ao topo, assim como Lamarck disse que elas evoluiram.",
        x = display.contentCenterX,
        y = title.y + 280,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 22,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

--[[     local btnNext = display.newImage(sceneGroup, "assets/proximo.png")
    btnNext.width, btnNext.height = display.contentWidth * 0.1, display.contentWidth * 0.1
    btnNext.x = display.contentWidth - MARGIN
    btnNext.y = display.contentHeight - MARGIN
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page5", { effect = "fade", time = 500 })
        print("Page5")
    end) ]]

    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width, btnPrev.height = display.contentWidth * 0.1, display.contentWidth * 0.1
    btnPrev.x = MARGIN
    btnPrev.y = display.contentHeight - MARGIN
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page2", { effect = "fade", time = 500 })
        print("Page3")
    end)

--[[     local passInfo = display.newText({
        text = "Avançar",
        x = btnNext.x,
        y = btnNext.y - btnNext.height / 2 - 10,
        font = native.systemFont,
        fontSize = 20,
        align = "center"
    })
    passInfo:setFillColor(0)
    sceneGroup:insert(passInfo) ]]

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
    audioButton.width = 80
    audioButton.height = 80
    audioButton.x = 55
    audioButton.y = 80
    audioButton:addEventListener("tap", playAudio)

    stopButton = display.newImage(sceneGroup, "assets/ferramenta-de-audio-com-alto-falante.png")
    audioButton.width = 80
    audioButton.height = 80
    audioButton.x = 55
    audioButton.y = 80
    stopButton.isVisible = false
    stopButton:addEventListener("tap", stopAudio)

    -- Imagens adicionais (girafa e árvore)
    --[[ local giraffe = display.newImage(sceneGroup, "assets/girafa__2_-removebg-preview.png")
    giraffe1.x = display.contentCenterX - 100
    giraffe1.y = display.contentHeight - 130
    giraffe1.width = 120
    giraffe1.height = 160 ]]

    local giraffeBody = display.newImage(sceneGroup, "assets/girafabody.png")
    giraffeBody.x = display.contentCenterX - 100
    giraffeBody.y = display.contentHeight - 50
    giraffeBody.width = 120
    giraffeBody.height = 120

    local giraffeNeck = display.newImage(sceneGroup, "assets/girafa-neck.png")
    giraffeNeck.x = giraffeBody.x
    giraffeNeck.y = giraffeBody.y - giraffeBody.height / 2 
    giraffeNeck.width = 100
    giraffeNeck.height = 100

    local MAX_HEIGHT = 150
    local MIN_HEIGHT = giraffeNeck.height


    function giraffeNeck:touch(event)
        if event.phase == "began" then
            display.getCurrentStage():setFocus(self)
            self.isFocus = true
            self.startY = self.y
        elseif self.isFocus then
            if event.phase == "moved" then
                local deltaY = event.y - event.yStart
                local newHeight = giraffeNeck.height - deltaY / 10

                if newHeight >= MIN_HEIGHT and newHeight <= MAX_HEIGHT then
                    giraffeNeck.height = newHeight
                    self.y = giraffeBody.y - giraffeBody.height / 2 - giraffeNeck.height / 2
                end
            elseif event.phase == "ended" or event.phase == "cancelled" then
                display.getCurrentStage():setFocus(nil)
                self.isFocus = false
            end
        end
        return true
    end
    giraffeNeck:addEventListener("touch", giraffeNeck)



    local tree = display.newImage(sceneGroup, "assets/arvore (1).png")
    tree.x = display.contentCenterX - 20
    tree.y = display.contentHeight - 150
    tree.width = 160
    tree.height = 300
end

scene:addEventListener("create", scene)
return scene
