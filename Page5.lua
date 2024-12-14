local composer = require("composer")
local scene = composer.newScene()

local MARGIN = 50

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
        text = "5",
        x = display.contentWidth - MARGIN,
        y = MARGIN,
        font = native.systemFont,
        fontSize = 24,
        align = "right"
    })
    pageNumber:setFillColor(0)
    sceneGroup:insert(pageNumber)

    local title = display.newText({
        text = "Ideia Evolucionista de Darwin e a Seleção Natural",
        x = display.contentCenterX,
        y = 130,
        font = native.systemFontBold,
        fontSize = 30
    })
    title:setFillColor(0, 0, 0)
    sceneGroup:insert(title)

    local description = display.newText({
        text = " Charles Darwin é o nome mais associado à teoria da evolução. Em 1859, ele publicou A Origem das Espécies, onde propôs a ideia de seleção natural como o mecanismo pelo qual a evolução ocorre. Darwin observou que os indivíduos em uma população variam em suas características, e essas variações podem afetar suas chances de sobrevivência e reprodução. Aqueles com características vantajosas têm maior probabilidade de passar seus genes para as gerações seguintes. Na natureza, os organismos variam em suas características, como tamanho, força ou até mesmo a presença de estruturas específicas, como os chifres. Um exemplo clássico é o dos alces. Em disputas por dominância, alces machos com chifres grandes e robustos tinham mais chances de vencer lutas contra machos sem chifres. Isso significava que os alces com chifres conseguiam acasalar e passar seus genes adiante, enquanto os alces sem chifres perdiam essas oportunidades. Com o passar do tempo, essa seleção natural favoreceu a prevalência de alces com chifres na população.\n \n Toque no alce com chifre para ativar a colisão, assim simulando uma disputa e entender como a seleção natural funciona!",
        x = display.contentCenterX,
        y = title.y + 280,
        width = display.contentWidth - 3 * MARGIN,
        font = native.systemFont,
        fontSize = 20,
        align = "left"
    })
    description:setFillColor(0)
    sceneGroup:insert(description)

  -- Alce com chifres
  local alceComChifres = display.newImage(sceneGroup, "assets/alce.png")
  alceComChifres.x = display.contentCenterX - 200
  alceComChifres.y = display.contentHeight - 150
  alceComChifres.width = 150
  alceComChifres.height = 150

  -- Alce sem chifres
  local alceSemChifres = display.newImage(sceneGroup, "assets/alce2.png")
  alceSemChifres.x = display.contentCenterX + 200
  alceSemChifres.y = display.contentHeight - 150
  alceSemChifres.width = 150
  alceSemChifres.height = 150

  -- Função de colisão
  local function colidirAlces()
    -- Ambos os alces avançam para o centro
    transition.to(alceComChifres, {
        x = display.contentCenterX - 50,
        time = 500,
        onComplete = function()
            transition.to(alceSemChifres, {
                x = display.contentCenterX + 50,
                time = 500,
                onComplete = function()
                    -- Criar a nuvem da colisão
                    local nuvem = display.newImage(sceneGroup, "assets/nuvemnuvem.png")
                    nuvem.x = display.contentCenterX
                    nuvem.y = display.contentHeight - 150
                    nuvem.width = 330
                    nuvem.height = 330

                    -- Remover o alce sem chifres enquanto a nuvem aparece
                    alceSemChifres:removeSelf()
                    alceSemChifres = nil

                    -- Aumentar o tempo de visibilidade da nuvem
                    timer.performWithDelay(1000, function()
                        transition.to(nuvem, {
                            time = 500,
                            alpha = 0,
                            onComplete = function()
                                nuvem:removeSelf()
                                nuvem = nil

                                -- Exibe mensagem de vitória
                                local winText = display.newText({
                                    text = "O alce com chifres venceu! Ele é mais apto.",
                                    x = display.contentCenterX,
                                    y = display.contentHeight - 250,
                                    font = native.systemFontBold,
                                    fontSize = 24
                                })
                                winText:setFillColor(0, 0.5, 0)
                                sceneGroup:insert(winText)
                            end
                        })
                    end)
                end
            })
        end
    })
end

  alceComChifres:addEventListener("tap", colidirAlces)


--[[     local btnNext = display.newImage(sceneGroup, "assets/proximo.png")
    btnNext.width, btnNext.height = display.contentWidth * 0.1, display.contentWidth * 0.1
    btnNext.x = display.contentWidth - MARGIN
    btnNext.y = display.contentHeight - MARGIN
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page5", { effect = "fade", time = 500 })
    end) ]]

    local btnPrev = display.newImage(sceneGroup, "assets/proximo.png")
    btnPrev.width, btnPrev.height = display.contentWidth * 0.1, display.contentWidth * 0.1
    btnPrev.x = MARGIN
    btnPrev.y = display.contentHeight - MARGIN
    btnPrev.rotation = 180
    btnPrev:addEventListener("tap", function(event)
        composer.gotoScene("Page2", { effect = "fade", time = 500 })
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
end

scene:addEventListener("create", scene)
return scene
