local telescope = GetPartFromPort(19, "Telescope")
local map = GetPartFromPort(23, "StarMap")
local Screen = GetPartFromPort(1, "TouchScreen")
local keyboard = GetPartFromPort(2, "Keyboard")
local systemcoords = {}
local jsons = {}
local kb = true
Screen:ClearElements()

function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for w in (inputstr .. sep):gmatch("([^"..sep.."]*)"..sep) do
          table.insert(t, w)
        end
        return t
end

local typecoords = Screen:CreateElement("TextLabel", {
	Text = "Please Input your system coords";
	BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Size = UDim2.new(1, 0, 0.3333, 0);
	Position = UDim2.new(0, 0, 0, 0);
	TextScaled = true;
})
local coordslabel = Screen:CreateElement("TextLabel", {
	Text = "";
	BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Size = UDim2.new(1, 0, 0.3333, 0);
	Position = UDim2.new(0, 0, 0.3333, 0);
	TextScaled = true;
})
local confirm = Screen:CreateElement("TextButton", {
	Text = "Confirm";
	BackgroundColor3 = Color3.fromRGB(128, 128, 128);
	Size = UDim2.new(1, 0, 0.3334, 0);
	Position = UDim2.new(0, 0, 0.6666, 0);
	TextScaled = true;
})

local kbconnection = keyboard:Connect("TextInputted",function(msg, plr)
if kb then
    coordslabel:ChangeProperties({Text = msg.gsub(msg,"\n","")})
end
end)

local buttonconfirm = confirm.MouseButton1Up:Connect(function(x, y)
    if coordslabel.Text ~= '' and kb then
      systemcoords = mysplit(coordslabel.Text, ', ')
      print(systemcoords[1], systemcoords[2])
      kb = false
      Screen:ClearElements()
      for i, v in map:GetBodies() do
       local bodycoords = mysplit(i, ', ')
       telescope:Configure( { ViewCoordinates = tostring(systemcoords[1])..', '..tostring(systemcoords[2])..', '..bodycoords[1]..', '..bodycoords[2]..', '..'false'})
       wait(2)
       local coordsinfo = telescope:GetCoordinate(tonumber(systemcoords[1]), tonumber(systemcoords[2]), tonumber(bodycoords[1]), tonumber(bodycoords[2]))

       local coord = mysplit(mysplit(coordsinfo['Name'], ' ')[3], '-')
coord[table.maxn(coord)] = string.gsub(coord[table.maxn(coord)],"%)","")
if coord[1] == '(' then
	coord[2] = '-'..coord[2]
  table.remove(coord, 1)
end
if string.find(coord[1], '%(') then
  coord[1] = string.gsub(coord[1],"%(","")
end
if coord[2] == '' then
	coord[table.maxn(coord)] = '-'..coord[table.maxn(coord)]
  table.remove(coord, 2)
end
if string.sub(coord[1], 1, 1) == '-' then
	coord[1] = 0 - tonumber(string.sub(coord[1], 2, 2), 16)
else
  coord[1] = tonumber(coord[1], 16)
end
if string.sub(coord[2], 1, 1) == '-' then
	coord[2] = 0 - tonumber(string.sub(coord[2], 2, 2), 16)
else
  coord[2] = tonumber(coord[2], 16)
end

for i, v in pairs(coord) do
  print(i, v)
end

       local planet = Screen:CreateElement("ImageButton", {
	    Image = "rbxassetid://483228156";
	    BackgroundTransparency = 1.0;
	    Size = UDim2.new(0.08, 0, 0.08, 0);
	    Position = UDim2.new(30 * (12 + coord[1]) / 750, 0, 30 * (12 - coord[2]) / 750, 0);
	    ImageColor3 = coordsinfo['Color']
       })
       planet.MouseButton1Up:Connect(function(x, y)
       print('yes')
       end)
       --table.insert(jsons, coordsinfo)
      end
    end
end)