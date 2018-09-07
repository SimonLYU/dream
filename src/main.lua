--require
require("public")
require("util")
require("ui")
require("everyday")
local bb = require("3rd.badboy")
local json = bb.json
--moudle
self = {}

--config
CONFIG_everyday = 0
CONFIG_endlessMission = 0

--main
function main()
	--init
	init("0", 1);
	setScreenScale(1242,2208)--以iphone7plus为基础制作脚本
	util.initMyHud()
	--UI
	local ret, results = showUI(json.encode(ui.configUI()))    --table转json
	--缓存用户配置
	_G["xiongGuiJiaoLian"] = tonumber(results["JiaoLianComboBox"])--兄贵教练
	_G["xiongGuiLevel"] = tonumber(results["XiongGuiComboBox"])--兄贵等级
	_G["texunLevel"] = tonumber(results["TeXunComboBox"])--特训等级
	_G["shiLianLevel"] = tonumber(results["ShiLianComboBox"])--试炼等级
	_G["baoZangFlag"] = bb.strutils.contains(results["BaoZangCheckBoxGroup"],"0")--是否开启宝藏
	_G["baoZangLevel"] = tonumber(results["BaoZangComboBox"])--宝藏等级
	_G["jiBanLevel"] = tonumber(results["JiBanComboBox"])--羁绊之地等级
	_G["timeLimit3Level"] = tonumber(results["TimeLimit3ComboBox"])--x限时任务3等级(黑暗之契约书-波赞鲁)
	
	_G["tiLiBuChong"] = tonumber(results["TiLiComboBox"])--体力不足面包补充
	_G["endlessMission"] = tonumber(results["EndlessMissionComboBox"])--无限刷副本
	--标记
	_G["everyDayFinished"] = false
	
	--点击确认返回1, 取消返回0
	if ret == 1 then
		--results 返回以id为key的Map类型数据,返回值为字符串
		missionType = tonumber(results["MissionRadioGroup"])--0:打怪,1:据点采集
		if missionType == 0 then --清每日一条龙副本
			CONFIG_everyday = 1
		elseif missionType == 1 then --单一副本无限刷
			CONFIG_endlessMission = 1
		end
		
	else
		dialog("主人拜拜,我们下次见哦~", 0)
		lua_exit()
	end
	
	if CONFIG_everyday == 0 and CONFIG_endlessMission == 0 then
		dialog("主人,要记得选择功能哦~",0)
		main()
		return 0
	end
	
	repeat
		public.func_start_init()
		if CONFIG_everyday == 1  and not _G["everyDayFinished"] then
			everyday.everyday_main()
		end
		if CONFIG_endlessMission == 1 then
			everyday.endlessMission()
		end
		mSleep(500)
	until(_G["everyDayFinished"])
	
	--跳出主循环后
	
	if _G["everyDayFinished"] then
		--领取奖励
		everyday.receiveAward()
		
		--任务结束提示
		util.hudToast("已经没有附带奖励的副本了,建议开启无限模式")
	end
	
	
	repeat
		--重置系统锁屏时间
		resetIDLETimer()
	until(false)
end
main()
return self