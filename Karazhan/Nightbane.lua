﻿------------------------------
--      Are you local?    --
------------------------------

local boss = AceLibrary("Babble-Boss-2.2")["Nightbane"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)
local blast
local bones

----------------------------
--      Localization     --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Nightbane",

	fear_cmd = "fear",
	fear_name = "Fear Alert",
	fear_desc = "Warn for Bellowing Roar",

	charr_cmd = "charr",
	charr_name = "Charred Earth on You",
	charr_desc = "Warn when you are on Charred Earth",

	phase_cmd = "phase",
	phase_name = "Phases",
	phase_desc = ("Warn when %s switches between phases"):format(boss),

	engage_cmd = "engage",
	engage_name = "Engage",
	engage_desc = "Engage alert",

	blast_cmd = "blast",
	blast_name = "Smoking Blast",
	blast_desc = "Warn for Smoking Blast being cast",

	bones_cmd = "bones",
	bones_name = "Raid of Bones",
	bones_desc = "Warn who Rain of Bones is on",

	icon_cmd = "icon",
	icon_name = "Raid Icon",
	icon_desc = "Place a raid icon on the person afflicted by Rain of Bones(requires promoted or higher)",

	fear_trigger = "cast Bellowing Roar",
	fear_message = "Fear in 2 sec!",
	fear_warning = "Fear Soon",
	fear_bar = "Fear",

	charr_trigger = "You are afflicted by Charred Earth.",
	charr_message = "Charred Earth on YOU!",

	blast_trigger = "cast Smoking Blast",
	blast_message = "Incoming Smoking Blast!",

	airphase_trigger = "Miserable vermin. I shall exterminate you from the air!",
	landphase_trigger1 = "Enough! I shall land and crush you myself!",
	landphase_trigger2 = "Insects! Let me show you my strength up close!",
	airphase_message = "Flying!",
	landphase_message = "Landing!",

	engage_trigger = "What fools! I shall bring a quick end to your suffering!",
	engage_message = "%s Engaged",

	bones_trigger = "^([^%s]+) ([^%s]+) afflicted by Rain of Bones",
	bones_message = "Rain of Bones on [%s]",

	you = "You",
} end )

L:RegisterTranslations("koKR", function() return {
	fear_name = "공포 경고",
	fear_desc = "우레와 같은 울부짖음에 대한 경고",

	charr_name = "당신에 불타버린 대지",
	charr_desc = "당신이 불타버린 대지에 걸렸을 때 알림",

	phase_name = "단계",
	phase_desc = ("%s의 단계 변경 시 알림"):format(boss),

	engage_name = "전투 개시",
	engage_desc = "전투 개시 알림",

	blast_name = "불타는 돌풍",
	blast_desc = "불타는 돌풍 시전에 대한 경고",

	bones_name = "뼈의 비",
	bones_desc = "뼈의 비에 걸린 사람 경고",

	icon_name = "공격대 아이콘",
	icon_desc = "뼈의 비에 걸린 사람에게 공격대 아이콘 지정(승급자 이상 권한 요구)",

	fear_trigger = "우레와 같은 울부짖음 시전을 시작합니다.",
	fear_message = "2초 후 공포!",
	fear_warning = "잠시 후 공포",
	fear_bar = "공포",

	charr_trigger = "당신은 불타버린 대지에 걸렸습니다.",
	charr_message = "당신에 불타버린 대지!",

	blast_trigger = "불타는 돌풍 시전을 시작합니다.",
	blast_message = "잠시 후 불타는 돌풍!",

	airphase_trigger = "이 더러운 기생충들, 내가 하늘에서 너희의 씨를 말리리라!",
	landphase_trigger1 = "그만! 내 친히 내려가서 너희를 짓이겨주마!",
	landphase_trigger2 = "하루살이 같은 놈들! 나의 힘을 똑똑히 보여주겠다!",
	airphase_message = "비행!",
	landphase_message = "착지!",

	engage_trigger = "정말 멍청하군! 고통 없이 빨리 끝내주마!",
	engage_message = "%s 전투 개시",

	bones_trigger = "^([^|;%s]*)(.*)뼈의 비에 걸렸습니다%.$",
	bones_message = "[%s] 뼈의 비",

	you = "당신은",
} end )

----------------------------------
--    Module Declaration   --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.zonename = AceLibrary("Babble-Zone-2.2")["Karazhan"]
mod.enabletrigger = boss
mod.toggleoptions = {"engage", "phase", "fear", "charr", -1, "blast", "bones", "icon", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", "BonesEvent")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "BonesEvent")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE", "BonesEvent")

	self:RegisterEvent("BigWigs_RecvSync")
	self:TriggerEvent("BigWigs_ThrottleSync", "NightbaneFear", 5)
	self:TriggerEvent("BigWigs_ThrottleSync", "Bones", 5)

	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH", "GenericBossDeath")
	blast = nil
	bones = nil
	self:RegisterEvent("BigWigs_Message")
end

------------------------------
--     Event Handlers    --
------------------------------

function mod:BigWigs_RecvSync( sync, rest, nick )
	if sync == "NightbaneFear" and self.db.profile.fear then
		self:Bar(L["fear_bar"], 2, "Spell_Shadow_PsychicScream")
		self:Message(L["fear_message"], "Positive")
		self:Bar(L["fear_warning"], 40, "Spell_Shadow_PsychicScream")
		self:DelayedMessage(38, L["fear_warning"], "Positive")
	elseif sync == "NightbaneBlast" and self.db.profile.blast then
		self:Message(L["blast_message"], "Urgent", nil, "Alert")
	elseif sync == "Bones" and rest and self.db.profile.bones then
		self:Message(L["bones_message"]:format(rest), "Attention")
		if self.db.profile.icon then
			self:Icon(rest)
		end
	end
end

function mod:CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE(msg)
	if msg:find(L["fear_trigger"]) then
		self:Sync("NightbaneFear")
	elseif not blast and msg:find(L["blast_trigger"]) then
		self:Sync("NightbaneBlast")
		blast = true
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if self.db.profile.engage and msg == L["engage_trigger"] then
		self:Message(L["engage_message"]:format(boss), "Positive")
	elseif self.db.profile.phase and msg == L["airphase_trigger"] then
		self:Message(L["airphase_message"], "Attention", nil, "Info")
	elseif self.db.profile.phase and (msg == L["landphase_trigger1"] or msg == L["landphase_trigger2"]) then
		self:Message(L["landphase_message"], "Important", nil, "Long")
	end
end

function mod:CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE(msg)
	if self.db.profile.charr and msg == L["charr_trigger"] then
		self:Message(L["charr_message"], "Urgent", true, "Alarm")
	end
end

function mod:BonesEvent(msg)
	if not bones then
		local bplayer, btype = select(3, msg:find(L["bones_trigger"]))
		if bplayer then
			if bplayer == L["you"] then
				bplayer = UnitName("player")
			end
			self:Sync("Bones "..bplayer)
			bones = true
		end
	end
end

function mod:BigWigs_Message(text)
	if text == L["landphase_message"] then
		blast = nil
	end
	if text == L["airphase_message"] then
		bones = nil
	end
end
