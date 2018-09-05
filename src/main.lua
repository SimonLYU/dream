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
CONFIG_everyday = 1

--main
function main()
	--init
	init("0", 1);
	setScreenScale(1242,2208)--以iphone7plus为基础制作脚本
	util.initMyHud()
	--UI
	local ret, results = showUI(json.encode(ui.configUI()))    --table转json
	--缓存用户配置
--	_G["全局存储例子"] = tonumber(results["全局存储例子"])--全局存储例子
	--点击确认返回1, 取消返回0
	if ret == 1 then
		--results 返回以id为key的Map类型数据,返回值为字符串
		if bb.strutils.contains(results["CheckBoxGroup1"],"0") then--每日任务
			CONFIG_everyday = 1
		else
			CONFIG_everyday = 0
		end
		
	else
		dialog("主人拜拜,我们下次见哦~", 0)
		lua_exit()
	end
	
	if CONFIG_everyday == 0 then
		dialog("主人,要记得选择功能哦~",0)
		main()
		return 0
	end
	
	repeat
		public.func_start_init()
		if CONFIG_everyday == 1 then
			everyday.everyday_main()
		end
		mSleep(500)
	until(false)
end
main()
return self