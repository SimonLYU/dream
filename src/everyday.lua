require "util"
require "public"
STEP_everyDay = 0
STEP_receiveAward = 0

TARGET = 0

everyday = {}


--------------------------每日任务/无限任务--------------------------
jiaoLianNameList = {"安东(步兵)","琼斯(弓刺)","巴兰(枪兵)","洛基(飞水)","萨姆森(骑兵)","尼姆(僧侣)"}
levelList = {15,20,25,30,35,40,45,50,55,60,65}
--0点击秘境
function func_clickMiJing()
	util.click(2123,406)
	util.hudToast("点击秘境")
	STEP_everyDay = 1
end

--1 任务选择器
function func_autoChooseTarget()
	--切换到日常界面
	util.click(2000,526)
	util.hudToast("选择日常任务")
	mSleep(500)
	
	--查看兄贵健身房是否有剩余奖励
	x , y = util.findColor(0xdc080a, 90, 1445, 373, 1640, 402)--0:红色
	if x <= -1 then
		STEP_everyDay = 2 --兄贵健身房任务头
		util.hudToast("发现兄贵有剩余奖励,开始健身")
		return 0
	end
	
	--查看特训屋是否有剩余奖励
	x , y = util.findColor(0xdc080a, 90, 1445, 670, 1640, 705)--0:红色
	if x <= -1 then
		STEP_everyDay = 6 --安杰利卡特训屋任务头
		util.hudToast("发现特训屋有剩余奖励,开始特训")
		return 0
	end
	
	--查看女神的试炼是否有剩余奖励
	x , y = util.findColor(0xdc080a, 90, 1445, 973, 1640, 1010)--0:红色
	if x <= -1 then
		STEP_everyDay = 8 --女神的试炼任务头
		util.hudToast("发现试炼有剩余奖励,开始试炼")
		return 0
	end
	
	--翻页
	util.hudToast("翻页中...")
	util.move(1117,1100,1117,335)
	
	--查看宝藏是否有剩余钥匙
	if _G["baoZangFlag"] then
		x , y = util.findColor(0xdc080a, 90, 1445, 543, 1640, 580)--0:红色
		if x <= -1 then
			STEP_everyDay = 10 --逃跑的宝藏任务头
			util.hudToast("发现宝藏剩余钥匙,开始宝藏任务")
			return 0
		end
	end
	--查看羁绊之地是否有剩余奖励
	x , y = util.findColor(0xdc080a, 90, 1445, 841, 1640, 880)--0:红色
	if x <= -1 then
		STEP_everyDay = 12 --羁绊之地任务头
		util.hudToast("发现羁绊之地有剩余奖励,开始羁绊任务")
		return 0
	end
	
	util.hudToast("已经没有附带奖励的副本了")
	STEP_everyDay = util.ERROR_CODE --没有任务直接跳到最后
	_G["everyDayFinished"] = true
	
end

--1 手动任务选择器(无限任务用)
function func_chooseTarget()
	endlessMissionTarget = _G["endlessMission"]
	if endlessMissionTarget == 0 or endlessMissionTarget == 1 or endlessMissionTarget == 2 or endlessMissionTarget == 3 then
	--切换到日常界面
	util.click(2000,526)
	util.hudToast("选择日常任务")
	mSleep(500)
else
	--切换到日常界面
	util.click(2000,720)
	util.hudToast("选择限时任务")
	mSleep(500)
end


if endlessMissionTarget == 0 then
STEP_everyDay = 2--兄贵健身房任务头
elseif endlessMissionTarget == 1 then
STEP_everyDay = 6--安杰利卡特训屋任务头
elseif endlessMissionTarget == 2 then
STEP_everyDay = 8--女神的试炼任务头
elseif endlessMissionTarget == 3 then
--翻页
util.hudToast("翻页中...")
util.move(1117,1100,1117,335)
mSleep(250)
STEP_everyDay = 12 --羁绊之地任务头
elseif endlessMissionTarget == 4 then
STEP_everyDay = 14 --黑暗之契约书任务头
else
STEP_everyDay = util.ERROR_CODE
end

end

--2 兄贵任务
function func_xiongGui()
	util.click(1120,285)
	util.hudToast("点击兄贵健身房")
	STEP_everyDay = 3
end

--3 选择兄贵教练
function func_chooseJiaoLian()
	jiaoLianNum = _G["xiongGuiJiaoLian"]
	util.click(445,250+177*jiaoLianNum)
	util.hudToast("选择"..jiaoLianNameList[jiaoLianNum + 1].."训练")
	STEP_everyDay = 4
end

--4 选择等级
function func_chooseLevel()
	levelNum = _G["xiongGuiLevel"]
	times = levelNum
	if times > 8 then
		times = 8
	end
	moveUpTimes(times)
	
	if levelNum == 8 then--55级
		util.click(1830,472)
	elseif levelNum == 9 then--60级
		util.click(1830,771)
	elseif levelNum == 10 then--65级
		util.click(1830,1078)
	else--其他等级
		util.click(1830,380)
	end
	
	util.hudToast("选择"..levelList[levelNum+1].."级")
	
	if public.dealTiLiAlert() then
		STEP_everyDay = util.ERROR_CODE
		util.hudToast("体力不足,重试")
	else
		STEP_everyDay = 5
	end
	
end

--6 特训屋
function func_teXun()
	util.click(1120,596)
	util.hudToast("点击安杰利卡特训屋")
	STEP_everyDay = 7
end

--7 选择特训等级
function func_chooseTeXunLevel()
	levelNum = _G["texunLevel"]
	times = levelNum
	if times > 7 then
		times = 7
	end
	moveUpTeXunTimes(times)
	
	if levelNum == 7 then--50级
		util.click(1830,442)
	elseif levelNum == 8 then--55级
		util.click(1830,756)
	elseif levelNum == 9 then--60级
		util.click(1830,1067)
	else--其他等级
		util.click(1830,380)
	end
	
	
	util.hudToast("选择"..levelList[levelNum+1].."级")
	if public.dealTiLiAlert() then
		STEP_everyDay = util.ERROR_CODE
		util.hudToast("体力不足,重试")
	else
		STEP_everyDay = 5
	end
end

--8 女神试炼
function func_shiLian()
	util.click(1120,881)
	util.hudToast("点击女神的试炼")
	STEP_everyDay = 9
end

--9 选择女神试炼等级
function func_chooseShiLianLevel()
	levelNum = _G["shiLianLevel"]
	times = levelNum
	if times > 7 then
		times = 7
	end
	
	moveUpShiLianTimes(times)
	if levelNum == 7 then--55级
		util.click(1917,458)
	elseif levelNum == 8 then--60级
		util.click(1917,766)
	elseif levelNum == 9 then--65级
		util.click(1917,1073)
	else--其他等级
		util.click(1917,376)
	end
	
	util.hudToast("选择"..levelList[levelNum+2].."级")
	if public.dealTiLiAlert() then
		STEP_everyDay = util.ERROR_CODE
		util.hudToast("体力不足,重试")
	else
		STEP_everyDay = 5
	end
end

--10 宝藏
function func_baoZang()
	util.click(1120,465)
	util.hudToast("点击逃跑的宝藏")
	STEP_everyDay = 11
end

--11 选择宝藏等级
function func_chooseBaoZangLevel()
	levelNum = _G["baoZangLevel"]
	times = levelNum
	if times > 6 then
		times = 6
	end
	moveUpBaoZangTimes(times)
	if levelNum == 6 then--50级
		util.click(1845,540)
	elseif levelNum == 7 then--55级
		util.click(1845,800)
	elseif levelNum == 8 then--60级
		util.click(1845,1075)
	else--其他等级
		util.click(1845,357)
	end
	
	util.hudToast("选择"..levelList[levelNum+2].."级")
	if public.dealTiLiAlert() then
		STEP_everyDay = util.ERROR_CODE
		util.hudToast("体力不足,重试")
	else
		STEP_everyDay = 5
	end
end

--12 羁绊之地
function func_jiBan()
	util.click(1120,760)
	util.hudToast("点击羁绊之地")
	STEP_everyDay = 13
end

--13 选择羁绊之地等级
function func_chooseJiBanLevel()
	levelNum = _G["jiBanLevel"]
	times = levelNum
	if times > 6 then
		times = 6
	end
	moveUpJiBanTimes(times)
	if levelNum == 6 then--55级
		util.click(1910,457)
	elseif levelNum == 7 then--60级
		util.click(1910,772)
	elseif levelNum == 8 then--65级
		util.click(1910,1086)
	else--其他等级
		util.click(1910,373)
	end
	
	util.hudToast("选择"..levelList[levelNum+3].."级")
	if public.dealTiLiAlert() then
		STEP_everyDay = util.ERROR_CODE
		util.hudToast("体力不足,重试")
	else
		STEP_everyDay = 5
	end
end

--14 限时任务3(当前为:黑暗之契约书-波赞鲁)
function func_timeLimitMission3()
	util.click(1120,880)
	util.hudToast("点击黑暗之契约书")
	STEP_everyDay = 15
end

--15 选择限时任务3等级
function func_chooseTimeLimitMission3Level()
	levelNum = _G["timeLimit3Level"]
	
	if levelNum == 0 then
		util.click(1845,397)
	elseif levelNum == 1 then
		util.click(1845,660)
	elseif levelNum == 2 then
		util.click(1845,920)
	else
		util.click(1845,397)
	end
	
	util.hudToast("选择"..levelList[2*levelNum+5].."级")
	if public.dealTiLiAlert() then
		STEP_everyDay = util.ERROR_CODE
		util.hudToast("体力不足,重试")
	else
		STEP_everyDay = 5
	end
	
end

--5 自动游戏中检测
function func_playingGame()
	util.hudToast("自动游戏中...")
	mSleep(1500)
	if public.playing_game() then
		--不可能ture
	else
		STEP_everyDay = util.ERROR_CODE;
		util.hudToast("自动游戏结束")
	end
end

--------------------------领取奖励--------------------------
--0 初始化界面位置
function func_startInit()
	public.func_start_init()
	STEP_receiveAward = 1
end

--1 查看是否有可领取的奖励
function func_checkAward()
	util.hudToast("准备领取奖励")
	util.click(1228,1147)
	STEP_receiveAward = 2
end

--2 循环领取奖励
function func_receiveAwardTimeByTime()
	x , y = util.findColor(0x3adcf3, 90, 1473, 243, 1738, 306)--领取任务:蓝色
	x1 , y1 = util.findColor(0xc60017, 90, 1473, 243, 1738, 306)--已领取:红色
	if x > -1 and x1 <= -1 then
		util.hudToast("领取奖励")
		util.click(1600,272)--点击领取
		mSleep(1000)
		public.clickLocation()--点击空白
		mSleep(500)
		public.clickLocation()--多点击一次,防止升级提示出现
		mSleep(500)
		func_receiveAwardTimeByTime()
	else
		util.hudToast("奖励领取完毕")
		STEP_receiveAward = util.ERROR_CODE
	end
end
--------------------------主任务--------------------------
--领取奖励
function everyday.receiveAward()
	mSleep(500)
	if STEP_receiveAward == 0 then
		func_startInit()
		everyday.receiveAward()
	elseif STEP_receiveAward == 1 then
		func_checkAward()
		everyday.receiveAward()
	elseif STEP_receiveAward == 2 then
		public.waitUntilViewDidAppear()
		func_receiveAwardTimeByTime()
		everyday.receiveAward()
	elseif STEP_receiveAward == util.ERROR_CODE then
		STEP_receiveAward = 0
		public.closeMenuIfNecessary()
	end
end

--每日任务
function everyday.everyday_main()
	mSleep(1000)
	if STEP_everyDay == 0 then
		func_clickMiJing()
		everyday.everyday_main()
	elseif STEP_everyDay == 1 then--任务选择器
		public.waitUntilViewDidAppear()
		func_autoChooseTarget()
		everyday.everyday_main()
	elseif STEP_everyDay == 2 then --兄贵:任务开始
		func_xiongGui()
		everyday.everyday_main()
	elseif STEP_everyDay == 3 then --兄贵:选择教练
		public.waitUntilViewDidAppear()
		func_chooseJiaoLian()
		everyday.everyday_main()
	elseif STEP_everyDay == 4 then --兄贵:选择等级
		func_chooseLevel()
		everyday.everyday_main()
	elseif STEP_everyDay == 6 then --特训屋:任务开始
		func_teXun()
		everyday.everyday_main()
	elseif STEP_everyDay == 7 then --特训屋:选择等级
		public.waitUntilViewDidAppear()
		func_chooseTeXunLevel()
		everyday.everyday_main()
	elseif STEP_everyDay == 8 then --女神试炼:任务开始
		func_shiLian()
		everyday.everyday_main()
	elseif STEP_everyDay == 9 then --女神试炼:选择等级
		public.waitUntilViewDidAppear()
		func_chooseShiLianLevel()
		everyday.everyday_main()
	elseif STEP_everyDay == 10 then --宝藏:任务开始
		func_baoZang()
		everyday.everyday_main()
	elseif STEP_everyDay == 11 then --宝藏:选择等级
		public.waitUntilViewDidAppear()
		func_chooseBaoZangLevel()
		everyday.everyday_main()
	elseif STEP_everyDay == 12 then --羁绊:任务开始
		func_jiBan()
		everyday.everyday_main()
	elseif STEP_everyDay == 13 then --羁绊:选择等级
		public.waitUntilViewDidAppear()
		func_chooseJiBanLevel()
		everyday.everyday_main()
	elseif STEP_everyDay == 5 then --自动游戏中
		func_playingGame()
		everyday.everyday_main()
	elseif STEP_everyDay == util.ERROR_CODE then
		STEP_everyDay = 0
		public.closeMenuIfNecessary()
	end
end

--无限任务
function everyday.endlessMission()
mSleep(500)
if STEP_everyDay == 0 then
	func_clickMiJing()
	everyday.endlessMission()
elseif STEP_everyDay == 1 then--任务选择器
	public.waitUntilViewDidAppear()
	func_chooseTarget()
	everyday.endlessMission()
elseif STEP_everyDay == 2 then --兄贵:任务开始
	func_xiongGui()
	everyday.endlessMission()
elseif STEP_everyDay == 3 then --兄贵:选择教练
	public.waitUntilViewDidAppear()
	func_chooseJiaoLian()
	everyday.endlessMission()
elseif STEP_everyDay == 4 then --兄贵:选择等级
	func_chooseLevel()
	everyday.endlessMission()
elseif STEP_everyDay == 6 then --特训屋:任务开始
	func_teXun()
	everyday.endlessMission()
elseif STEP_everyDay == 7 then --特训屋:选择等级
	public.waitUntilViewDidAppear()
	func_chooseTeXunLevel()
	everyday.endlessMission()
elseif STEP_everyDay == 8 then --女神试炼:任务开始
	func_shiLian()
	everyday.endlessMission()
elseif STEP_everyDay == 9 then --女神试炼:选择等级
	public.waitUntilViewDidAppear()
	func_chooseShiLianLevel()
	everyday.endlessMission()
elseif STEP_everyDay == 10 then --宝藏:任务开始
	func_baoZang()
	everyday.endlessMission()
elseif STEP_everyDay == 11 then --宝藏:选择等级
	public.waitUntilViewDidAppear()
	func_chooseBaoZangLevel()
	everyday.endlessMission()
elseif STEP_everyDay == 12 then --羁绊:任务开始
	func_jiBan()
	everyday.endlessMission()
elseif STEP_everyDay == 13 then --羁绊:选择等级
	public.waitUntilViewDidAppear()
	func_chooseJiBanLevel()
	everyday.endlessMission()
elseif STEP_everyDay == 14 then --限时3:任务开始
	func_timeLimitMission3()
	everyday.endlessMission()
elseif STEP_everyDay == 15 then --限时3:选择等级
	public.waitUntilViewDidAppear()
	func_chooseTimeLimitMission3Level()
	everyday.endlessMission()
elseif STEP_everyDay == 5 then --自动游戏中
	func_playingGame()
	everyday.endlessMission()
elseif STEP_everyDay == util.ERROR_CODE then
	STEP_everyDay = 0
	public.closeMenuIfNecessary()
end
end

--private function
function moveUpTimes(times)
	util.hudToast("翻页中...")
	for i = 1 , times , 1 do
		util.move(940,930,940,600)
		mSleep(250)
	end
end

function moveUpTeXunTimes(times)
	util.hudToast("翻页中...")
	for i = 1 , times , 1 do
		util.move(940,938,940,600)
		mSleep(250)
	end
end

function moveUpShiLianTimes(times)
	util.hudToast("翻页中...")
	for i = 1 , times , 1 do
		util.move(1600,935,1600,600)
		mSleep(250)
	end
end

function moveUpBaoZangTimes(times)
	util.hudToast("翻页中...")
	for i = 1 , times , 1 do
		util.move(1600,890,1600,600)
		mSleep(250)
	end
end

function moveUpJiBanTimes(times)
	util.hudToast("翻页中...")
	for i = 1 , times , 1 do
		util.move(1600,935,1600,600)
		mSleep(250)
	end
end

return everyday