require "util"
require "public"
STEP_everyDay = 0

TARGET = 0

everyday = {}

--点击秘境
function func_clickMiJing()
	util.click(2123,406)
	util.hudToast("点击秘境")
	STEP_everyDay = 1
end

--任务选择器
function func_autoChooseTarget()

end


function everyday.everyday_main()
	mSleep(1000)
	if STEP_everyDay == 0 then
		func_clickMiJing()
		everyday.everyday_main()
	elseif STEP_everyDay == 1 then--任务选择器
		func_autoChooseTarget()
		everyday.everyday_main()
	elseif STEP_everyDay == util.ERROR_CODE then
		STEP_everyDay = 0
	end
end

return everyday