local composer = require("composer")
local scene = composer.newScene()

local MARGIN = 50

local audioHandle
local audioButton, stopButton

local function playAudio()
    if not audioHandle then
        audioHandle = audio.loadStream("assets/pagina6.mp3")
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


-- create()
function scene:create(event)
    local sceneGroup = self.view
    display.setDefault("background", 210/255, 180/255, 140/255)

    local pageNumber = display.newText({
        text = "6",
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

    local description = display.newText({
        text = "O Lamarckismo, a teoria de Lamarck, baseava-se em dois pontos principais: a transmissão dos caracteres adquiridos e a lei do uso e desuso. Segundo esse naturalista, estruturas utilizadas com frequência desenvolvem-se e aquelas que não são utilizadas atrofiam-se, ou seja, se você não utiliza-se seus dentes, Lamarck acreditava que seus dentes iriam diminuir e, por conta disso, seus descendentes iriam não possuir dentes ou ter dentes pequenos. Estranho, não? O que acha?\n      Na natureza que conhecemos, Lamarck ainda utilizou das girafas para explicar sua hipótese de forma mais concreta. De acordo com as ideias propostas por Lamarck, o pescoço da girafa tornou-se comprido em decorrência da necessidade de se alcançarem folhas nos ramos mais altos.\nDe acordo com as ideias desse biólogo, as girafas esticavam seus pescoços a fim de conseguirem alimento, fazendo com que essa parte do corpo ficasse cada vez mais forte e maior, isso sendo a lei do uso e desuso. Essas mudanças, segundo o lamarckismo, eram passadas aos descendentes, isso sendo a transmissão dos caracteres adquiridos. Assim, fazendo com que os descendentes apresentassem, ao longo do tempo, pescoços cada vez maiores, uma vez que continuavam a se esforçar, e essas mudanças continuavam a ser transmitidas.\n Toque na cabeça e estique o pescoço da girafa para ela chegar ao topo, assim como Lamarck ensinou.",
        x = display.contentCenterX,
        y = title.y + 280,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 18,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

    local btnNext = display.newImage(sceneGroup, "assets/proximo.png")
    btnNext.width = 100
    btnNext.height = 100
    btnNext.x = MARGIN + 650
    btnNext.y = display.contentHeight - MARGIN - (-200)
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page5", { effect = "fade", time = 500 })
        print("Page5")
    end)

    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width = 100
    btnPrev.height = 100
    btnPrev.x = MARGIN + 50
    btnPrev.y = display.contentHeight - MARGIN - (-203)
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page2", { effect = "fade", time = 500 })
        print("Page3")
    end)

    audioButton = display.newImage(sceneGroup, "assets/alto-falante.png") 
    audioButton.width = 80
    audioButton.height = 80
    audioButton.x = 80
    audioButton.y = -60
    audioButton:addEventListener("tap", playAudio)

    stopButton = display.newImage(sceneGroup, "assets/ferramenta-de-audio-com-alto-falante.png")
    stopButton.width = 80
    stopButton.height = 80
    stopButton.x = 80
    stopButton.y = -60
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


    -- funcção de arrastar à girafa
    function giraffeNeck:touch(event)
        if event.phase == "began" then
            display.getCurrentStage():setFocus(self)
            self.isFocus = true
            self.startY = self.y
        elseif self.isFocus then
            if event.phase == "moved" then
                local deltaY = event.y - event.yStart
                local newY = self.startY + deltaY
                if newY > self.startY - 100 and newY < self.startY then
                    self.y = newY
                    self.height = self.height + (self.startY - newY) / 10
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
