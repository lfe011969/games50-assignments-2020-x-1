--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

-- Add images for scoring at certain levels
local pumpkin = love.graphics.newImage('Pumpkin.png')
local cherry = love.graphics.newImage('Cherry.png')
local heart = love.graphics.newImage('Heart.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- display the icons for scoring at different levels (pumpkin - 3, cherry - 5, heart - 7)
    if self.score >= 7 then
        love.graphics.draw(heart, (VIRTUAL_WIDTH / 2) - (cherry:getWidth() / 16), (VIRTUAL_HEIGHT / 2) - (heart:getHeight() / 16 + 10), 0, 0.125, 0.125)
    elseif self.score >= 5 then
        love.graphics.draw(cherry, (VIRTUAL_WIDTH / 2) - (cherry:getWidth() / 16), (VIRTUAL_HEIGHT / 2) - (cherry:getHeight() / 16 + 10), 0, 0.125, 0.125)
    elseif self.score >= 3 then
        love.graphics.draw(pumpkin, (VIRTUAL_WIDTH / 2) - (cherry:getWidth() / 16), (VIRTUAL_HEIGHT / 2) - (pumpkin:getHeight() / 16 + 10), 0, 0.125, 0.125)
    end
    
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end