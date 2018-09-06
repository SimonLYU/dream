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
						
						["type"] = "RadioGroup",
						["id"] = "MissionRadioGroup",
						["list"] = "每日任务副本一条龙,指定副本无限刷",
						["select"] = "0"	,
						["color"] = "255,255,255",
					},
					
					{
						["type"] = "Label",
						["text"] = "无限刷副本:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "EndlessMissionComboBox",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "兄贵健身房,安杰利卡特训屋等级,女神的试炼,羁绊之地",
						["color"] = "255,108,88",
						["select"] = "0"
					},
				}
			},
			{
				["type"] = "Page",
				["text"] = "副本等级设置",
				["views"] = {
					{
						["type"] = "Label",
						["text"] = "兄贵健身房教练和等级:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "JiaoLianComboBox",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "安东(步兵),琼斯(弓刺),巴兰(枪兵),洛基(飞水),萨姆森(骑兵),尼姆(僧侣)",
						["color"] = "255,108,88",
						["select"] = "1"
					},
					{
						["id"] = "XiongGuiComboBox",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "15,20,25,30,35,40,45,50,55,60,65",
						["color"] = "255,108,88",
						["select"] = "6"
					},
					{
						["type"] = "Label",
						["text"] = "安杰利卡特训屋等级:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "TeXunComboBox",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "15,20,25,30,35,40,45,50,55,60",
						["color"] = "255,108,88",
						["select"] = "6"
					},
					{
						["type"] = "Label",
						["text"] = "女神的试炼等级:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "ShiLianComboBox",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "20,25,30,35,40,45,50,55,60,65",
						["color"] = "255,108,88",
						["select"] = "5"
					},
					{
						["type"] = "Label",
						["text"] = "逃跑的宝藏等级:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "BaoZangCheckBoxGroup",
						["type"] = "CheckBoxGroup",
						["size"] = 20,
						["list"] = "开启自动副本<逃跑的宝藏>(自动可能会降低收益 开启后 等级设置才会生效)",
						["select"] = "",
						["color"] = "255,255,255",
					},
					{
						["id"] = "BaoZangComboBox",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "20,25,30,35,40,45,50,55,60",
						["color"] = "255,108,88",
						["select"] = "5"
					},
					{
						["type"] = "Label",
						["text"] = "羁绊之地等级:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "JiBanComboBox",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "25,30,35,40,45,50,55,60,65",
						["color"] = "255,108,88",
						["select"] = "4"
					},
				}
			},
			{
				["type"] = "Page",
				["text"] = "副本等级设置",
				["views"] = {
					{
						["type"] = "Label",
						["text"] = "自动补充体力:",
						["size"] = 40,
						["align"] = "left",
						["color"] = "255,108,88",
					},
					{
						["id"] = "TiLiComboBox",
						["type"] = "ComboBox",
						["size"] = 40,
						["list"] = "不补充,面包补充,钻石补充",
						["color"] = "255,108,88",
						["select"] = "0"
					},
				}
			}
		}
	}
	return uiTable
end

return ui