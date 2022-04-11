local telescope = GetPartFromPort(19, "Telescope")
local map = GetPartFromPort(23, "StarMap")
local Screen = GetPartFromPort(1, "TouchScreen")
local Modem = GetPartFromPort(87, "Modem")
local systemcoords = {coord1, coord2}
local website = 'yourwebsitehere'
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

for i, v in map:GetBodies() do
    local bodycoords = mysplit(i, ', ')
    telescope:Configure( { ViewCoordinates = tostring(tostring(systemcoords[1])..', '..tostring(systemcoords[2])..', '..bodycoords[1]..', '..bodycoords[2]..', '..'false')} )
    wait(2)
    local coordsinfo = telescope:GetCoordinate(systemcoords[1], systemcoords[2], tonumber(bodycoords[1]), tonumber(bodycoords[2]))
    coordsinfo["Color"] = coordsinfo["Color"]:ToHex()
    table.insert(jsons, JSONEncode(coordsinfo))
    end
Modem:RealPostRequest(
website,
JSONEncode(jsons))