require("util")
public = {}

--循环关闭弹窗直到无法退出为止
function public.closeMenuIfNecessary()
	x , y = util.findColor(0x12507a, 90, 100, 35, 260, 90)--返回的背景颜色:墨绿色
	x1 , y1 = util.findColor(0xf8f8f7, 90, 100, 35, 260, 90)--文字颜色:白色
	if x > -1 and x1 > -1 then
		util.click(x1,y1)
		util.hudToast("关闭子菜单")
		mSleep(1000)
		public.closeMenuIfNecessary()
		return 0
	else
		util.hudToast("准备就绪")
	end
end

--直到彻底关掉体力弹窗
function public.closeTiLiAlertIfNecessary()
	if public.detctTiLiAlert() then
		util.hudToast("关闭体力弹窗")
		public.clickLocation()
		mSleep(500)
		public.closeTiLiAlertIfNecessary()
		return 1
	else
		return 0
	end
end

--定位屏幕位置
function public.func_start_init()
	--重置系统锁屏时间
	resetIDLETimer()
	
	--检测是否有充值弹窗,有则关闭
	public.closeChongZhiAlertIfNecessary()
	
	--检测是否有体力弹窗,有则关闭
	public.closeTiLiAlertIfNecessary()
	
	--关闭子菜单
	public.closeMenuIfNecessary()
	
end

--处理体力弹窗
function public.dealTiLiAlert()
	mSleep(500)
	tiLiBuChongType = _G["tiLiBuChong"]
	
	if public.detctTiLiAlert() then
		if tiLiBuChongType == 0 then --不补充
			util.hudToast("不补充体力")
			public.closeTiLiAlertIfNecessary()
		elseif tiLiBuChongType == 1 then--允许面包补充
			util.hudToast("使用面包充体力")
			util.click(900,775)
			mSleep(1000)--此处有网络请求,多延迟一会
			public.clickLocation()--成功后会出现一个面包弹窗,不成功此时点击也应该没问题
			mSleep(500)
			if public.closeTiLiAlertIfNecessary() == 1 then--如果此时还检测到体力弹窗,代表面包不足,关掉弹窗
				util.hudToast("面包不足,补充失败")
			end
		elseif tiLiBuChongType == 2 then --允许钻石补充
			util.hudToast("使用钻石充体力")
			util.click(1330,778)
			mSleep(1000)--此处有网络请求,多延迟一会
			public.clickLocation()--成功后会出现一个面包弹窗,不成功此时点击也应该没问题
			mSleep(500)
			public.closeChongZhiAlertIfNecessary()--如果此时检测到充值弹窗则关闭充值弹窗
			if public.closeTiLiAlertIfNecessary() == 1 then--如果此时还检测到体力弹窗,代表钻石不足,关掉弹窗
				util.hudToast("钻石不足,补充失败")
			end
		else--理论上不会出现
			public.closeTiLiAlertIfNecessary()
		end
		return true
	else
		return false
	end
end

--关闭充值弹窗
function public.closeChongZhiAlertIfNecessary()
	if public.detectChongZhiAlert() then
		util.hudToast("关闭充值弹窗")
		util.click(927,790)
		mSleep(500)
		public.closeChongZhiAlertIfNecessary()
		return 1
	else
		return 0
	end
end

--检测充值弹窗
function public.detectChongZhiAlert()
	x , y = util.findColor(0xffffff, 90, 843, 762, 1016, 818)--弹窗左侧按钮文案:白色
	x1 , y1 = util.findColor(0x622e32, 90, 843, 762, 1016, 818)--弹窗左侧按钮背景:红色
	x3 , y3 = util.findColor(0xffffff, 90, 1200, 760, 1368, 817)--弹窗右侧按钮文案:白色
	x4 , y4 = util.findColor(0x33d4f0, 90, 1200, 760, 1368, 817)--弹窗右侧按钮背景:蓝色
	x5 , y5 = util.findColor(0x47291f, 90, 996, 360, 1200, 405)--弹窗title文案:茶色
	if x > -1 and x1 > -1 and x3 > -1 and x4 > -1 and x5 <= -1 then
		util.hudToast("检测到充值弹窗")
		return true
	else
		return false
	end
end

--检测体力弹窗
function public.detctTiLiAlert()
	x , y = util.findColor(0xfefefe, 90, 800, 743, 991, 811)--弹窗左侧按钮文案:白色
	x1 , y1 = util.findColor(0x3adef4, 90, 800, 743, 991, 811)--弹窗左侧按钮背景:蓝色
	x3 , y3 = util.findColor(0xfefefe, 90, 1220, 743, 1425, 811)--弹窗右侧按钮文案:白色
	x4 , y4 = util.findColor(0x2ecfed, 90, 1220, 743, 1425, 811)--弹窗右侧按钮背景:蓝色
	x5 , y5 = util.findColor(0x47291f, 90, 996, 360, 1200, 405)--弹窗title文案:茶色
	if x > -1 and x1 > -1 and x3 > -1 and x4 > -1 and x5 > -1 then
		util.hudToast("检测到体力弹窗")
		return true
	else
		return false
	end
end

--点击左下角定位按钮(空白位置click)
function public.clickLocation()
	util.click(125,1150)
	mSleep(500)
end

--检测是否在游戏中
function public.playing_game()
	
	--保护:是否出现了返回按钮
	x , y = util.findColor(0x12507a, 90, 100, 35, 260, 90)--返回的背景颜色:墨绿色
	x1 , y1 = util.findColor(0xf8f8f7, 90, 100, 35, 260, 90)--文字颜色:白色
	if x > -1 and x1 > -1 then
		return false
	end
	
	--保护:检测是否在世界地图
	if public.detect_world_map() then
		return false
	end
	
	--点击自动按钮的位置
	util.click(2126,443)
	mSleep(250)
	--点击开始按钮的位置
	util.click(2077,1116)
	mSleep(5000)
	
	--无限循环,直到自动游戏结束为止(结束条件:检测到大地图 或 出现了返回按钮)
	public.playing_game()
end

--检测是否在世界地图
function public.detect_world_map()
	x , y = util.findColor(0xffffff, 90, 295, 35, 400, 77)--名字:白色
	x1 , y1 = util.findColor(0xfedf73, 90, 546, 35, 591, 77)--金币:金色
	x2 , y2 = util.findColor(0x7efec6, 90, 926, 35, 971, 77)--钻石:彩色
	x3 , y3 = util.findColor(0xf6f1d9, 90, 1325, 35, 1382, 77)--面包:奶色
	x4 , y4 = util.findColor(0x99661f, 90, 33, 298, 118, 380)--左侧活动:木色
	if x > -1 and x1 > -1 and x2 > -1 and x3 > -1 and x4 > -1 then
		return true
	else
		return false
	end
end

return public