---------------------------------------------------------------------------------------------------
-- EquipColor
-- Version: 1.0
---------------------------------------------------------------------------------------------------
--///////////////////////////////////////////////////////////////////////////////////////////////--
---------------------------------------------------------------------------------------------------
EquipColor = AceLibrary("AceAddon-2.0"):new("AceHook-2.1") -- hooking mixin
---------------------------------------------------------------------------------------------------
function EquipColor:OnInitialize()
    --Player Bags
    self:HookScript(ContainerFrame1, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame2, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame3, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame4, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame5, "OnShow", "BagFrame_OnShow")
    --Player Bank Bags
    self:HookScript(ContainerFrame6, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame7, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame8, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame9, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame10, "OnShow", "BagFrame_OnShow")
    self:HookScript(ContainerFrame11, "OnShow", "BagFrame_OnShow")
    --Player Keyring Bag
    self:HookScript(ContainerFrame12, "OnShow", "BagFrame_OnShow")
    --Player Main Bank
    self:HookScript(BankFrameItem1, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem2, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem3, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem4, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem5, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem6, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem7, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem8, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem9, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem10, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem11, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem12, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem13, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem14, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem15, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem16, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem17, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem18, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem19, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem20, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem21, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem22, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem23, "OnShow", "BankFrame_OnShow")
    self:HookScript(BankFrameItem24, "OnShow", "BankFrame_OnShow")
    self.slotsToColor = {}
    self.BagFrames = {}
    self.BagFrames = {
        ContainerFrame1,
        ContainerFrame2,
        ContainerFrame3,
        ContainerFrame4,
        ContainerFrame5,
        ContainerFrame6,
        ContainerFrame7,
        ContainerFrame8,
        ContainerFrame9,
        ContainerFrame10,
        ContainerFrame11,
        ContainerFrame12
    }
end
---------------------------------------------------------------------------------------------------
-- OnShow Functions
---------------------------------------------------------------------------------------------------
function EquipColor:BagFrame_OnShow(frame)
    --if (frame ~= nil) then
    --    EquipColor_BMsg("Bag: "..frame:GetID())
    --end
    self:ColorUnusableItemsInBag(frame:GetID())
    return self.hooks[frame].OnShow(frame)
end
---------------------------------------------------------------------------------------------------
function EquipColor:BankFrame_OnShow(frame)
    --if (frame ~= nil) then
    --    EquipColor_BMsg("Bank Slot: "..frame:GetID())
    --end
    self:ColorUnusableBankItemsInSlot(frame:GetID())
    return self.hooks[frame].OnShow(frame)
end
---------------------------------------------------------------------------------------------------
-- OnEvent
---------------------------------------------------------------------------------------------------
function EquipColor_OnEvent(this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)

    --if event then EquipColor_BMsg("EquipColor_OnEvent: event ["..event.."]") end
    --if arg1 then EquipColor_BMsg("EquipColor_OnEvent: arg1 ["..arg1.."]") end

    -- OneBag Support
    if (OneCore ~= nil) then
        if (arg1 == "LeftButton") or (arg1 == "RightButton") then
            EquipColor_changedFrames = EquipColor_changedFrames + 1
        end
        if (not EquipColor:IsHooked(OneCore.modulePrototype, "SetBorderColor")) then
            EquipColor:SecureHook(OneCore.modulePrototype, "SetBorderColor", "AddOnCore_SetItemColors")
        end
        if (not EquipColor:IsHooked(OneCore.modulePrototype, "UpdateBag")) then
            EquipColor:SecureHook(OneCore.modulePrototype, "UpdateBag", "AddOnCore_ContainerFrame_Update")
        end
    end

    -- Bagnon Support
    if (IsAddOnLoaded("Bagnon_Core")) then
        if (arg1 == "LeftButton") or (arg1 == "RightButton") then
            EquipColor_changedFrames = EquipColor_changedFrames + 1
        end
        if (not EquipColor:IsHooked("BagnonItem_UpdateBorder")) then
            EquipColor:SecureHook("BagnonItem_UpdateBorder", "AddOnCore_SetItemColors")
        end
        if (not EquipColor:IsHooked("BagnonFrame_Update")) then
            EquipColor:SecureHook("BagnonFrame_Update", "AddOnCore_ContainerFrame_Update")
        end
    end

    -- Standard Events
    if (event == "MAIL_INBOX_UPDATE") then
        EquipColor:ColorUnusableMailItemsInSlot()
    elseif (event == "BAG_UPDATE" or event == "ITEM_LOCK_CHANGED" or event == "BAG_UPDATE_COOLDOWN" or event == "UPDATE_INVENTORY_ALERTS") then
        if EquipColor.BagFrames[1].bagsShown > 1 then
            EquipColor:ColorUnusableItems()
        end
        if BankFrame:IsVisible() then
            EquipColor:ColorUnusableBankItems()
        end
        EquipColor:AddOnCore_ContainerFrame_Update()
    elseif (event == "PLAYERBANKSLOTS_CHANGED" or event == "BANKFRAME_OPENED") then
        EquipColor:ColorUnusableBankItems()
    end
end
---------------------------------------------------------------------------------------------------
-- OnUpdate
---------------------------------------------------------------------------------------------------
EquipColor_checkFrames = 1
EquipColor_changedFrames = 1
function EquipColor_OnUpdate(arg1)
    EquipColor_checkFrames = table.getn(EquipColor.slotsToColor)
    if EquipColor_checkFrames ~= EquipColor_changedFrames then
        --EquipColor_BMsg("EquipColor_OnUpdate: Fired!")
        EquipColor:AddOnCore_ContainerFrame_Update()
        EquipColor_changedFrames = table.getn(EquipColor.slotsToColor)
    end
end
---------------------------------------------------------------------------------------------------
-- OnLoad
---------------------------------------------------------------------------------------------------
function EquipColor_OnLoad()
    this:RegisterEvent("BAG_UPDATE")
    this:RegisterEvent("ITEM_LOCK_CHANGED")
    this:RegisterEvent("BAG_UPDATE_COOLDOWN")
    this:RegisterEvent("UPDATE_INVENTORY_ALERTS")
    this:RegisterEvent("BANKFRAME_OPENED")
    this:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
    this:RegisterEvent("MAIL_INBOX_UPDATE")
end
---------------------------------------------------------------------------------------------------
-- Debug Parser
---------------------------------------------------------------------------------------------------
function EquipColor_BMsg(msg)
    ChatFrame1:AddMessage(msg or 'nil', 0,1,0.4)
end
---------------------------------------------------------------------------------------------------
-- Item Link Parser
---------------------------------------------------------------------------------------------------
local function GetFromLink(link)
    local id = -1
    local name = "Unknown"
    if (link ~= nil) then
        for i, n in string.gfind(link, "|c%x+|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r") do
            if (i ~= nil) then id = i end
            if (n ~= nil) then name = n end
        end
    end
    return id, name
end
---------------------------------------------------------------------------------------------------
-- Frame Name Parser
---------------------------------------------------------------------------------------------------
function GetContainerFrameName(id)
    if (ContainerFrame1:GetID() == id) then return "ContainerFrame1" end
    if (ContainerFrame2:GetID() == id) then return "ContainerFrame2" end
    if (ContainerFrame3:GetID() == id) then return "ContainerFrame3" end
    if (ContainerFrame4:GetID() == id) then return "ContainerFrame4" end
    if (ContainerFrame5:GetID() == id) then return "ContainerFrame5" end
    if (ContainerFrame6:GetID() == id) then return "ContainerFrame6" end
    if (ContainerFrame7:GetID() == id) then return "ContainerFrame7" end
    if (ContainerFrame8:GetID() == id) then return "ContainerFrame8" end
    if (ContainerFrame9:GetID() == id) then return "ContainerFrame9" end
    if (ContainerFrame10:GetID() == id) then return "ContainerFrame10" end
    if (ContainerFrame11:GetID() == id) then return "ContainerFrame11" end
    if (ContainerFrame12:GetID() == id) then return "ContainerFrame12" end
    return nil
end
---------------------------------------------------------------------------------------------------
-- Inventory ID's are different from SlotID's, so we need a translator to properly parse bank
-- slot item tooltips. Otherwise, we can't read the tooltips to find out if it's usable.
---------------------------------------------------------------------------------------------------
local function GetBankFrameInventorySlot(slot)
    if (BankFrameItem1:GetID() == slot) then return 40 end
    if (BankFrameItem2:GetID() == slot) then return 41 end
    if (BankFrameItem3:GetID() == slot) then return 42 end
    if (BankFrameItem4:GetID() == slot) then return 43 end
    if (BankFrameItem5:GetID() == slot) then return 44 end
    if (BankFrameItem6:GetID() == slot) then return 45 end
    if (BankFrameItem7:GetID() == slot) then return 46 end
    if (BankFrameItem8:GetID() == slot) then return 47 end
    if (BankFrameItem9:GetID() == slot) then return 48 end
    if (BankFrameItem10:GetID() == slot) then return 49 end
    if (BankFrameItem11:GetID() == slot) then return 50 end
    if (BankFrameItem12:GetID() == slot) then return 51 end
    if (BankFrameItem13:GetID() == slot) then return 52 end
    if (BankFrameItem14:GetID() == slot) then return 53 end
    if (BankFrameItem15:GetID() == slot) then return 54 end
    if (BankFrameItem16:GetID() == slot) then return 55 end
    if (BankFrameItem17:GetID() == slot) then return 56 end
    if (BankFrameItem18:GetID() == slot) then return 57 end
    if (BankFrameItem19:GetID() == slot) then return 58 end
    if (BankFrameItem20:GetID() == slot) then return 59 end
    if (BankFrameItem21:GetID() == slot) then return 60 end
    if (BankFrameItem22:GetID() == slot) then return 61 end
    if (BankFrameItem23:GetID() == slot) then return 62 end
    if (BankFrameItem24:GetID() == slot) then return 63 end
    return nil
end
---------------------------------------------------------------------------------------------------
-- Parses Recipe and Trinket tooltips from the players bags or bank slots. This is done
-- automatically without the player having to hover over an item manually.
---------------------------------------------------------------------------------------------------
local function CheckItemTooltip(bag, slot, itemtype)
    EquipColor_ScanTooltip:ClearLines()
    if (bag == -1) then
        EquipColor_ScanTooltip:SetInventoryItem("player", GetBankFrameInventorySlot(slot))
    elseif (bag == "MailBox") then
        EquipColor_ScanTooltip:SetInboxItem(slot)
    else
        EquipColor_ScanTooltip:SetBagItem(bag, slot)
    end
    if (itemtype == "Weapon") then
        local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft2'):GetText()
        if EquipColor_Tooltip then
            --EquipColor_BMsg("CheckItemTooltip: Weapon_Tooltip ["..EquipColor_Tooltip.."]")
            local _, _, offHand = string.find(EquipColor_Tooltip, "(Off Hand)")
            if (offHand == "Off Hand") then
                return true
            else
                return false
            end
        end
    elseif (itemtype == "ClassArmor") then
        for ClassArmor = 7, 12 do
            local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft'..ClassArmor):GetText()
            if EquipColor_Tooltip then
                --EquipColor_BMsg("CheckItemTooltip: Armor_Tooltip ["..EquipColor_Tooltip.."]")
                local _, _, Classes, ClassReq = string.find(EquipColor_Tooltip, "(Classes)%: (.+)")
                if Classes then
                    if ClassReq then
                        if ClassReq == UnitClass("player") then
                            --EquipColor_BMsg("CheckItemTooltip(True): ClassReq ["..ClassReq.."]")
                            return true
                        else
                            --EquipColor_BMsg("CheckItemTooltip(False): ClassReq ["..ClassReq.."]")
                            return false
                        end
                    end
                end
            end
        end
    elseif (itemtype == "Learned") then
        local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft3'):GetText()
        if EquipColor_Tooltip then
            --EquipColor_BMsg("CheckItemTooltip: Learned_Tooltip ["..EquipColor_Tooltip.."]")
            local _, _, hasLearned = string.find(EquipColor_Tooltip, "(Already known)")
            if (hasLearned == "Already known") then
                return true
            else
                return false
            end
        end
    elseif (itemtype == "Recipe") then
        local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft2'):GetText()
        if EquipColor_Tooltip then
            --EquipColor_BMsg("CheckItemTooltip: Recipe_Tooltip ["..EquipColor_Tooltip.."]")
            local _, _, profName, profLevel = string.find(EquipColor_Tooltip, "Requires (.+) %((%d+)%)")
            if (profName and profLevel) then
                --EquipColor_BMsg("CheckItemTooltip: profName ["..profName.."] profLevel ["..profLevel.."]")
                return profName, profLevel
            else
                return false
            end
        end
    elseif (itemtype == "INVTYPE_TRINKET") then
        local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft5'):GetText()
        if EquipColor_Tooltip then
            --EquipColor_BMsg("CheckItemTooltip: Trinket_Tooltip ["..EquipColor_Tooltip.."]")
            local _, _, class = string.find(EquipColor_Tooltip, "Classes%: (.+)")
            --EquipColor_BMsg("CheckItemTooltip: class ["..class.."]")
            if (not class) then
                return true
            elseif (class == UnitClass("player")) then
                return true
            else
                return false
            end
        end
    else
        return false
    end
end
---------------------------------------------------------------------------------------------------
-- Parses weapons and checks the players skill sheet. Passing a 'skill' is required but passing a
-- 'rank' is optional. Returns skill or skill and rank or false.
---------------------------------------------------------------------------------------------------
function CheckCharacterSkills(skill, rank)
    local retSubclass = skill
    if (retSubclass == "One-Handed Axes") then
        skill = "Axes"
    elseif (retSubclass == "One-Handed Maces") then
        skill = "Maces"
    elseif (retSubclass == "One-Handed Swords") then
        skill = "Swords"
    elseif (retSubclass == "Shields") then
        skill = "Shield"
    elseif (retSubclass == "Pole Arms") then
        skill = "Polearms"
    elseif (retSubclass == "Plate") then
        skill = "Plate Mail"
    elseif (retSubclass == "Fishing Pole") then
        skill = "Fishing"
    elseif (retSubclass == "Fist Weapons") then
        skill = "Fist"
    end
    for skillIndex=1, GetNumSkillLines() do
        local skillName, isHeader, _, skillRank = GetSkillLineInfo(skillIndex)
        if (not isHeader) then
            if (skill == skillName and rank) then
                --EquipColor_BMsg("CheckCharacterSkills: skillName ["..skillName.."] skill ["..skill.."] skillRank ["..skillRank.."]")
                return skill, skillRank
            elseif (skill == skillName) then
                --EquipColor_BMsg("CheckCharacterSkills: skillName ["..skillName.."] skill ["..skill.."]")
                return skill
            elseif (skill == "Fist") then
                if UnitClass("Player") == "Rogue" or UnitClass("Player") == "Druid" or UnitClass("Player") == "Warrior" or UnitClass("Player") == "Shaman" or UnitClass("Player") == "Hunter" then
                    --EquipColor_BMsg("CheckCharacterSkills: Your character is able to wield Fist Weapons but there is no REAL check for it. Might have to still train the skill.")
                    return true
                end
            end
        end
    end
    return false
end
---------------------------------------------------------------------------------------------------
-- Checks the players spell box for a spell and returns true or false.
---------------------------------------------------------------------------------------------------
function CheckCharacterSpells(spell)
    local i = 1
    while true do
        local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
        if not spellName then
            do break end
        end
        if (spell == spellName) then
            --EquipColor_BMsg("CheckCharacterSpells: spellName ["..spellName.." (".. spellRank..")]")
            return true
        end
        i = i + 1
    end
    return false
end
---------------------------------------------------------------------------------------------------
-- AddOn compatibility functions. Currently supports Bagnon and OneBag: When ever an Hooked AddOn
-- fucntion is called this is called after it to re-color the slots we want to show up.
---------------------------------------------------------------------------------------------------
function EquipColor:AddOnCore_ContainerFrame_Update(object)
    --EquipColor_BMsg("AddOnCore_ContainerFrame_Update: Fired!")
    for k,v in pairs(self.slotsToColor) do
        if (self.slotsToColor[k] ~= nil) then
            local _, _, Learned = string.find(self.slotsToColor[k], (".+%d+(Learned)"))
            if Learned then
                local _, _, LearnedSlot = string.find(self.slotsToColor[k], ("(.+%d+)Learned"))
                SetItemButtonTextureVertexColor(getglobal(LearnedSlot), 0, 1, 1)
            else
                SetItemButtonTextureVertexColor(getglobal(self.slotsToColor[k]), 1, 0, 0)
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Certain Hooked Functions will trigger a DB clear to keep the table from getting too big.
---------------------------------------------------------------------------------------------------
function EquipColor:AddOnCore_ClearContainerFrameTable(slot)
    for k,v in pairs(EquipColor.slotsToColor) do
        if v == slot then
            EquipColor.slotsToColor[k] = nil
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Core function for AddOn compatibility.
---------------------------------------------------------------------------------------------------
function EquipColor:AddOnCore_SetItemColors(object, slot)
    if slot == nil then slot = object end
    EquipColor:AddOnCore_ClearContainerFrameTable(slot:GetName())
    local bag = slot:GetParent()
    local itemid, name = GetFromLink(GetContainerItemLink(bag:GetID(), slot:GetID()))
    --EquipColor_BMsg("SetItemColors: bag ["..bag:GetID().."] slot ["..slot:GetID().."]")
    if (itemid ~= -1 and name ~= "Unknown") then
        local itemname, _, _, itemminlevel, itemclass, itemsubclass, _, itemEquipLoc = GetItemInfo(itemid)
        if (itemclass ~= nil and itemsubclass ~= nil) then
            --EquipColor_BMsg("SetItemColors(Items): ItemName ["..itemname.."] ItemID ["..itemid.."]")
            if (itemminlevel > UnitLevel("player")) then
                table.insert(self.slotsToColor, slot:GetName())
                --EquipColor_BMsg("SetItemColors(AllItems-LevelCheck): Name ["..itemname.."] ID ["..itemid.."] SubClass ["..itemsubclass.."]")
            elseif ((itemclass == "Weapon" or itemclass == "Armor") and itemsubclass ~= "Miscellaneous") then
                if (itemclass == "Armor") then
                    if CheckItemTooltip(bag:GetID(), slot:GetID(), "ClassArmor") == false then
                        table.insert(self.slotsToColor, slot:GetName())
                        --EquipColor_BMsg("SetItemColors(ClassArmor): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]")
                    end
                elseif (CheckCharacterSkills(itemsubclass) == false) then
                    table.insert(self.slotsToColor, slot:GetName())
                    --EquipColor_BMsg("SetItemColors(Weapons&Armor): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]")
                elseif (CheckCharacterSpells("Dual Wield") == false) then
                    if (CheckItemTooltip(bag:GetID(), slot:GetID(), itemclass) == true) then
                        table.insert(self.slotsToColor, slot:GetName())
                        --EquipColor_BMsg("SetItemColors(Weapon-Off Hand): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]")
                    end
                end
            elseif (itemclass == "Projectile" or itemclass == "Quiver")then
                if (CheckCharacterSkills("Bows") == false and CheckCharacterSkills("Crossbows") == false) then
                    if (itemsubclass == "Arrow" or itemsubclass == "Quiver") then
                        table.insert(self.slotsToColor, slot:GetName())
                        --EquipColor_BMsg("SetItemColors(Arrows&Quivers): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]")
                    end
                end
                if (CheckCharacterSkills("Guns") == false) then
                    if (itemsubclass == "Bullet" or itemsubclass == "Ammo Pouch") then
                        table.insert(self.slotsToColor, slot:GetName())
                        --EquipColor_BMsg("SetItemColors(Bullets&Pouches): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]")
                    end
                end
            elseif (itemclass == "Recipe") then
                local profName, profLevel = CheckItemTooltip(bag:GetID(), slot:GetID(), itemclass)
                if (profName and profLevel) then
                    if (CheckCharacterSkills(profName) == false) then
                        table.insert(self.slotsToColor, slot:GetName())
                        --EquipColor_BMsg("SetItemColors(Recipes-ProfCheck):  Name ["..itemname.."] profName ["..profName.."] profLevel ["..profLevel.."]")
                    else
                        local skillName, skillRank = CheckCharacterSkills(profName, true)
                        if (tonumber(profLevel) > skillRank) then
                            table.insert(self.slotsToColor, slot:GetName())
                            --EquipColor_BMsg("SetItemColors(Recipes-SkillLevel):  Name ["..itemname.."] profName ["..profName.."] profLevel ["..profLevel.."]")
                        end
                    end
                end
                local hasLearned = CheckItemTooltip(bag:GetID(), slot:GetID(), "Learned")
                if (hasLearned) then
                    table.insert(self.slotsToColor, slot:GetName().."Learned")
                    --EquipColor_BMsg("SetItemColors(Recipes-Learned): Name ["..itemname.."] Player has already learned recipe")
                end
            elseif (itemEquipLoc == "INVTYPE_TRINKET") then
                if (CheckItemTooltip(bag:GetID(), slot:GetID(), itemEquipLoc) == false) then
                    table.insert(self.slotsToColor, slot:GetName())
                    --EquipColor_BMsg("SetItemColors(Trinkets-ClassCheck):  Name ["..itemname.."] itemEquipLoc ["..itemEquipLoc.."]")
                end
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Main EquipColor Core Function. This is called by all core functions below it.
---------------------------------------------------------------------------------------------------
function EquipColor:ColorItems(bag, slot, itemFrame, frame)
    local itemid, name = GetFromLink(GetContainerItemLink(bag, slot))
    if (itemid ~= -1 and name ~= "Unknown") then
        local itemname, _, _, itemminlevel, itemclass, itemsubclass, _, itemEquipLoc = GetItemInfo(itemid)
        if (itemFrame ~= nil and itemFrame:IsVisible() and itemclass ~= nil and itemsubclass ~= nil) then
            --if frame ~= nil then EquipColor_BMsg("ColorItems(Items): ItemName ["..itemname.."] ItemID ["..itemid.."]") end
            if (itemminlevel > UnitLevel("player")) then
                SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                if frame ~= nil then EquipColor_BMsg("ColorItems(AllItems-LevelCheck): Name ["..itemname.."] ID ["..itemid.."] SubClass ["..itemsubclass.."]") end
            elseif ((itemclass == "Weapon" or itemclass == "Armor") and itemsubclass ~= "Miscellaneous") then
                if (itemclass == "Armor") then
                    if CheckItemTooltip(bag, slot, "ClassArmor") == false then
                        SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                        if frame ~= nil then EquipColor_BMsg("SetItemColors(ClassArmor): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]") end
                    end
                elseif (CheckCharacterSkills(itemsubclass) == false) then
                    SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                    if frame ~= nil then EquipColor_BMsg("ColorItems(Weapons&Armor): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]") end
                elseif (CheckCharacterSpells("Dual Wield") == false) then
                    if (CheckItemTooltip(bag, slot, itemclass) == true) then
                        SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                        if frame ~= nil then EquipColor_BMsg("ColorItems(Weapon-Off Hand): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]") end
                    end
                end
            elseif (itemclass == "Projectile" or itemclass == "Quiver")then
                if (CheckCharacterSkills("Bows") == false and CheckCharacterSkills("Crossbows") == false) then
                    if (itemsubclass == "Arrow" or itemsubclass == "Quiver") then
                        SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                        if frame ~= nil then EquipColor_BMsg("ColorItems(Arrows&Quivers): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]") end
                    end
                end
                if (CheckCharacterSkills("Guns") == false) then
                    if (itemsubclass == "Bullet" or itemsubclass == "Ammo Pouch") then
                        SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                        if frame ~= nil then EquipColor_BMsg("ColorItems(Bullets&Pouches): Name ["..itemname.."] ID ["..itemid.."] subclass ["..itemsubclass.."]") end
                    end
                end
            elseif (itemclass == "Recipe") then
                local profName, profLevel = CheckItemTooltip(bag, slot, itemclass)
                if (profName and profLevel) then
                    if (CheckCharacterSkills(profName) == false) then
                        SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                        if frame ~= nil then EquipColor_BMsg("ColorItems(Recipes-ProfCheck):  Name ["..itemname.."] profName ["..profName.."] profLevel ["..profLevel.."]") end
                    else
                        local skillName, skillRank = CheckCharacterSkills(profName, true)
                        if (tonumber(profLevel) > skillRank) then
                            SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                            if frame ~= nil then EquipColor_BMsg("ColorItems(Recipes-SkillLevel):  Name ["..itemname.."] profName ["..profName.."] profLevel ["..profLevel.."]") end
                        end
                    end
                end
                local hasLearned = CheckItemTooltip(bag, slot, "Learned")
                if (hasLearned) then
                    SetItemButtonTextureVertexColor(itemFrame, 0, 1, 1)
                    if frame ~= nil then EquipColor_BMsg("ColorItems(Recipes-Learned): Name ["..itemname.."] Player has already learned recipe") end
                end
            elseif (itemEquipLoc == "INVTYPE_TRINKET") then
                if (CheckItemTooltip(bag:GetID(), slot:GetID(), itemEquipLoc) == false) then
                    SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
                    if frame ~= nil then EquipColor_BMsg("ColorItems(Trinkets-ClassCheck):  Name ["..itemname.."] itemEquipLoc ["..itemEquipLoc.."]") end
                end
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Called by the Bag OnEvent handler to update all bags and slots.
---------------------------------------------------------------------------------------------------
function EquipColor:ColorUnusableItems()
    for bag = 0, 12 do
        for slot = 1, GetContainerNumSlots(bag) do
            local bagName = GetContainerFrameName(bag)
            if bagName == nil then return end
            local itemFrame = getglobal(bagName.."Item"..(GetContainerNumSlots(bag)-(slot-1)))
            EquipColor:ColorItems(bag, slot, itemFrame, nil) --"ColorUnusableItems")
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Called by the Bag OnShow hooks handler. Updates the toggled bag.
---------------------------------------------------------------------------------------------------
function EquipColor:ColorUnusableItemsInBag(bag)
    for slot = 1, GetContainerNumSlots(bag) do
        local bagName = GetContainerFrameName(bag)
        if bagName == nil then return end
        local itemFrame = getglobal(bagName.."Item"..(GetContainerNumSlots(bag)-(slot-1)))
        EquipColor:ColorItems(bag, slot, itemFrame, nil) --"ColorUnusableItemsInBag")
    end
end
---------------------------------------------------------------------------------------------------
-- Called by the Bank OnEvent handler to update all visible Bank bags and slots.
---------------------------------------------------------------------------------------------------
function EquipColor:ColorUnusableBankItems()
    local bag = BANK_CONTAINER
    for slot = 1, GetContainerNumSlots(bag) do
        local itemFrame = getglobal("BankFrameItem"..slot)
        EquipColor:ColorItems(bag, slot, itemFrame, nil) --"ColorUnusableBankItems")
    end
end
---------------------------------------------------------------------------------------------------
-- Called by the Bank OnShow handler. Updates the main bank frame and each toggled bag.
---------------------------------------------------------------------------------------------------
function EquipColor:ColorUnusableBankItemsInSlot(slot)
    local bag = BANK_CONTAINER
    local itemFrame = getglobal("BankFrameItem"..slot)
    EquipColor:ColorItems(bag, slot, itemFrame, nil) --"ColorUnusableBankItemsInSlot")
end
---------------------------------------------------------------------------------------------------
-- Called by the Mail OnShow handler.
---------------------------------------------------------------------------------------------------
function EquipColor:ColorUnusableMailItemsInSlot()
    if MailFrame:IsVisible() then
        local numItems = GetInboxNumItems()
        for i=1, numItems do
            if ( numItems >= 1 ) then
                local name, _, _, _, canUse = GetInboxItem(i)
                local packageIcon, _, _, money, _, _, _, hasItem, _, _, _, _, _ = GetInboxHeaderInfo(i)
                local hasLearned = CheckItemTooltip("MailBox", i, "Learned")
                if canUse and hasItem and hasLearned then
                    SetDesaturation(getglobal("MailItem"..i.."ButtonIcon"),nil)
                    getglobal("MailItem"..i.."ButtonIcon"):SetVertexColor(0, 1, 1)
                    SetDesaturation(getglobal("MailItem"..i.."ButtonIcon"),nil)
                    --EquipColor_BMsg("ColorUnusableMailItemsInSlot: Player has already learned recipe")
                elseif canUse and hasItem then
                    --EquipColor_BMsg("ColorUnusableMailItemsInSlot: Can use item ["..i.."]")
                elseif hasItem then
                    SetDesaturation(getglobal("MailItem"..i.."ButtonIcon"),nil)
                    getglobal("MailItem"..i.."ButtonIcon"):SetVertexColor(1, 0, 0)
                    SetDesaturation(getglobal("MailItem"..i.."ButtonIcon"),nil)
                    --EquipColor_BMsg("ColorUnusableMailItemsInSlot: Can't use item ["..i.."]")
                end
            end
        end
    end
end
