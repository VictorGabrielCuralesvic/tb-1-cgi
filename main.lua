-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--[[ local sheetOptions =
{
  width = 200,
  height = 200,
  numFrames = 3
}

local sheet = graphics.newImageSheet( "assets/charmander-evolution.png", sheetOptions )

local sequences = {
    {
        name = "evo",
        start = 1,
        count = 3,
        time = 3000,
        loopcount = 0
    }
}

local frame = display.newSprite(sheet,sequences);
--frame.x = 100
--frame.y = 100

frame:setSequence("evo")
frame:play()

transition.to(frame, {
    time=1000,
    x = display.contentCenterX,
    y = display.contentCenterY,
    onComplete = function ()
        transition.to(frame, {
            time=1000,
            delay=1000,
            alpha=1,
            transintion = easing.flip,
            x = 0,
            y = 0
        })
    end
})
 ]]

--[[  local C = require("Constants")

 local physics = require("physics")
 physics.start()
 -- physics.setGravity( 0, 0 ) -- Gravidade zero
 
 display.setStatusBar( display.HiddenStatusBar )
 
 local group = display.newGroup()
 
 local leftWall = display.newRect(
   group,
   0,
   C.CH,
   20,
   C.H
 )
 leftWall:setFillColor(1,0,0)
 physics.addBody(leftWall,"static")

 local rightWall = display.newRect(
    group,
    C.W,
    C.CH,
    20,
    C.H
 )
 rightWall:setFillColor(1,0,0)
 physics.addBody(rightWall,"static")

 local floor = display.newRect(
    group,
    C.CW,
    C.H,
    C.W,
    20
 )
 floor:setFillColor(1,0,0)
 physics.addBody(floor,"static")
 
 local ball = display.newCircle(
    group,
    C.CW,
    100,
    50
  )
  ball:setFillColor(0,0,1)
  physics.addBody(ball,"dynamic", {radius=50}) ]]

  local composer = require("composer")

  composer.gotoScene("Capa");