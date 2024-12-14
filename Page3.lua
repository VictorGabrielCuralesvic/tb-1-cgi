local composer = require("composer")
local scene = composer.newScene()

local MARGIN = display.contentWidth * 0.065
local audioHandle

local audioClip = audio.loadSound("assets/Text to Speech.wav")
if not audioClip then
    print("Erro ao carregar o áudio.")
end

audio.setVolume(1.0)

-- Variáveis para os botões, declaradas globalmente no módulo
local audioButton
local stopButton

local function playAudio()
    if audioClip then
        if audioHandle then
            audio.stop(audioHandle)
        end

        audioHandle = audio.play(audioClip, {
            onComplete = function()
                audioHandle = nil
                audioButton.isVisible = true
                stopButton.isVisible = false
                print("Áudio concluído")
            end
        })

        audioButton.isVisible = false
        stopButton.isVisible = true

        print("Reproduzindo áudio")
    else
        print("O áudio não está disponível")
    end
end

local function stopAudio()
    if audioHandle then
        audio.stop(audioHandle)
        audioHandle = nil

        -- Alternar a visibilidade dos botões
        audioButton.isVisible = true
        stopButton.isVisible = false

        print("Áudio interrompido")
    else
        print("Nenhum áudio está tocando")
    end
end

-- create()
function scene:create(event)
    local sceneGroup = self.view
    display.setDefault("background", 210/255, 180/255, 140/255)

    local pageNumber = display.newText({
        text = "3",
        x = display.contentWidth - MARGIN,
        y = MARGIN,
        font = native.systemFont,
        fontSize = 24,
        align = "right"
    })
    pageNumber:setFillColor(0)
    sceneGroup:insert(pageNumber)

    local title = display.newText({
        text = "George Buffon",
        x = display.contentCenterX,
        y = 80,
        font = native.systemFontBold,
        fontSize = 30
    })
    title:setFillColor(0, 0, 0)
    sceneGroup:insert(title)
    
    local description = display.newText({
        text = "Georges-Louis Leclerc, conhecido como Conde de Buffon, foi um dos primeiros naturalistas a questionar a ideia de que as espécies eram imutáveis, uma noção dominante em sua época. Em sua obra Histoire Naturelle (1749), Buffon sugeriu que as espécies poderiam mudar ao longo do tempo e que a Terra era muito mais antiga do que se pensava (ele estimou a idade da Terra em cerca de 75.000 anos, o que era uma grande expansão para a época).\n\nBuffon propôs que:\n- Ele observou que diferentes regiões geográficas com condições similares abrigavam diferentes espécies, sugerindo que elas poderiam ter mudado ou se adaptado ao ambiente local, como ocorreu com os equilos do Grand Canyon, que eram uma espécie só, mas após a separação da região, tiveram dois esquilos diferentes.\n Balance o seu dispositivo para o Grand Canyon partir e dar origem as duas especies de esquilo.",
        x = display.contentCenterX,
        y = title.y + 300,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 22,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

    -- Botão de tocar áudio
    audioButton = display.newImage(sceneGroup, "assets/alto-falante.png")
    audioButton.width = 80
    audioButton.height = 80
    audioButton.x = 55
    audioButton.y = 80
    audioButton:addEventListener("tap", playAudio)

    -- Botão de parar áudio
    stopButton = display.newImage(sceneGroup, "assets/ferramenta-de-audio-com-alto-falante.png")
    stopButton.width = 80
    stopButton.height = 80
    audioButton.x = 55
    audioButton.y = 80
    stopButton.isVisible = false  -- Inicialmente invisível
    stopButton:addEventListener("tap", stopAudio)

    -- Botão anterior
    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width, btnPrev.height = display.contentWidth * 0.1, display.contentWidth * 0.1
    btnPrev.x = MARGIN
    btnPrev.y = display.contentHeight - MARGIN
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page2", { effect = "fade", time = 500 })
        print("Page2")
    end)

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

    local grandCanyonImage = display.newImage(sceneGroup, "assets/grande-canyon.png")
    grandCanyonImage.x = display.contentCenterX
    grandCanyonImage.y = display.contentCenterY + 200
    grandCanyonImage.width = 200
    grandCanyonImage.height = 200


    local grandCanyonCrackedImage = display.newImage(sceneGroup, "assets/Frame 3.png")
    grandCanyonCrackedImage.x = display.contentCenterX
    grandCanyonCrackedImage.y = display.contentCenterY + 220
    grandCanyonCrackedImage.width = 436.5
    grandCanyonCrackedImage.height = 303
    grandCanyonCrackedImage.isVisible = false

    local esquiloAncestral = display.newImage(sceneGroup, "assets/esquilo-ancestral.png")
    esquiloAncestral.x = grandCanyonImage.x
    esquiloAncestral.y = grandCanyonImage.y + 150
    esquiloAncestral.width = 100
    esquiloAncestral.height = 100

    local esquiloVermelho = display.newImage(sceneGroup, "assets/esquilo-vermelho.png")
    esquiloVermelho.x = grandCanyonCrackedImage.x - 80
    esquiloVermelho.y = grandCanyonCrackedImage.y + 150
    esquiloVermelho.width = 80
    esquiloVermelho.height = 80
    esquiloVermelho.isVisible = false

    local esquiloMarrom = display.newImage(sceneGroup, "assets/esquilo-marrom.png")
    esquiloMarrom.x = grandCanyonCrackedImage.x + 80
    esquiloMarrom.y = grandCanyonCrackedImage.y + 150
    esquiloMarrom.width = 80
    esquiloMarrom.height = 80
    esquiloMarrom.isVisible = false

    local function onAccelerometer(event)
        local shakeThreshold = 0.8
        if not parted and (math.abs(event.xGravity) > shakeThreshold or math.abs(event.yGravity) > shakeThreshold or math.abs(event.zGravity) > shakeThreshold) then
            grandCanyonImage.isVisible = false
            esquiloAncestral.isVisible = false

            grandCanyonCrackedImage.isVisible = true
            esquiloVermelho.isVisible = true
            esquiloMarrom.isVisible = true

            parted = true
        end
    end

    Runtime:addEventListener("accelerometer", onAccelerometer)

    function scene:hide(event)
        if event.phase == "will" then
            Runtime:removeEventListener("accelerometer", onAccelerometer)
        end
    end

end

-- Liberar o áudio quando sair da cena
function scene:destroy(event)
    if audioHandle then
        audio.stop(audioHandle)  -- Parar o áudio se ainda estiver tocando
    end
    if audioClip then
        audio.dispose(audioClip)
        audioClip = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)
scene:addEventListener("hide", scene)
return scene
