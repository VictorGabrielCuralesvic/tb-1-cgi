local composer = require("composer")
local scene = composer.newScene()

local MARGIN = 50
local audioHandle

-- Carregar o arquivo de áudio fora das funções para uso em várias partes do código
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

        -- Alternar a visibilidade dos botões
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
        text = "Georges-Louis Leclerc, conhecido como Conde de Buffon, foi um dos primeiros naturalistas a questionar a ideia de que as espécies eram imutáveis, uma noção dominante em sua época. Em sua obra Histoire Naturelle (1749), Buffon sugeriu que as espécies poderiam mudar ao longo do tempo e que a Terra era muito mais antiga do que se pensava (ele estimou a idade da Terra em cerca de 75.000 anos, o que era uma grande expansão para a época).\n\nBuffon propôs que:\n- As espécies poderiam ter um 'ancestral comum' e se modificariam em resposta ao ambiente, embora ele nunca tenha desenvolvido uma teoria evolutiva completamente articulada.\n- Ele observou que diferentes regiões geográficas com condições similares abrigavam diferentes espécies, sugerindo que elas poderiam ter mudado ou se adaptado ao ambiente local.\n\nAbaixo, clique no botão para escutar um exemplo completo de como isso acontece.",
        x = display.contentCenterX,
        y = title.y + 220,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 18,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

    -- Botão de tocar áudio
    audioButton = display.newImage(sceneGroup, "assets/alto-falante.png")
    audioButton.width = 80
    audioButton.height = 80
    audioButton.x = display.contentCenterX
    audioButton.y = display.contentCenterY + 180
    audioButton:addEventListener("tap", playAudio)

    -- Botão de parar áudio
    stopButton = display.newImage(sceneGroup, "assets/ferramenta-de-audio-com-alto-falante.png")
    stopButton.width = 80
    stopButton.height = 80
    stopButton.x = display.contentCenterX
    stopButton.y = display.contentCenterY + 180
    stopButton.isVisible = false  -- Inicialmente invisível
    stopButton:addEventListener("tap", stopAudio)

    -- Botão próximo
    local btnNext = display.newImage(sceneGroup, "assets/proximo.png")
    btnNext.width = 100
    btnNext.height = 100
    btnNext.x = MARGIN + 650
    btnNext.y = display.contentHeight - MARGIN - (-200)
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page4", { effect = "fade", time = 500 })
        print("Page4")
    end)

    -- Botão anterior
    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width = 100
    btnPrev.height = 100
    btnPrev.x = MARGIN + 50
    btnPrev.y = display.contentHeight - MARGIN - (-203)
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page2", { effect = "fade", time = 500 })
        print("Page2")
    end)
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
return scene
