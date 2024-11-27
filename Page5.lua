local composer = require("composer")
local scene = composer.newScene()

local MARGIN = 50

function scene:create(event)
    local sceneGroup = self.view
    display.setDefault("background", 210/255, 180/255, 140/255)

    -- Título
    local title = display.newText({
        text = "Ideia Evolucionista de Darwin e a Seleção Natural",
        x = display.contentCenterX,
        y = 80,
        font = native.systemFontBold,
        fontSize = 30
    })
    title:setFillColor(0, 0, 0)
    sceneGroup:insert(title)

    -- Descrição
    local description = display.newText({
        text = "      Charles Darwin é o nome mais associado à teoria da evolução. Em 1859, ele publicou A Origem das Espécies, onde propôs a ideia de seleção natural como o mecanismo pelo qual a evolução ocorre. Darwin observou que os indivíduos em uma população variam em suas características, e essas variações podem afetar suas chances de sobrevivência e reprodução. Aqueles com características vantajosas têm maior probabilidade de passar seus genes para as gerações seguintes.\n      A seleção natural é o processo pelo qual organismos com características mais vantajosas para sobreviver e se reproduzir em um determinado ambiente têm mais chances de passar essas características para a próxima geração. Esse conceito, proposto por Charles Darwin, é um dos principais mecanismos da evolução. Na natureza, os organismos variam em suas características, como tamanho, força ou até mesmo a presença de estruturas específicas, como os chifres.\n      Essas variações surgem devido a mutações genéticas e influências ambientais. Algumas dessas características dão aos indivíduos uma vantagem no ambiente em que vivem. Um exemplo clássico é o dos alces. Em disputas por dominância, alces machos com chifres grandes e robustos tinham mais chances de vencer lutas contra machos sem chifres. Isso significava que os alces com chifres conseguiam acasalar e passar seus genes adiante, enquanto os alces sem chifres perdiam essas oportunidades. Com o passar do tempo, essa seleção natural favoreceu a prevalência de alces com chifres na população.\n \n Clique no alce com chifres para simular uma disputa e entender como a seleção natural funciona!",
        x = display.contentCenterX,
        y = title.y + 360,
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

  -- Adicionar evento de toque no alce com chifres
  alceComChifres:addEventListener("tap", colidirAlces)


    -- Botão próximo
    local btnNext = display.newImage(sceneGroup, "assets/proximo.png")
    btnNext.width = 100
    btnNext.height = 100
    btnNext.x = MARGIN + 650
    btnNext.y = display.contentHeight - MARGIN - (-200)
    btnNext:addEventListener("tap", function(event)
        composer.gotoScene("Page5", { effect = "fade", time = 500 })
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
    end)
end

scene:addEventListener("create", scene)
return scene
