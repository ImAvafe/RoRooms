local Shared = shared.RoRooms.Shared
local Client = shared.RoRooms.Client

local Fusion = require(Shared.ExtPackages.fusion)

local Hydrate = Fusion.Hydrate
local WithChild = Fusion.WithChild
local Children = Fusion.Children

local UIInstances = Client.UI.Instances

return function (Props)
    return Hydrate(UIInstances.MainFrame:Clone()) {
        Name = Props.Name,
        AnchorPoint = Props.AnchorPoint,
        Position = Props.Position,
        Size = Props.Size,

        [WithChild "Content"] = {
            [Children] = Props[Children],

            [WithChild "UIListLayout"] = {
                Padding = UDim.new(0, Props.ChildSpacing)
            },
        }
    }
end