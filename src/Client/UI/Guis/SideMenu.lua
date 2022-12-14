local Shared = shared.RoRooms.Shared
local Client = shared.RoRooms.Client

local Fusion = require(Shared.ExtPackages.fusion)
local States = require(Client.UI.States)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local UIComponents = Client.UI.Components
local SideMenuButton = require(UIComponents.SideMenuButton)

local ToggleableGuis = {"Profile", "Shop", "Emotes"}
local ToggleablesGuisInfo = {
    Profile = {Icon = "rbxassetid://11386962843"},
    Shop = {Icon = "rbxassetid://11386962843"},
    Emotes = {Icon = "rbxassetid://11386962843"},
}

return function(Props)
    return New "ScreenGui" {
        Name = "SideMenuGui",
        Parent = Props.Parent,
        ResetOnSpawn = false,

        [Children] = {
            New "Frame" {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.fromScale(0.985, 0.5),
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundTransparency = 1,

                [Children] = {
                    New "UIListLayout" {
                        Padding = UDim.new(0, 11),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    },

                    Computed(function()
                        local ReturnedButtons = {}
                        for LayoutOrder, GuiName in ipairs(ToggleableGuis) do
                            local GuiInfo = ToggleablesGuisInfo[GuiName]
                            table.insert(ReturnedButtons, SideMenuButton {
                                GuiName = GuiName,
                                Icon = GuiInfo.Icon,
                                Size = UDim2.fromOffset(75, 75),
                                LayoutOrder = LayoutOrder,

                                OnActivated = function()
                                    local CurrentMainGui = States.CurrentMainGui:get()
                                    if CurrentMainGui ~= GuiName then
                                        States.CurrentMainGui:set(GuiName)
                                    else
                                        States.CurrentMainGui:set("")
                                    end
                                end
                            })
                        end
                        return ReturnedButtons
                    end)
                }
            } 
        }
    }
end