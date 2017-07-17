--- Please read the .toc file included with this addon for information on the addon.
EquipColor = AceLibrary("AceAddon-2.0"):new("AceHook-2.1") --- Addon hooks to Ace2.

function EquipColor:OnInitialize()
--- Player Bags.
	self:HookScript(ContainerFrame1, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame2, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame3, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame4, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame5, "OnShow", "BagFrame_OnShow")
--- Player Bank Bags.
	self:HookScript(ContainerFrame6, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame7, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame8, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame9, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame10, "OnShow", "BagFrame_OnShow")
	self:HookScript(ContainerFrame11, "OnShow", "BagFrame_OnShow")
--- Player Keyring Bag.
	self:HookScript(ContainerFrame12, "OnShow", "BagFrame_OnShow")
--- Player Main Bank.
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
--- OnShow Functions.
function EquipColor:BagFrame_OnShow(frame)
	--if frame ~= nil then
	--	EquipColor_BMsg("Bag: " .. frame:GetID())
	--end
	self:ColorUnusableItemsInBag(frame:GetID())
	return self.hooks[frame].OnShow(frame)
end

function EquipColor:BankFrame_OnShow(frame)
	--if frame ~= nil then
	--	EquipColor_BMsg("Bank Slot: " .. frame:GetID())
	--end
	self:ColorUnusableBankItemsInSlot(frame:GetID())
	return self.hooks[frame].OnShow(frame)
end
--- OnEvent.
function EquipColor_OnEvent(this, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
	--if event then EquipColor_BMsg("EquipColor_OnEvent: event [" .. event .. "]") end
	--if arg1 then EquipColor_BMsg("EquipColor_OnEvent: arg1 [" .. arg1 .. "]") end

--- Default WoW Client: MerchantFrame Hook.
	if not EquipColor:IsHooked("MerchantFrame_Update") then
		EquipColor:SecureHook("MerchantFrame_Update", "ColorUnusableMerchantItems")
	end
--- AllInOneInventory: Standard Events.
	if IsAddOnLoaded("AllInOneInventory") then
		if arg1 == "LeftButton" or arg1 == "RightButton" then
			EquipColor_changedFrames = EquipColor_changedFrames + 1
		end
		if not EquipColor:IsHooked("AllInOneInventoryFrame_UpdateButton") then
			EquipColor:SecureHook("AllInOneInventoryFrame_UpdateButton", "AddOnCore_SetAddon")
		end
		if not EquipColor:IsHooked("AIOBFrame_UpdateCooldown") then
			EquipColor:SecureHook("AIOBFrame_UpdateCooldown", "AddOnCore_SetAddon")
		end
	end
--- Bagnon: Standard Events.
	if IsAddOnLoaded("Bagnon_Core") then
		if arg1 == "LeftButton" or arg1 == "RightButton" then
			EquipColor_changedFrames = EquipColor_changedFrames + 1
		end
		if not EquipColor:IsHooked("BagnonItem_UpdateBorder") then
			EquipColor:SecureHook("BagnonItem_UpdateBorder", "AddOnCore_SetAddon")
		end
		if not EquipColor:IsHooked("BagnonFrame_Update") then
			EquipColor:SecureHook("BagnonFrame_Update", "AddOnCore_ContainerFrame_Update")
		end
	end
--- EngInventory: Standard Events.
	if IsAddOnLoaded("EngBags") then
		if arg1 == "LeftButton" or (arg1 == "RightButton") then
			EquipColor_changedFrames = EquipColor_changedFrames + 1
		end
		if not EquipColor:IsHooked("EngInventory_UpdateButton") then
			EquipColor:SecureHook("EngInventory_UpdateButton", "AddOnCore_SetAddon")
		end
		if not EquipColor:IsHooked("EngBank_UpdateButton") then
			EquipColor:SecureHook("EngBank_UpdateButton", "AddOnCore_SetAddon")
		end
		if event == "ITEM_LOCK_CHANGED" then
			EngInventory_UpdateWindow()
		end
	end
--- OneBag: Standard Events.
	if (OneCore ~= nil) then
		if arg1 == "LeftButton" or arg1 == "RightButton" then
			EquipColor_changedFrames = EquipColor_changedFrames + 1
		end
		if not EquipColor:IsHooked(OneCore.modulePrototype, "SetBorderColor") then
			EquipColor:SecureHook(OneCore.modulePrototype, "SetBorderColor", "AddOnCore_SetAddon")
		end
		if not EquipColor:IsHooked(OneCore.modulePrototype, "UpdateBag") then
			EquipColor:SecureHook(OneCore.modulePrototype, "UpdateBag", "AddOnCore_ContainerFrame_Update")
		end
	end
--- SUCC-bag: Standard Events.
	if IsAddOnLoaded("SUCC-bag") then
		if arg1 == "LeftButton" or arg1 == "RightButton" then
			EquipColor_changedFrames = EquipColor_changedFrames + 1
		end
		if not EquipColor:IsHooked("FrameUpdate") then
			EquipColor:SecureHook("FrameUpdate", "AddOnCore_SetAddon")
		end
		if not EquipColor:IsHooked("SBFrameOpen") then
			EquipColor:SecureHook("SBFrameOpen", "AddOnCore_SetAddon")
		end
	end
--- Default WoW Client: Standard Events.
	if not IsAddOnLoaded("Bagnon_Core") and OneCore ~= nil and IsAddOnLoaded("EngBags") then
		if arg1 == "LeftButton" or arg1 == "RightButton" then
			if EquipColor.BagFrames[1].bagsShown > 0 then
				EquipColor:ColorUnusableItems()
			end
			if BankFrame:IsVisible() then
				EquipColor:ColorUnusableBankItems()
			end
		end
	end
	if event == "MAIL_INBOX_UPDATE" then
		EquipColor:ColorUnusableMailItemsInSlot()
	elseif event == "BAG_UPDATE" or event == "ITEM_LOCK_CHANGED" or event == "BAG_UPDATE_COOLDOWN"
			or event == "UPDATE_INVENTORY_ALERTS" then
		if EquipColor.BagFrames[1].bagsShown > 0 then
			EquipColor:ColorUnusableItems()
		end
		if BankFrame:IsVisible() then
			EquipColor:ColorUnusableBankItems()
		end
		EquipColor:AddOnCore_ContainerFrame_Update()
	elseif event == "PLAYERBANKSLOTS_CHANGED" or event == "BANKFRAME_OPENED" then
		if EquipColor.BagFrames[1].bagsShown > 0 then
			EquipColor:ColorUnusableItems()
		end
		if BankFrame:IsVisible() then
			EquipColor:ColorUnusableBankItems()
		end
	end
end
--- OnUpdate.
EquipColor_checkFrames = 1
EquipColor_changedFrames = 1
function EquipColor_OnUpdate(arg1)
	EquipColor_checkFrames = table.getn(EquipColor.slotsToColor)
	if (EquipColor_checkFrames ~= EquipColor_changedFrames) then
		--EquipColor_BMsg("EquipColor_OnUpdate: Fired!")
		EquipColor:AddOnCore_ContainerFrame_Update()
		EquipColor_changedFrames = table.getn(EquipColor.slotsToColor)
	end
end
--- OnLoad.
function EquipColor_OnLoad()
	this:RegisterEvent("BAG_UPDATE")
	this:RegisterEvent("ITEM_LOCK_CHANGED")
	this:RegisterEvent("BAG_UPDATE_COOLDOWN")
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS")
	this:RegisterEvent("BANKFRAME_OPENED")
	this:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	this:RegisterEvent("MAIL_INBOX_UPDATE")
end
--- Debug Parser.
function EquipColor_BMsg(msg)
	ChatFrame1:AddMessage(msg or 'nil', 0,1,0.4)
end
--- Item Link Parser.
local function GetFromLink(link)
	local id = -1
	local name = "Unknown"
	if link ~= nil then
		for i, n in string.gfind(link, "|c%x+|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r") do
			if i ~= nil then id = i end
			if n ~= nil then name = n end
		end
	end
	return id, name
end
--- Bag Frame Parser.
local function GetContainerFrameName(id)
	for i = 1, NUM_CONTAINER_FRAMES, 1 do
		local containerFrame = getglobal("ContainerFrame" .. i)
		if containerFrame:IsShown() and containerFrame:GetID() == id then
			return "ContainerFrame" .. i
		end
	end
	return nil
end
--- Bank Frame Parser.
local function GetBankFrameInventorySlot(slot)
	for i = 1, NUM_BANKGENERIC_SLOTS, 1 do
		local bankSlot = getglobal("BankFrameItem" .. i)
		if bankSlot:GetID() == slot then
			return i + 39
		end
	end
	return nil
end
--- Automatic Hidden Tool Tip Parser.
local function CheckItemTooltip(bag, slot, itemtype)
	EquipColor_ScanTooltip:ClearLines()
	if bag == -1 then
		EquipColor_ScanTooltip:SetInventoryItem("player", GetBankFrameInventorySlot(slot))
	elseif bag == "MailBox" then
		EquipColor_ScanTooltip:SetInboxItem(slot)
	elseif bag == "Merchant" then
		EquipColor_ScanTooltip:SetMerchantItem(slot)
	else
		EquipColor_ScanTooltip:SetBagItem(bag, slot)
	end
	if itemtype == "Weapon" then
		local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft2'):GetText()
		if EquipColor_Tooltip then
			--EquipColor_BMsg("CheckItemTooltip: Weapon_Tooltip [" .. EquipColor_Tooltip .. "]")
			local _, _, offHand = string.find(EquipColor_Tooltip, "(Off Hand)")
			if offHand == "Off Hand" then
				return true
			else
				return false
			end
		end
	elseif itemtype == "Fishing Pole" then
		local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft8'):GetText()
		if EquipColor_Tooltip then
			--EquipColor_BMsg("CheckItemTooltip: Weapon_Tooltip [" .. EquipColor_Tooltip .. "]")
			local _, _, profName, profLevel = string.find(EquipColor_Tooltip, "Requires (.+) %((%d+)%)")
			if profName and profLevel then
				return profName, profLevel
			else
				return false
			end
		end
	elseif itemtype == "ClassArmor" then
		for ClassArmor = 7, 12 do
			local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft' .. ClassArmor):GetText()
			if EquipColor_Tooltip then
				--EquipColor_BMsg("CheckItemTooltip: Armor_Tooltip [" .. EquipColor_Tooltip .. "]")
				local _, _, ClassReq = string.find(EquipColor_Tooltip, "Classes%: (.+)")
				if ClassReq then
					if ClassReq == UnitClass("player") then
						--EquipColor_BMsg("CheckItemTooltip(True): ClassReq [" .. ClassReq .. "]")
						return true
					else
						--EquipColor_BMsg("CheckItemTooltip(False): ClassReq [" .. ClassReq .. "]")
						return false
					end
				end
			end
		end
	elseif itemtype == "Learned" then
		local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft3'):GetText()
		if EquipColor_Tooltip then
			--EquipColor_BMsg("CheckItemTooltip: Learned_Tooltip [" .. EquipColor_Tooltip .. "]")
			local _, _, hasLearned = string.find(EquipColor_Tooltip, "(Already known)")
			if hasLearned == "Already known" then
				return true
			else
				return false
			end
		end
	elseif itemtype == "Recipe" then
		local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft2'):GetText()
		if EquipColor_Tooltip then
			--EquipColor_BMsg("CheckItemTooltip: Recipe_Tooltip [" .. EquipColor_Tooltip .. "]")
			local _, _, profName, profLevel = string.find(EquipColor_Tooltip, "Requires (.+) %((%d+)%)")
			if profName and profLevel then
				--EquipColor_BMsg("CheckItemTooltip: profName [" .. profName .. "] profLevel [" .. profLevel .. "]")
				return profName, profLevel
			else
				return false
			end
		end
	elseif itemtype == "Book" then
		for Book = 2, 4 do
			local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft' .. Book):GetText()
			if EquipColor_Tooltip then
				--EquipColor_BMsg("CheckItemTooltip: Book_Tooltip [" .. EquipColor_Tooltip .. "]")
				local _, _, ClassReq = string.find(EquipColor_Tooltip, "Classes%: (.+)")
				if ClassReq then
					if ClassReq == UnitClass("Player") then
						return true
					else
						return false
					end
				end
			end
		end
	elseif itemtype == "INVTYPE_TRINKET" then
		local EquipColor_Tooltip = getglobal('EquipColor_ScanTooltipTextLeft5'):GetText()
		if EquipColor_Tooltip then
			--EquipColor_BMsg("CheckItemTooltip: Trinket_Tooltip [" .. EquipColor_Tooltip .. "]")
			local _, _, ClassReq = string.find(EquipColor_Tooltip, "Classes%: (.+)")
			--EquipColor_BMsg("CheckItemTooltip: class [" .. class .. "]")
			if not ClassReq then
				return true
			elseif ClassReq == UnitClass("player") then
				return true
			else
				return false
			end
		end
	else
		return false
	end
end
--- Player Skills Parser.
local function CheckCharacterSkills(skill, rank)
	local retSubclass = skill
	if retSubclass == "One-Handed Axes" then
		skill = "Axes"
	elseif retSubclass == "One-Handed Maces" then
		skill = "Maces"
	elseif retSubclass == "One-Handed Swords" then
		skill = "Swords"
	elseif retSubclass == "Shields" then
		skill = "Shield"
	elseif retSubclass == "Pole Arms" then
		skill = "Polearms"
	elseif retSubclass == "Plate" then
		skill = "Plate Mail"
	elseif retSubclass == "Fishing Pole" then
		skill = "Fishing"
	elseif retSubclass == "Fist Weapons" then
		skill = "Fist"
	end
	for skillIndex = 1, GetNumSkillLines() do
		local skillName, isHeader, _, skillRank = GetSkillLineInfo(skillIndex)
		if not isHeader then
			if skill == skillName and rank then
				--EquipColor_BMsg("CheckCharacterSkills: skillName [" .. skillName .. "] skill [" .. skill .. "] skillRank [" ..
					--skillRank .. "]")
				return skill, skillRank
			elseif skill == skillName then
				--EquipColor_BMsg("CheckCharacterSkills: skillName [" .. skillName .. "] skill [" .. skill .. "]")
				return skill
			elseif skill == "Fist" then
				if UnitClass("Player") == "Rogue" or UnitClass("Player") == "Druid" or UnitClass("Player") == "Warrior"
						or UnitClass("Player") == "Shaman" or UnitClass("Player") == "Hunter" then
					--EquipColor_BMsg("CheckCharacterSkills: Your character is able to wield Fist Weapons but there is no REAL check " ..
						--"for it. Might have to still train the skill.")
					return true
				end
			end
		end
	end
	return false
end
--- Spell Book Parser.
local function CheckCharacterSpells(spell)
	local i = 1
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end
		if spell == spellName then
			--EquipColor_BMsg("CheckCharacterSpells: spellName [" .. spellName .. " (" .. spellRank .. ")]")
			return true
		end
		i = i + 1
	end
	return false
end
--- AddOn compatibility functions. Currently supports Bagnon, OneBag, EngInventory, AllInOneInventory and SUCC-bag.
--- Whenever a Hooked AddOn fucntion is called, these are called after it to re-color the slots we want to show up unusable.

--- Colors items from slotsToColor table.
function EquipColor:AddOnCore_ContainerFrame_Update(object)
	--EquipColor_BMsg("AddOnCore_ContainerFrame_Update: Fired!")
	for k, v in pairs(self.slotsToColor) do
		if self.slotsToColor[k] ~= nil then
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
--- Removes entries from slotsToColor table when a slot needs updating.
function EquipColor:AddOnCore_ClearContainerFrameTable(slot)
	for k, v in pairs(EquipColor.slotsToColor) do
		if (v == slot) then
			EquipColor.slotsToColor[k] = nil
		end
	end
end
--- Determine addon.
function EquipColor:AddOnCore_SetAddon(slot, object)
	--if slot then EquipColor_BMsg("SetItemColors: slot [" .. slot:GetName() .. "]") end
	--if object then EquipColor_BMsg("SetItemColors: object [" .. object .. "]") end
	if OneCore ~= nil then
		slot = object
		object = slot
	end
	local bag, bagn, slotn, item
	if IsAddOnLoaded("Bagnon_Core") or OneCore ~= nil then
		bag = slot:GetParent()
		bagn = bag:GetID()
		slotn = slot:GetID()
		item = slot:GetName()
		EquipColor:AddOnCore_SetItemColors(bagn, slotn, item)
	end
	if IsAddOnLoaded("EngBags") then
		bagn = object["bagnum"]
		slotn = object["slotnum"]
		item = slot:GetName()
		EquipColor:AddOnCore_SetItemColors(bagn, slotn, item)
	end
	if IsAddOnLoaded("AllInOneInventory") then
		local name = slot:GetName()
		if name == "AllInOneInventoryFrame" then
			item = getglobal(name .. "Item" .. object)
			if (not item) or (not item:IsVisible()) then
				return
			end
			bagn, slotn = AllInOneInventory_GetIdAsBagSlot(item:GetID())
			if (bag == -1) and (slot == -1) then
				return
			end
			item = item:GetName()
		else
			bagn = slot.bagIndex
			slotn = slot.itemIndex
			item = slot:GetName()
		end
		EquipColor:AddOnCore_SetItemColors(bagn, slotn, item)
	end
	if IsAddOnLoaded("SUCC-bag") then
		local slot = slot:GetName()
		if slot == "SUCC_bag" then
			local totalSlots = 0
			for bag = 0, 4 do
				local size = GetContainerNumSlots(bag)
				if size and size > 0 then
					totalSlots = totalSlots + size
				end
			end
			for slot1 = 1, totalSlots do
				slotn = getglobal(slot .. "Item" .. slot1)
				bagn = slotn:GetParent():GetID()
				item = slotn:GetName()
				slotn = slotn:GetID()
				EquipColor:AddOnCore_SetItemColors(bagn, slotn, item)
			end
		end
		if slot == "SUCC_bagBank" then
			local totalSlots = 0
			for bag = 5, 10 do
				local size = GetContainerNumSlots(bag)
				if size and size > 0 then
					totalSlots = totalSlots + size
				end
			end
			for slot2 = 1, totalSlots + 24 do
				slotn = getglobal(slot .. "Item" .. slot2)
				bagn = slotn:GetParent():GetID()
				item = slotn:GetName()
				slotn = slotn:GetID()
				EquipColor:AddOnCore_SetItemColors(bagn, slotn, item)
			end
		end
	end
end
--- Core function.
function EquipColor:AddOnCore_SetItemColors(bagn, slotn, item)
	--EquipColor_BMsg("SetItemColors: bag [" .. bagn .. "] slot [" .. slotn .. "] item [" .. item .. "]")
	EquipColor:AddOnCore_ClearContainerFrameTable(item)
	local itemid, name = GetFromLink(GetContainerItemLink(bagn, slotn))
	if itemid ~= -1 and name ~= "Unknown" then
		local itemname, _, _, itemminlevel, itemclass, itemsubclass, _, itemEquipLoc = GetItemInfo(itemid)
		if itemclass ~= nil and itemsubclass ~= nil then
			--EquipColor_BMsg("SetItemColors(Items): ItemName [" .. itemname .. "] ItemID [" .. itemid .. "]")
			if itemminlevel > UnitLevel("player") then
				table.insert(self.slotsToColor, item)
				--EquipColor_BMsg("SetItemColors(AllItems-LevelCheck): Name [" .. itemname .. "] ID [" .. itemid .. "] SubClass [" ..
					--itemsubclass .. "]")
			elseif (itemclass == "Weapon" or itemclass == "Armor") and itemsubclass ~= "Miscellaneous" then
				if CheckCharacterSkills(itemsubclass) == false then
					table.insert(self.slotsToColor, item)
					--EquipColor_BMsg("SetItemColors(Weapons&Armor): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
						--itemsubclass .. "]")
				elseif itemclass == "Weapon" and itemsubclass == "Fishing Pole" then
					local skillName, skillRank = CheckCharacterSkills("Fishing", true)
					local profName, profLevel = CheckItemTooltip(bagn, slotn, itemsubclass)
					if profName == "Fishing" and skillName == "Fishing" then
						if tonumber(profLevel) > skillRank then
							table.insert(self.slotsToColor, item)
							--EquipColor_BMsg("SetItemColors(Fishing Pole-SkillLevel): Name [" .. itemname .. "] profName [" ..
								--profName .. "] profLevel [" .. profLevel .. "]")
						end
					end
				elseif itemclass == "Armor" then
					if CheckItemTooltip(bagn, slotn, "ClassArmor") == false then
						table.insert(self.slotsToColor, item)
						--EquipColor_BMsg("SetItemColors(ClassArmor): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
							--itemsubclass .. "]")
					end
				elseif CheckCharacterSpells("Dual Wield") == false then
					if CheckItemTooltip(bagn, slotn, itemclass) == true then
						table.insert(self.slotsToColor, item)
						--EquipColor_BMsg("SetItemColors(Weapon-Off Hand): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
							--itemsubclass .. "]")
					end
				end
			elseif itemclass == "Projectile" or itemclass == "Quiver" then
				if CheckCharacterSkills("Bows") == false and CheckCharacterSkills("Crossbows") == false then
					if itemsubclass == "Arrow" or itemsubclass == "Quiver" then
						table.insert(self.slotsToColor, item)
						--EquipColor_BMsg("SetItemColors(Arrows&Quivers): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
							--itemsubclass .. "]")
					end
				end
				if CheckCharacterSkills("Guns") == false then
					if itemsubclass == "Bullet" or itemsubclass == "Ammo Pouch" then
						table.insert(self.slotsToColor, item)
						--EquipColor_BMsg("SetItemColors(Bullets&Pouches): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
							--itemsubclass .. "]")
					end
				end
			elseif itemclass == "Recipe" then
				local profName, profLevel = CheckItemTooltip(bagn, slotn, itemclass)
				if profName and profLevel then
					if CheckCharacterSkills(profName) == false then
						table.insert(self.slotsToColor, item)
						--EquipColor_BMsg("SetItemColors(Recipes-ProfCheck): Name [" .. itemname .. "] profName [" ..
							--profName .. "] profLevel [" .. profLevel .. "]")
					else
						local skillName, skillRank = CheckCharacterSkills(profName, true)
						if tonumber(profLevel) > skillRank then
							table.insert(self.slotsToColor, item)
							--EquipColor_BMsg("SetItemColors(Recipes-SkillLevel): Name [" .. itemname .. "] profName [" ..
								--profName .. "] profLevel [" .. profLevel .. "]")
						end
					end
				end
				local hasLearned = CheckItemTooltip(bagn, slotn, "Learned")
				if hasLearned then
					table.insert(self.slotsToColor, item.."Learned")
					--EquipColor_BMsg("SetItemColors(Recipes-Learned): Name [" .. itemname .. "] Player has already learned recipe")
				end
				if itemsubclass == "Book" then
					if CheckItemTooltip(bagn, slotn, "Book") == false then
						table.insert(self.slotsToColor, item)
						--EquipColor_BMsg("SetItemColors(Book-ClassCheck): Name [" .. itemname .. "] itemEquipLoc [" .. itemEquipLoc .. "]")
					end
				end
			elseif itemclass == "Miscellaneous" then
				if itemsubclass == "Junk" then
					if CheckItemTooltip(bagn, slotn, "Book") == false then
						table.insert(self.slotsToColor, item)
						--EquipColor_BMsg("SetItemColors(Book-ClassCheck): Name [" .. itemname .. "] itemEquipLoc [" .. itemEquipLoc .. "]")
					end
				end
			elseif itemEquipLoc == "INVTYPE_TRINKET" then
				if CheckItemTooltip(bagn, slotn, itemEquipLoc) == false then
					table.insert(self.slotsToColor, item)
					--EquipColor_BMsg("SetItemColors(Trinkets-ClassCheck): Name [" .. itemname .. "] itemEquipLoc [" ..
						--itemEquipLoc .. "]")
				end
			end
		end
	end
end
--- Default WoW Client Functions.
--- Core Function. This is called by all core functions below.
function EquipColor:ColorItems(bag, slot, itemFrame, frame)
	local itemid, name = GetFromLink(GetContainerItemLink(bag, slot))
	if itemid ~= -1 and name ~= "Unknown" then
		local itemname, _, _, itemminlevel, itemclass, itemsubclass, _, itemEquipLoc = GetItemInfo(itemid)
		if itemFrame ~= nil and itemFrame:IsVisible() and itemclass ~= nil and itemsubclass ~= nil then
			--if frame ~= nil then
				--EquipColor_BMsg("ColorItems(Items): ItemName [" .. itemname .. "] ItemID [" .. itemid .. "]")
			--end
			if itemminlevel > UnitLevel("player") then
				SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
				if frame ~= nil then
					EquipColor_BMsg(frame .. "(AllItems-LevelCheck): Name [" .. itemname .. "] ID [" .. itemid .. "] SubClass [" ..
						itemsubclass .. "]")
				end
			elseif (itemclass == "Weapon" or itemclass == "Armor") and itemsubclass ~= "Miscellaneous" then
				if CheckCharacterSkills(itemsubclass) == false then
					SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
					if frame ~= nil then
						EquipColor_BMsg(frame .. "(Weapons&Armor): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
							itemsubclass .. "]")
					end
				elseif itemclass == "Weapon" and itemsubclass == "Fishing Pole" then
					local skillName, skillRank = CheckCharacterSkills("Fishing", true)
					local profName, profLevel = CheckItemTooltip(bag, slot, itemsubclass)
					if profName == "Fishing" and skillName == "Fishing" then
						if tonumber(profLevel) > skillRank then
							SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
							if frame ~= nil then
								EquipColor_BMsg(frame .. "(Fishing Pole-SkillLevel): Name [" .. itemname .. "] profName [" ..
									profName .. "] profLevel [" .. profLevel .. "]")
							end
						end
					end
				elseif itemclass == "Armor" then
					if CheckItemTooltip(bag, slot, "ClassArmor") == false then
						SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
						if frame ~= nil then
							EquipColor_BMsg(frame .. "(ClassArmor): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
								itemsubclass .. "]")
						end
					end
				elseif CheckCharacterSpells("Dual Wield") == false then
					if CheckItemTooltip(bag, slot, itemclass) == true then
						SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
						if frame ~= nil then
							EquipColor_BMsg(frame .. "(Weapon-Off Hand): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
								itemsubclass .. "]")
						end
					end
				end
			elseif itemclass == "Projectile" or itemclass == "Quiver" then
				if CheckCharacterSkills("Bows") == false and CheckCharacterSkills("Crossbows") == false then
					if itemsubclass == "Arrow" or itemsubclass == "Quiver" then
						SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
						if frame ~= nil then
							EquipColor_BMsg(frame .. "(Arrows&Quivers): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
								itemsubclass .. "]")
						end
					end
				end
				if CheckCharacterSkills("Guns") == false then
					if itemsubclass == "Bullet" or itemsubclass == "Ammo Pouch" then
						SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
						if frame ~= nil then
							EquipColor_BMsg(frame .. "(Bullets&Pouches): Name [" .. itemname .. "] ID [" .. itemid .. "] subclass [" ..
								itemsubclass .. "]")
						end
					end
				end
			elseif itemclass == "Recipe" then
				local profName, profLevel = CheckItemTooltip(bag, slot, itemclass)
				if profName and profLevel then
					if CheckCharacterSkills(profName) == false then
						SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
						if frame ~= nil then
							EquipColor_BMsg(frame .. "(Recipes-ProfCheck): Name [" .. itemname .. "] profName [" ..
								profName .. "] profLevel [" .. profLevel .."]")
						end
					else
						local skillName, skillRank = CheckCharacterSkills(profName, true)
						if tonumber(profLevel) > skillRank then
							SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
							if frame ~= nil then
								EquipColor_BMsg(frame .. "(Recipes-SkillLevel): Name [" .. itemname .. "] profName [" ..
									profName .. "] profLevel [" .. profLevel .. "]")
							end
						end
					end
				end
				local hasLearned = CheckItemTooltip(bag, slot, "Learned")
				if hasLearned then
					SetItemButtonTextureVertexColor(itemFrame, 0, 1, 1)
					if frame ~= nil then
						EquipColor_BMsg(frame .. "(Recipes-Learned): Name [" .. itemname .. "] Player has already learned recipe")
					end
				end
				if itemsubclass == "Book" then
					if CheckItemTooltip(bag, slot, "Book") == false then
						SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
						if frame ~= nil then
							EquipColor_BMsg(frame .. "(Book-ClassCheck): Name [" .. itemname .. "] itemEquipLoc [" .. itemEquipLoc .. "]")
						end
					end
				end
			elseif itemclass == "Miscellaneous" then
				if itemsubclass == "Junk" then
					if CheckItemTooltip(bag, slot, "Book" == false) then
						SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
						if frame ~= nil then
							EquipColor_BMsg(frame .. "(Book-ClassCheck): Name [" .. itemname .. "] itemEquipLoc [" .. itemEquipLoc .. "]")
						end
					end
				end
			elseif itemEquipLoc == "INVTYPE_TRINKET" then
				if CheckItemTooltip(bag, slot, itemEquipLoc) == false then
					SetItemButtonTextureVertexColor(itemFrame, 1, 0, 0)
					if frame ~= nil then
						EquipColor_BMsg(frame .. "(Trinkets-ClassCheck): Name [" .. itemname .. "] itemEquipLoc [" .. itemEquipLoc .. "]")
					end
				end
			end
		end
	end
end
--- Called by BagFrame OnEvent handler to update all bags and slots.
function EquipColor:ColorUnusableItems()
	for bag = 0, 11, 1 do
		for slot = 1, GetContainerNumSlots(bag) do
			local bagName = GetContainerFrameName(bag)
			if bagName then
				local itemFrame = getglobal(bagName .. "Item" .. (GetContainerNumSlots(bag) - (slot - 1)))
				EquipColor:ColorItems(bag, slot, itemFrame, nil) --"ColorUnusableItems")
			end
		end
	end
end
--- Called by BagFrame OnShow hooks handler. Updates the toggled bag.
function EquipColor:ColorUnusableItemsInBag(bag)
	for slot = 1, GetContainerNumSlots(bag) do
		local bagName = GetContainerFrameName(bag)
		if bagName then
			local itemFrame = getglobal(bagName .. "Item" .. (GetContainerNumSlots(bag) - (slot-1)))
			EquipColor:ColorItems(bag, slot, itemFrame, nil) --"ColorUnusableItemsInBag")
		end
	end
end
--- Called by BankFrame OnEvent handler to update all visible Bank bags and slots.
function EquipColor:ColorUnusableBankItems()
	local bag = BANK_CONTAINER
	for slot = 1, GetContainerNumSlots(bag) do
		local itemFrame = getglobal("BankFrameItem" .. slot)
		EquipColor:ColorItems(bag, slot, itemFrame, nil) --"ColorUnusableBankItems")
	end
end
--- Called by BankFrame OnShow handler. Updates the main bank frame and each toggled bag.
function EquipColor:ColorUnusableBankItemsInSlot(slot)
	local bag = BANK_CONTAINER
	local itemFrame = getglobal("BankFrameItem" .. slot)
	EquipColor:ColorItems(bag, slot, itemFrame, nil) --"ColorUnusableBankItemsInSlot")
end
--- Called by MailFrame OnShow handler.
function EquipColor:ColorUnusableMailItemsInSlot()
	if MailFrame:IsVisible() then
		local numItems = GetInboxNumItems()
		for i = 1, numItems do
			if numItems >= 1 then
				local name, _, _, _, canUse = GetInboxItem(i)
				local packageIcon, _, _, money, _, _, _, hasItem, _, _, _, _, _ = GetInboxHeaderInfo(i)
				local hasLearned = CheckItemTooltip("MailBox", i, "Learned")
				if canUse and hasItem and hasLearned then
					SetDesaturation(getglobal("MailItem" .. i .. "ButtonIcon"), nil)
					getglobal("MailItem" .. i .. "ButtonIcon"):SetVertexColor(0, 1, 1)
					SetDesaturation(getglobal("MailItem" .. i .. "ButtonIcon"), nil)
					--EquipColor_BMsg("ColorUnusableMailItemsInSlot: Player has already learned recipe")
				elseif canUse and hasItem then
					--EquipColor_BMsg("ColorUnusableMailItemsInSlot: Can use item [" .. i .. "]")
				elseif hasItem then
					SetDesaturation(getglobal("MailItem" .. i .. "ButtonIcon"), nil)
					getglobal("MailItem" .. i .. "ButtonIcon"):SetVertexColor(1, 0, 0)
					SetDesaturation(getglobal("MailItem" .. i .. "ButtonIcon"), nil)
					--EquipColor_BMsg("ColorUnusableMailItemsInSlot: Can't use item [" .. i .. "]")
				end
			end
		end
	end
end
--- Called by Default WoW Client Event handler. All Merchant/Vendors should trigger this.
function EquipColor:ColorUnusableMerchantItems()
	if MerchantFrame:IsVisible() then
		local numMerchantItems = GetMerchantNumItems()
		for i = 1, MERCHANT_ITEMS_PER_PAGE, 1 do
			local index = (((MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE) + i)
			local itemButton = getglobal("MerchantItem" .. i .. "ItemButton")
			local merchantButton = getglobal("MerchantItem" .. i)
			if index <= numMerchantItems then
				local itemName, _, _, _, _, _ = GetMerchantItemInfo(index)
				local hasLearned = CheckItemTooltip("Merchant", index, "Learned")
				if hasLearned then
					SetItemButtonNameFrameVertexColor(merchantButton, 0, 1, 0)
					SetItemButtonSlotVertexColor(merchantButton, 0, 1, 0)
					SetItemButtonTextureVertexColor(itemButton, 0, 1, 0)
					SetItemButtonNormalTextureVertexColor(itemButton, 0, 1, 0)
					--EquipColor_BMsg("ColorUnusableMerchantItems: Player has already learned: " .. itemName)
				end
			end
		end
	end
end
