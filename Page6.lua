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

    -- Título
    local title = display.newText({
        text = "Síntese Moderna de Theodosius Dobzhansky",
        x = display.contentCenterX,
        y = 80,
        font = native.systemFontBold,
        fontSize = 30
    })
    title:setFillColor(0, 0, 0)
    sceneGroup:insert(title)

    -- Descrição
    local description = display.newText({
        text = "\n      A Síntese Moderna, com Theodosius Dobzhansky como um de seus principais precursores, foi a integração da teoria da evolução por seleção natural de Darwin com as descobertas da genética mendeliana, formando uma compreensão mais completa e científica do processo evolutivo.\n     Antes da Síntese Moderna, havia uma lacuna entre as ideias de Darwin e o conhecimento da genética, pois Darwin não conhecia os mecanismos de hereditariedade que governavam a variação das espécies. Em 1937, Dobzhansky publicou seu livro Genetics and the Origin of Species, onde explicou como as mutações genéticas, recombinação genética e deriva genética fornecem as variações sobre as quais a seleção natural atua.\n A Síntese Moderna afirma que: A evolução é impulsionada por pequenas mutações e variações genéticas.\n A seleção natural age sobre essas variações, favorecendo as que são vantajosas para a sobrevivência e a reprodução.",
        x = display.contentCenterX,
        y = title.y + 220,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 18,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

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
