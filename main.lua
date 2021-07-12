--[[
    Lexicographic Ordering

    Auther: Ahmed Dawoud.
    adawoud1000@hotmail.com

    - Lexicographical order is a generalization of the alphabetical order
    of the dictionaries to sequences of ordered symbols or, more generally,
    of elements of a totally ordered set.
    For example;
        [1, 2, 3]
        When applying the lexicographical on will become:
            [1, 2, 3];
            [1, 3, 2];
            [3, 1, 2];
            [3, 2, 1];
            [2, 3, 1];
            [2, 1, 3];

    - The current code implementation is based on the following article by Michal Forišek:
        https://www.quora.com/How-would-you-explain-an-algorithm-that-generates-permutations-using-lexicographic-ordering?top_ans=8655235
]]
function love.load()
    love.graphics.setBackgroundColor(0.15, 0.15, 0.15)

    -- Make finished boolean to finished state that it never computes when it's over
    finished = false

    font = love.graphics.newFont("fonts/MontserratLight.ttf", 64)
    font1 = love.graphics.newFont("fonts/MontserratLight.ttf", 12)

    -- Turn off VSync to make it run faster.
    love.window.setVSync(0)

    -- This array will hold the values to applu the lexicographic order on.
    values = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}
end

function love.update(dt)
    -- return when we're finished (cuases problems when updating the array).
    if finished then
        return
    end

    --[[
        Step 1: Find the largest x such that values[x]<values[x+1].
        (If there is no such x, values is the last permutation.)
    ]]
    for i = 1, #values - 1 do
        if values[i] < values[i + 1] then
            x = i
        end
    end

    if not x then
        finished = true
        return
    end

    --[[
        Step 2: Find the largest y such that P[x]<P[y].
    ]]
    y = -1
    for j = 1, #values do
        if values[x] < values[j] then
            y = j
        end
    end

    --[[
        Step 3: Swap P[x] and P[y].
    ]]
    values[x], values[y] = values[y], values[x]

    --[[
        Step 4: Reverse P[x+1 .. n].
    ]]
    endArray = ReverseTable(table.slice(values, x + 1))
    values = table.slice(values, 1, x)
    values = TableConcat(values, endArray)
end

function love.draw()
    -- Make a string to hold the numbers and concatinate the numbers to it
    string = ""
    for i, v in ipairs(values) do
        string = string .. tostring(v)
    end
    -- Draw the string in the middle od the screen and draw the FPS
    love.graphics.setFont(font)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(string, 0, 100, 400, 'center')
    love.graphics.setFont(font1)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print(love.timer.getFPS(), 20, 20)
end

--[[
    Function to concatinate two table together
]]
function TableConcat(t1, t2)
    for i = 1, #t2 do
        table.insert(t1, t2[i])
    end
    return t1
end

--[[
    @Luiz Menezes
    https://stackoverflow.com/a/41943392/14137273
]]
function tprint(tbl, indent)
    if not indent then
        indent = 0
    end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint .. k .. "= "
        end
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n"
        elseif (type(v) == "table") then
            toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
        end
    end
    toprint = toprint .. string.rep(" ", indent - 2) .. "}"
    return toprint
end

--[[
    @Advert
    https://stackoverflow.com/a/24823383/14137273
]]
function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[i]
    end

    return sliced
end

--[[
    @Daniel Schuller
    https://gist.github.com/balaam/3122129
]]
function ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end