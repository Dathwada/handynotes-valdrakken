----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, private = ...

local addon = LibStub("AceAddon-3.0"):NewAddon(FOLDER_NAME, "AceEvent-3.0", "AceTimer-3.0")
local AceDB = LibStub("AceDB-3.0")
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HBD = LibStub('HereBeDragons-2.0')
local L = LibStub("AceLocale-3.0"):GetLocale(FOLDER_NAME)

private.DATA = {}
private.locale = L

addon.constants = private.constants

_G.HandyNotes_Valdrakken = addon

local IsQuestCompleted = C_QuestLog.IsQuestFlaggedCompleted
local constantsicon = private.constants.icon
local DATA = private.DATA

----------------------------------------------------------------------------------------------------
-----------------------------------------------LOCALS-----------------------------------------------
----------------------------------------------------------------------------------------------------

local requires          = L["handler_tooltip_requires"]
local RequiresPlayerLvl = L["handler_tooltip_requires_level"]
local RequiresQuest     = L["handler_tooltip_quest"]
local RetrievingData    = L["handler_tooltip_data"]

----------------------------------------------------------------------------------------------------
--------------------------------------------GET NPC NAMES-------------------------------------------
----------------------------------------------------------------------------------------------------

local function GetCreatureNameByID(id)
    if id == nil then return end
    if DATA.npcs[id] == nil then error("NPC " .. id .. " not found") end

    local name = DATA.npcs[id].name or UNKNOWN
    local sublabel = DATA.npcs[id].sublabel or ""

    return name, sublabel
end

----------------------------------------------------------------------------------------------------
---------------------------------------------PROFESSIONS--------------------------------------------
----------------------------------------------------------------------------------------------------

function addon:CharacterHasProfession(SkillLineID)
    local prof1, prof2 = GetProfessions()
    local ID1 = prof1 and select(7, GetProfessionInfo(prof1))
    local ID2 = prof2 and select(7, GetProfessionInfo(prof2))

    if (ID1 == SkillLineID or ID2 == SkillLineID) then
        return true
    end
    return false
end

local function HasTwoProfessions()
    local prof1, prof2 = GetProfessions()
    if (prof1 and prof2) then
        return true
    end
    return false
end

----------------------------------------------------------------------------------------------------
------------------------------------------------ICON------------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetIcon(point)
    local icon_key = point.icon

    if (point.picon) then
        if (private.db.picons_vendor and point.icon == "vendor") then
            icon_key = private.db.use_old_picons and point.picon.."_old" or point.picon
        end

        if (private.db.picons_trainer and point.icon == "trainer") then
            icon_key = private.db.use_old_picons and point.picon.."_old" or point.picon
        end
    end

    if (icon_key and constantsicon[icon_key]) then
        return constantsicon[icon_key]
    end
end

local function GetIconScale(icon, picon)
    -- makes the picon smaller
    if (picon ~= nil and private.db.picons_vendor and icon == "vendor") then return private.db["icon_scale_vendor"] * 0.75 end
    if (picon ~= nil and private.db.picons_trainer and icon == "trainer") then return private.db["icon_scale_trainer"] * 0.75 end
    -- anvil npcs are vendors
    if (icon == "anvil") then return private.db["icon_scale_vendor"] end

    return private.db["icon_scale_"..icon]
end

local function GetIconAlpha(icon)
    -- anvil npcs are vendors
    if (icon == "anvil") then return private.db["icon_alpha_vendor"] end

    return private.db["icon_alpha_"..icon]
end

local GetPointInfo = function(point)
    local icon
    if (point) then
        local label = GetCreatureNameByID(point.npc) or point.label or UNKNOWN
        if (point.icon == "portal" and point.quest and not IsQuestCompleted(point.quest)) then
            icon = private.constants.icon["portal_red"]
        else
            icon = SetIcon(point)
        end
        return label, icon, point.icon, point.picon, point.scale, point.alpha -- icon returns the path
    end
end

local GetPoinInfoByCoord = function(uMapID, coord)
    return GetPointInfo(private.DB.points[uMapID] and private.DB.points[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
----------------------------------------------TOOLTIP-----------------------------------------------
----------------------------------------------------------------------------------------------------

local function SetTooltip(tooltip, point)

    if (point) then
        if (point.npc) then
            local name, sublabel = GetCreatureNameByID(point.npc)
            if (name) then
                tooltip:AddLine(name)
            end
            if (sublabel) then
                tooltip:AddLine(sublabel,1,1,1)
            end
        end
        if (point.label) then
            tooltip:AddLine(point.label)
        end
        if (point.note) then
            tooltip:AddLine("("..point.note..")")
        end
        if (point.level and UnitLevel("player") < point.level) then
            tooltip:AddLine(RequiresPlayerLvl..": "..point.level, 1) -- red
        end
        if (point.quest and not IsQuestCompleted(point.quest)) then
            if (C_QuestLog.GetTitleForQuestID(point.quest) ~= nil) then
                tooltip:AddLine(RequiresQuest..": ["..C_QuestLog.GetTitleForQuestID(point.quest).."] (ID: "..point.quest..")",1,0,0)
            else
                tooltip:AddLine(RetrievingData,1,0,1) -- pink
                C_Timer.After(1, function() addon:Refresh() end) -- Refresh
                -- print("refreshed")
            end
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end

local SetTooltipByCoord = function(tooltip, uMapID, coord)
    return SetTooltip(tooltip, private.DB.points[uMapID] and private.DB.points[uMapID][coord])
end

----------------------------------------------------------------------------------------------------
-------------------------------------------PluginHandler--------------------------------------------
----------------------------------------------------------------------------------------------------

local PluginHandler = {}
local info = {}

function PluginHandler:OnEnter(uMapID, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    SetTooltipByCoord(tooltip, uMapID, coord)
end

function PluginHandler:OnLeave(uMapID, coord)
    if (self:GetParent() == WorldMapButton) then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

local function hideNode(button, uMapID, coord)
    private.hidden[uMapID][coord] = true
    addon:Refresh()
end

local function closeAllDropdowns()
    CloseDropDownMenus(1)
end

local function addTomTomWaypoint(button, uMapID, coord)
    if (IsAddOnLoaded("TomTom")) then
        local x, y = HandyNotes:getXY(coord)
        TomTom:AddWaypoint(uMapID, x, y, {
            title = GetPoinInfoByCoord(uMapID, coord),
            persistent = nil,
            minimap = true,
            world = true
        })
    end
end

local function addBlizzardWaypoint(button, uMapID, coord)
    local x, y = HandyNotes:getXY(coord)
    local parentMapID = C_Map.GetMapInfo(uMapID)["parentMapID"]
    if (not C_Map.CanSetUserWaypointOnMap(uMapID)) then
        local wx, wy = HBD:GetWorldCoordinatesFromZone(x, y, uMapID)
        uMapID = parentMapID
        x, y = HBD:GetZoneCoordinatesFromWorld(wx, wy, parentMapID)
    end

    C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(uMapID, x, y))
    C_SuperTrack.SetSuperTrackedUserWaypoint(true)
end

--------------------------------------------CONTEXT MENU--------------------------------------------

do
    local currentMapID = nil
    local currentCoord = nil
    local function generateMenu(button, level)
        if (not level) then return end
        if (level == 1) then

            -- Create the title of the menu
            UIDropDownMenu_AddButton({
                isTitle = true,
                text = L["handler_context_menu_addon_name"],
                notCheckable = true
            }, level)

            -- TomTom waypoint menu item
            if (IsAddOnLoaded("TomTom")) then
                UIDropDownMenu_AddButton({
                    text = L["handler_context_menu_add_tomtom"],
                    notCheckable = true,
                    func = addTomTomWaypoint,
                    arg1 = currentMapID,
                    arg2 = currentCoord
                }, level)
            end

            -- Blizzard waypoint menu item
            UIDropDownMenu_AddButton({
                text = L["handler_context_menu_add_map_pin"],
                notCheckable = true,
                func = addBlizzardWaypoint,
                arg1 = currentMapID,
                arg2 = currentCoord
            }, level)

            -- Hide menu item
            UIDropDownMenu_AddButton({
                text         = L["handler_context_menu_hide_node"],
                notCheckable = true,
                func         = hideNode,
                arg1         = currentMapID,
                arg2         = currentCoord
            }, level)

            -- Close menu item
            UIDropDownMenu_AddButton({
                text         = CLOSE,
                func         = closeAllDropdowns,
                notCheckable = true
            }, level)

        end
    end

    local HL_Dropdown = CreateFrame("Frame", FOLDER_NAME.."DropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function PluginHandler:OnClick(button, down, uMapID, coord)
        local TomTom = select(2, IsAddOnLoaded('TomTom'))
        local dropdown = private.db.easy_waypoint_dropdown

        if (down or button ~= "RightButton") then return end

        if (button == "RightButton" and not down and not private.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (IsControlKeyDown() and private.db.easy_waypoint) then
            currentMapID = uMapID
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        elseif (not TomTom or dropdown == 1) then
            addBlizzardWaypoint(button, uMapID, coord)
        elseif (TomTom and dropdown == 2) then
            addTomTomWaypoint(button, uMapID, coord)
        else
            addBlizzardWaypoint(button, uMapID, coord)
            if (TomTom) then addTomTomWaypoint(button, uMapID, coord) end
        end
    end
end

do

    local currentMapID = nil
    local function iter(t, prestate)
        if (not t) then return nil end
        local state, value = next(t, prestate)
        while state do
            if (value and private:ShouldShow(state, value, currentMapID)) then
                local _, icon, iconname, piconname, scale, alpha = GetPointInfo(value)
                    scale = (scale or 1) * GetIconScale(iconname, piconname)
                    alpha = (alpha or 1) * GetIconAlpha(iconname)
                return state, nil, icon, scale, alpha
            end
            state, value = next(t, state)
        end
        return nil, nil, nil, nil, nil, nil
    end
    function PluginHandler:GetNodes2(uMapID, minimap)
        currentMapID = uMapID
        return iter, private.DB.points[uMapID], nil
    end
    function private:ShouldShow(coord, point, currentMapID)
    if (not private.db.force_nodes) then
        if (private.hidden[currentMapID] and private.hidden[currentMapID][coord]) then
            return false
        end
        -- this will check if any node is for a specific class
        if (point.class and point.class ~= select(2, UnitClass("player"))) then
            return false
        end
        -- this will check if any node is for a specific faction
        if (point.faction and point.faction ~= select(1, UnitFactionGroup("player"))) then
            return false
        end
        -- this will check if any node is for a specific covenant
        if (point.covenant and point.covenant ~= C_Covenants.GetActiveCovenantID()) then
            return false
        end
        -- this will check if the node is for a specific profession
        if (point.profession and (not addon:CharacterHasProfession(point.profession) and HasTwoProfessions()) and private.db.show_onlymytrainers and not point.auctioneer) then
            return false
        end
        if (point.icon == "auctioneer" and not private.db.show_auctioneer) then return false end
        if (point.icon == "banker" and not private.db.show_banker) then return false end
        if (point.icon == "barber" and not private.db.show_barber) then return false end
        if (point.icon == "bubble" and not private.db.show_bubble) then return false end
        if (point.icon == "flightmaster" and not private.db.show_flightmaster) then return false end
        if (point.icon == "greatvault" and not private.db.show_greatvault) then return false end
        if (point.icon == "guildvault" and not private.db.show_guildvault) then return false end
        if (point.icon == "innkeeper" and not private.db.show_innkeeper) then return false end
        if (point.icon == "mail" and not private.db.show_mail) then return false end
        if (point.icon == "portal" and (not private.db.show_portal or IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false end
        if (point.icon == "reforge" and not private.db.show_reforge) then return false end
        if (point.icon == "rostrum" and not private.db.show_rostrum) then return false end
        if (point.icon == "stablemaster" and not private.db.show_stablemaster) then return false end
        if (point.icon == "trainer" and not private.db.show_trainer) then return false end
        if (point.icon == "portaltrainer" and not private.db.show_portaltrainer) then return false end
        if (point.icon == "transmogrifier" and not private.db.show_transmogrifier) then return false end
        if (point.icon == "tpplatform" and (not private.db.show_tpplatform or IsAddOnLoaded("HandyNotes_TravelGuide"))) then return false end
        if ((point.icon == "vendor" or point.icon == "anvil") and not private.db.show_vendor) then return false end
        if (point.icon == "void" and not private.db.show_void) then return false end
    end
        return true
    end
end

---------------------------------------------------------------------------------------------------
----------------------------------------------REGISTER---------------------------------------------
---------------------------------------------------------------------------------------------------

function addon:OnInitialize()
    self.db = AceDB:New(FOLDER_NAME.."DB", private.constants.defaults)

    profile = self.db.profile
    private.db = profile

    global = self.db.global
    private.global = global

    private.hidden = self.db.char.hidden

    if (private.global.dev) then
        private.devmode()
    end

    -- Initialize database with HandyNotes
    HandyNotes:RegisterPluginDB(addon.pluginName, PluginHandler, private.config.options)
end

function addon:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", addon.pluginName)
end

function addon:OnEnable()
end

----------------------------------------------EVENTS-----------------------------------------------

local frame, events = CreateFrame("Frame"), {};

function events:ZONE_CHANGED(...)
    addon:Refresh()

    if (C_Map.GetBestMapForUnit("player") == nil) then
        -- occurs during the Shadowlands introduction quest chain in ICC.
        addon:debugmsg("MapID is nil")
        return
    end

    addon:debugmsg("refreshed after ZONE_CHANGED")
    addon:debugmsg("MapID: "..C_Map.GetBestMapForUnit("player"))

end

function events:ZONE_CHANGED_INDOORS(...)
    addon:Refresh()

    addon:debugmsg("refreshed after ZONE_CHANGED_INDOORS")

end

function events:QUEST_FINISHED(...)
    addon:Refresh()

    addon:debugmsg("refreshed after QUEST_FINISHED")
end

function events:SKILL_LINES_CHANGED(...)
    addon:Refresh()

    addon:debugmsg("refreshed after SKILL_LINES_CHANGED")
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end