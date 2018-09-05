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
		util.hudToast("ok")--ceshi...
	end
end

--定位屏幕位置
function public.func_start_init()
	--重置系统锁屏时间
	resetIDLETimer()
	
	--关闭子菜单
	public.closeMenuIfNecessary()
	
end

return public