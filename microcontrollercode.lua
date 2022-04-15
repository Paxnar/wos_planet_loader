local telescope = GetPartFromPort(19, "Telescope")
local map = GetPartFromPort(23, "StarMap")
local Screen = GetPartFromPort(1, "TouchScreen")
local keyboard = GetPartFromPort(2, "Keyboard")
local systemcoords = {}
local jsons = {}

function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

local typecoords = Screen:CreateElement("TextLabel", {
	Text = "Please Input your system coords";
	BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Size = UDim2.new(1, 0, 0.3333, 0);
	Position = UDim2.new(0, 0, 0, 0);
})
local coordslabel = Screen:CreateElement("TextLabel", {
	Text = "";
	BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	Size = UDim2.new(1, 0, 0.3333, 0);
	Position = UDim2.new(0, 0, 0.3333, 0);
})
local confirm = Screen:CreateElement("TextButton", {
	Text = "Confirm";
	BackgroundColor3 = Color3.fromRGB(128, 128, 128);
	Size = UDim2.new(1, 0, 0.3334, 0);
	Position = UDim2.new(0, 0, 0.6666, 0);
})

local kbconnection = Keyboard:Connect("TextInputted",function(msg, plr)
coordslabel:ChangeProperties({Text = msg.gsub(msg,"\n","")})
end)

local buttonconfirm = confirm.MouseButton1Up:Connect(function(x, y)
    if coordslabel.Text != '' then
      systemcoords = mysplit(coordslabel, ', ')
    end
end)
print(systemcoords)
kbconnection:Disconnect()
buttonconfirm:Disconnect()
typecoords:Destroy()
coordslabel:Destroy()
confirm:Destroy()

for i, v in map:GetBodies() do
    local bodycoords = mysplit(i, ', ')
    telescope:Configure( { ViewCoordinates = tostring(systemcoords[1])..', '..tostring(systemcoords[2])..', '..bodycoords[1]..', '..bodycoords[2]..', '..'false')} )
    wait(2)
    local coordsinfo = telescope:GetCoordinate(tonumber(systemcoords[1]), tonumber(systemcoords[2]), tonumber(bodycoords[1]), tonumber(bodycoords[2]))
    table.insert(jsons, coordsinfo)
    end

for i, v in pairs(jsons):
    local planet = Screen:CreateElement("ImageButton", {
	Image = "rbxassetid://483228156";
	BackgroundTransparency = 1.0;
	Size = UDim2.new(0.12, 0, 0.12, 0);
	Position = UDim2.new(0, 0, 0.6666, 0);
})
end