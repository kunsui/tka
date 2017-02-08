﻿全局设定 = {
    -- 当需要检查当前界面是否在某个状态时，多长时间检查一次。（单位：毫秒）
    状态检查间隔 = 200,
    -- 当需要检查当前界面是否在某个状态时，最多检查多久。0为永不言弃（笑）（单位：毫秒）
    状态检查超时 = 12000,
    -- 为了让脚本的行为更自然，在某些操作后附加一些随机的延迟。（单位：毫秒）
    操作延时上限 = 600,
}
require("日课")
require("Sakura+")
require("EqptAdd")
require("AutoHeal")

-------------------------------------------------------------------------------------
--[[战斗设定]]
-------------------------------------------------------------------------------------
max_count = 1
--脚本循环次数

script = ".\\Lua\\简易花札_1.3_20170131_test2.lua"
--要运行的脚本，可调用活动的脚本
--从例子里新建，路径一般就是".\\Lua\\xxxxx.lua"，详细设定到该脚本里设置

-------------------------------------------------------------------------------------
--[[远征设定]]
-------------------------------------------------------------------------------------
easy_expedition = true
--远征开关

--远征时代
k2_conquest = {2,4} --第2队伍
k3_conquest = {3,2} --第3队伍
k4_conquest = {5,1} --第4队伍

--远征多长时间检测一遍
time1 = 60*5 --时间间隔最小(秒)
time2 = 60*10 --时间间隔最大(秒)

--如果开启远征，出击次数达到后会进入远征循环，顺便修刀:1擦伤，2轻伤，4中伤，8重伤
repair_type = 15 --手入的刀损坏类型(多选相加)
speed_type = 8 --使用加速的刀损坏类型，同上

-------------------------------------------------------------------------------------
--[[日课设定]]
-------------------------------------------------------------------------------------
daily_switch = 7
--日课开关，0不做，1刀解，2锻刀，4炼结，多选相加

delete_time = 2 --刀解次数
delete_star = 3 --解几花及其以下的刀，特殊欧刀无特别处理(比如3花小狐丸)还是请注意锁刀！

smith_time = 2 --锻刀次数
smith_recipe = {50,50,50,50} --锻刀配方{木炭，玉钢，冷却，砥石}

fusion_time = 2 --錬結次数
fusion_star = 3 --錬結几花及其以下的刀，同上请注意锁刀！

-------------------------------------------------------------------------------------
--[[刷花设定]]
-------------------------------------------------------------------------------------
init = 2
--第一次运行先刷花：0不刷，1都刷，2检测状态刷

auto_sakura = true
--自动刷花开关，在筛选范围和页数范围内的刀会被拖去1_1心理治疗，远征手入中的会被跳过

check_status = true
--true：检测是否樱吹雪，没有花就拖去刷;  false：不检测，都拖去刷

max_11 = 3
--出1_1击次数

筛选范围 = 9
--0全部，1短，2胁，3打，4太，5大太，6枪，7薙，8刀装，9马，10守

页数范围 = 0
--翻到第几页，0翻到最后

部队结成筛选范围={
  --刷完花后重新结成原先的队伍，设置范围寻找要出阵的刀
  --0全部，1短，2胁，3打，4太，5大太，6枪，7薙，8刀装，9马，10守
    [1] = {9}, --部队一
    [2] = {10},--部队二
    [3] = {10},--部队三
    [4] = {10},--部队四
}

-------------------------------------------------------------------------------------
--[[手入设定]]
-------------------------------------------------------------------------------------
insta_heal_nonstop = false
--重伤后不停止脚本，自动加速手入重伤刀
--连队和花札活动一般没有真实伤害

bed_count = 2
--床位，最低1，最高4

----------------------------

loop_heal = false
--每次出阵前手入受伤刀，如果不用加速可能会没空床位无法手入或者手入中的刀没法出阵

instant_heal = false
--是否加速

heal_level = 3
--伤的多重才送去手入，1擦伤，2轻伤，3中伤，4重伤（请不要填别的数字）

-------------------------------------------------------------------------------------
--[[刀装设定]]
-------------------------------------------------------------------------------------
auto_equipment = false
--出阵前检测补充刀装，没刀装补充会做一次，还是无法补充就停止出击
--连队和花札活动一般没有真实伤害

预设策略 = {
    --策略模板：策略名1 = {{"种类1","质量1"},{"种类2","质量2"},},
    --顺序越前的刀装优先级越高
    --注意括号、逗号不能少，还有繁体字建议复制
	
    --种类：投石兵 槍兵 軽歩兵 重歩兵 盾兵 軽騎兵 重騎兵 精鋭兵 弓兵 銃兵
    --质量：特上 上 並
    轻骑 = {{"軽騎兵","上"},{"軽騎兵","並"},{"軽騎兵","特上"},},
	轻步 = {{"軽歩兵","上"},{"軽歩兵","並"},{"軽歩兵","特上"},},
	重骑 = {{"重騎兵","上"},{"重騎兵","並"},{"重騎兵","特上"},},
	重步 = {{"重歩兵","上"},{"重歩兵","並"},{"重歩兵","特上"},},
	精锐 = {{"精鋭兵","上"},{"精鋭兵","並"},{"精鋭兵","特上"},},
	投石 = {{"投石兵","上"},{"投石兵","並"},{"投石兵","特上"},},
	弓 = {{"弓兵","上"},{"弓兵","並"},{"弓兵","特上"},},
	铳 = {{"銃兵","上"},{"銃兵","並"},{"銃兵","特上"},},
	枪 = {{"槍兵","上"},{"槍兵","並"},{"槍兵","特上"},},
	盾 = {{"盾兵","上"},{"盾兵","並"},{"盾兵","特上"},},
	--上面的是例子
	
	枪重步轻步={
	{"槍兵","上"},{"槍兵","並"},{"槍兵","特上"},
	{"軽歩兵","上"},{"軽歩兵","並"},{"軽歩兵","特上"},
	{"重歩兵","上"},{"重歩兵","並"},{"重歩兵","特上"},
	},
	重步轻步={
	{"軽歩兵","上"},{"軽歩兵","並"},{"軽歩兵","特上"},
	{"重歩兵","上"},{"重歩兵","並"},{"重歩兵","特上"},
	},
	重骑轻骑={
	{"軽騎兵","上"},{"軽騎兵","並"},{"軽騎兵","特上"},
	{"重騎兵","上"},{"重騎兵","並"},{"重騎兵","特上"},
	},
}

补充刀装设定 = {	
    -- 策略就是上面预设好的策略
    [1] = {
        策略 = "轻骑",
        允许补充任意刀装 = false,
    },
    [2] = {
        策略 = "轻步",
        允许补充任意刀装 = false,
    },
    [3] = {
        策略 = "轻步",
        允许补充任意刀装 = false,
    },
    [4] = {
        策略 = "轻步",
        允许补充任意刀装 = false,
    },
    [5] = {
        策略 = "轻步",
        允许补充任意刀装 = false,
    },
    [6] = {
        策略 = "轻步",
        允许补充任意刀装 = false,
    },
}

制作刀装设定 = {
    --用同一个配方一直搓满为止
    木炭 = 50,
    玉钢 = 50,
    冷却 = 50,
    砥石 = 50,
}

删除刀装 = 2
--0不删除，1删轻步兵，2删轻骑兵，暂时没别的选项，会留下特上，比较浪费资源看个人需要

-------------------------------------------------------------------------------------









-------------------------------------------------------------------------------------

if IsDmmunlocker() then
    Win.Print("坐标无法对应，脚本无法运行")
end

Tou.GoHome()

if insta_heal_nonstop == true then
	Win.Print("现在重伤后不停止脚本，自动加速手入重伤刀，请保证加速足够，要不会有碎刀危险")
	Win.Pop("现在重伤后不停止脚本，自动加速手入重伤刀，请保证加速足够，要不会有碎刀危险")
end

if daily_switch ~= 0 then
    Win.Print("拆刀喂刀请注意锁刀！")
	Win.Pop("拆刀喂刀请注意锁刀！")
    if daily_switch~=4 and daily_switch~=2 and 6 then Delete() end
    if daily_switch~=4 and daily_switch~=1 and 5 then Smith() end
    if daily_switch>=4 then Fusion() end
end

if init == 0 then
elseif init == 1 then 刷花(false,AutoEquipment)
elseif init == 2 then 刷花(true,AutoEquipment)
end

if easy_expedition then
	Tou.EasyConquestInit(time1,time2)
	Tou.EasyConquestRun(false)
end

for n = 1, max_count do --循环次数

   	Win.Print("开始第:"..n.."次")
	
	if loop_heal then
        AutoHealMain(bed_count, heal_level, instaheal)
	end
	
	if auto_equipment then AutoEquipment()
	    if Equipment == false then
	        Win.Print("---------没有可用刀装，停止脚本---------")
	        break
	    end
	end
	
	dofile(script)
	
	if auto_sakura then
	    if n%interval == 0 then 刷花(check_status, AutoEquipment) end
    end
	
end

Task()
Win.Print("---------出阵结束，进入远征循环---------")
Tou.EasyConquestEnterLoop(Tou.Repair(10,repair_type,speed_type))
Win.Pop('执行完毕！')



--运行主体
--v2.4 添加日课，优化结构
--v2.3 修改初始刷花逻辑
--v2.2 梳理各部分逻辑顺序
--v2.1 远征改用Tou封装函数
--v2.0 整合各系统 出阵+远征+手入+刀装+刷花