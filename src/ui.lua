ui = {}

function ui.configUI()
	
	alert_width = 700
	alert_height = 900
	screen_width,screen_height = getScreenSize()
	if screen_width < alert_width then
		alert_width = screen_width - 40
	end
	if screen_height < alert_height then
		alert_height = screen_height - 40
	end
	
	uiTable = {
		["style"] = "default",
		["width"] = alert_height,
		["height"] = alert_width,
		["config"] = "save_001.dat",
		["bg"] = "bg.png",
		["okname"] = "确定",
		["cancelname"] = "取消",
		["views"] = {
			{
				["type"] = "Page",
				["text"] = "总设置",
				["views"] = {
					{
						["type"] = "Label",
						["text"] = "tip:没有做屏幕适配,只支持iphone7Plus/6Plus/6sPlus,更多功能即将上线",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "ps:脚本开启后请勿手动操作,可能会导致脚本卡住!!",
						["size"] = 25,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["type"] = "Label",
						["text"] = "基本功能",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "CheckBoxGroup1",
						["type"] = "CheckBoxGroup",
						["size"] = 40,
						["list"] = "每日任务",
						["select"] = "0",
						["color"] = "255,255,255",
					},
				}
			},
		}
	}
	return uiTable
end

return ui