--[[
    desc:金玉满堂
    auth:Carol Luo
]]

local math = math
local table = table
local pairs = pairs
local ipairs = ipairs
local class = require("class")
local ifNumber = require("ifNumber")
local ifNumber = require("ifNumber")
local slotsLogic = require("slots.logic")
---@class jymtLogic:slotsLogic
local logic = class(slotsLogic)
local this = logic

---构造 
function logic:ctor()
end

---正常摇奖
---@return slots_result_normal
function logic:rotateNormal()
    ---@type jymt_result_normal     @普通转结果
    local result = self:super(this,"rotateNormal")
    ---@type slots_score[]          @重转成本
    result.heavyCost = self:getHeavyCost(result)
    return result
end


---连线结果
---@param result slots_result_normal
---@return slots_full_path[]
function logic:getLineList(result)
    local icons = result.icon_list
    ---@type slots_axlels                            @轴图标统计
    local axles,icons = self:getAxlesIons(icons)
    ---@type slots_full_path[]                       @满线路径表
    local full_paths = {nil}

    ---@type slots_icon                              @wild图标
    local wcion = self:getWildID()
    ---@type table<leng,slots_base>                  @图标倍数
    local ibase = self:getLineBases()
    ---@type slots_score                             @单线下注
    local sbets = self:getLineBet()        
    ---开始图标
    for icon,_ in pairs(icons) do
        --普通图标-(scatter|wild-不参与)
        if not self:isNormal(icon) then
            ---@type count          @线数量
            local icnt = 0
            ---@type leng           @线长度
            local ilen = 0
            --数量统计
            for jx,js in ipairs(axles) do
                --当前轴此图标数量
                local jxcnt = (axles[jx][icon] or 0) + (axles[jx][wcion] or 0)

                if jxcnt > 0 then
                    --未中断
                    icnt = icnt * jxcnt
                    ilen = jx
                else
                    --已中断
                    local base = ibase[icon][ilen]
                    if base <= 0 then
                        break
                    end

                    --是重转
                    if self:isRotateAxle() then
                        local axle = self:getCurAxle()
                        if axle > ilen then
                            break
                        end
                    end

                    ---@type slots_base         @算倍数
                    base = base * icnt

                    ---@type slots_score        @算分数
                    local score = base * sbets


                    ---@type slots_icon_post[]  @算路线
                    local place = {nil}

                    for kpost,kicon in ipairs(icons) do
                        --检查转轴
                        local kx = ((kpost-1)//5) + 1
                        if kx <= ilen then
                            --检查图标
                            if icon == kicon or self:isWild(kicon) then
                                table.insert(place,{
                                    icon = kicon,
                                    post = kpost,
                                })
                            end
                        end
                    end

                    --结算中
                    table.insert(full_paths,{
                        line_icon   = icon,           --连线图标
                        line_again  = base,           --连线倍数
                        line_score  = score,          --连线分数
                        path_place  = place,          --连线图标
                    })
                end
            end
        end
    end

    ---是免费
    if self:isRotateFree() then
        local cfg = self:getGameConf()
        ---@type base
        local double = cfg.free_double
        for _,item in ipairs(full_paths) do
            item.line_again = item.line_again * double
            item.line_score = item.line_score * double
        end
    end

    return full_paths
end


local expect1
local expect2
---转一次免费期望
function logic:getFreeBudgeExpect()
    if not expect1 then
        ---@type jymtTable             @桌子
        local game = self._competition
        ---@type jymtAlgor             @算法
        local agor = self._competition._gor
        ---@type slots_wight_info[]     @免费概率表
        local fwgt = game:getFreeIconWeights()
        ---@type slots_icon             @免费图标ID
        local ficn = self:getScatterID()
        ---@type slots_icon             @wild图标ID
        local wicn = self:getScatterID()
        ---@type slots_icons            @所有图标名
        local iname = self:getIconNames()
        ---@type slots_axlepro[][]      @图标轴概率
        local xPro = table.default_zero{nil}
        for x=1,5 do
            local axle = fwgt[x]
            local sWgt = axle.sum
            local wgts = axle.wgt
            local fWgt = axle.wgt[ficn]
            local wWgt = axle.wgt[wicn]
            xPro[x][ficn] = agor.scatterAxlePro(fWgt,axle.sum)
            xPro[x][wicn] = agor.wildAxlePro(wWgt,axle.sum,wgts[ficn])
            for _icon,_ in pairs(iname) do
                if self:isNormal(_icon) then
                    xPro[x][_icon] = agor.normatAxlePro(wgts[_icon],wWgt,fWgt,axle.sum,xPro[x][ficn])
                end
            end
        end

        ---@type slots_axlepro[][]      @345连概率
        local lPro = table.default_zero{nil}
        for _icon,_ in ipairs(iname) do
            local _lis = table.default_zero{nil}
            lPro[_icon] = _lis
            local I,J,K,L,M = xPro[1][_icon],xPro[2][_icon],xPro[3][_icon],xPro[4][_icon],xPro[5][_icon]
            do
                if not self:is_Scatter(_icon) then
                    _lis[3] = (I*J*K*(1-L)^3)*3^3
                else
                    _lis[3] = I*J*K+I*J*L+I*J*M+I*K*L+I*K*M+I*L*M+J*K*L+J*K*M+J*L*M+K*L*M
                end
                _lis.sum = _lis.sum + _lis[3]
            end
            do
                if not self:is_Scatter(_icon) then
                    _lis[4] = I*J*K*L*(1-M)^3*3^4
                else
                    _lis[4] = I*J*K*L+I*J*K*M+I*J*L*M+I*K*L*M+J*K*L*M
                end
                _lis.sum = _lis.sum + _lis[4]
            end
            do--5连概率都一样
                if not self:is_Scatter(_icon) then
                    _lis[5] = I*J*K*L*M*3^5
                else
                    _lis[5] = I*J*K*L*M
                end
                _lis.sum = _lis.sum + _lis[5]
            end
            lPro.sum = lPro.sum + _lis.sum
        end

        ---@type slots_base[][]     @连线倍数表
        local lbes = self:getLineBases()
        ---@type slots_loss[][]     @345赔率
        local loss = table.default_zero{nil}
        for _icon,_ in pairs(iname) do
            local _lis = table.default_zero{nil}
            for _len = 3,5 do
                _lis[_len] = lPro[_icon][_len]*lbes[_icon][_len]
                _lis.sum = _lis.sum + _lis[_len]
            end
            loss.sum = loss.sum + _lis.sum
        end
        ---@type slots_expect   @免费进免费期望
        local fefExpect = 0
        local scatter_free = self.config.scatter_free
        for _len,_pro in pairs(lPro[ficn]) do
            if ifNumber(_len) then
                fefExpect = fefExpect + (_pro * scatter_free[_len])
            end
        end
        --保存期望-免费转收益期望
        expect1 = loss.sum
        --保存期望-免费进入免费期望
        expect2 = fefExpect
    end
    return expect1
end

---免费进入免费期望
function logic:getFreeBudgeEnter()
    if not expect2 then
        self:getFreeBudgeExpect()
    end
    return expect2
end


---计算轴期望
---@param result jymt_result_normal
---@return double
function logic:getAxleBudgeExpect(result)
    ---@type jymtAlgor             @金玉满堂
    local algor = self._competition._gor
    ---@type postx                  @重转转轴x
    local axle_xpost  = self:getCurAxle()
    ---@type slots_icon             @wild图标
    local wild_icon   = self:getWildID()
    ---@type slots_icon             @免费图标
    local free_icon   = self:getScatterID()
    ---轴图标统计
    local icons = result.icon_list
    local axles = self:getAxlesIons(icons)
    ---@type table<slots_icon,name> @所有图标名
    local icon_names  = self:getIconNames()
    ---@type slots_wight_info       @轴图标权重
    local axle_wight  = self:getAxleIconWeithts()
    ---@type slots_weight           @轴全部权重
    local summ_wight  = axle_wight.sum
    ---@type slots_weight           @轴wild权重
    local wild_wight  = self:getAxleWeithtBy(axle_xpost,wild_icon)
    ---@type slots_weight
    local free_wight  = self:getAxleWeithtBy(axle_xpost,free_icon)
    ---@type slots_expect           @轴免费期望
    local axleFreeExect = algor:scatterAxlePro(free_wight,summ_wight)
    ---@type slots_base[][]         @连线倍数
    local line_bases    = self:getLineBases()

    ---@type slots_expect           @重转期望
    local axle_expect   = 0
    --遍历所有图标
    for icon,iname in ipairs(icon_names) do
        --普通图标-(scatter|wild-不参与)
        if not self:isNormal(icon) then
            ---@type slots_weight       @轴普通权重
            local nWgt = axle_wight.wgt[icon]

            local wWgt,fWgt,sWgt,fPro = wild_wight,free_wight,summ_wight,axleFreeExect
            ---@type slots_expect       @轴普通期望
            local axleNormExect = algor:normatAxlePro(nWgt,wWgt,fWgt,sWgt,fPro)
            ---@type count          @线数量
            local icnt = 0
            ---@type leng           @线长度
            local ilen = 0
            --数量统计
            for jx,js in ipairs(axles) do
                --当前轴此图标数量
                local jxcnt = (axles[jx][icon] or 0) + (axles[jx][wild_icon] or 0)
                if jx == axle_xpost then
                    --重转轴每个图标1个-这里不考虑wild
                    jxcnt = 1
                end

                if jxcnt > 0 then
                    --未中断
                    ilen = jx
                else
                    --已中断
                    local base = line_bases[icon][ilen]
                    if base <= 0 then
                        break
                    end

                    --是重转
                    if axle_xpost > ilen then
                        break
                    end

                    ---@type slots_base         @算倍数
                    base = base * icnt

                    ---@type slots_expect       @算期望
                    local expect = base * axleNormExect

                    axle_expect = axle_expect + expect
                end
            end
        end
    end

    ---重转免费期望-(免费中无法重转-只有scatter奖励会影响)
    local function axleFreeExpect(scatterCNT)
        ---@type slots_double           @scatter图标倍数
        local scatterDOE     = line_bases[free_icon][scatterCNT] or 0

        ---@type slots_count[]          @增加免费配置
        local freeCounts     = self:getScatterFrees()

        ---@type slots_count            @增加免费次数
        local addFreeCNT     = freeCounts[freeCounts] or 0

        ---@type slots_expect           @免费进免费期望-一次
        local freeEfree      = addFreeCNT * freeCounts

        ---@type slots_expect           @免费进免费期望-所有
        local freeAfree     = freeEfree/(1-self.getFreeBudgeEnter())

        return freeAfree
    end

    ---@type slots_count            @scatter图标数量
    local scatterCNT     = 0
    for iaxle,ilist in ipairs(axles) do
        if axle_xpost ~= iaxle then
            --重转
            scatterCNT = scatterCNT + 1
        else
            --正常
            scatterCNT = scatterCNT + (ilist[free_icon] or 0)
        end
    end

    ---@type slots_expect   @重转有scatterCNT 期望
    local axleFreeExpect1 = axleFreeExpect(scatterCNT)
    ---@type slots_expect   @重转无scatterCNT 期望
    local axleFreeExpect2 = axleFreeExpect(scatterCNT-1)
    ---@type slots_expect   @求差值scatterCNT 期望
    local axleFreeExpect3 = axleFreeExpect1 - axleFreeExpect2
    ---@type slots_expect   @真实期望
    local axleFreeExpect4 = axleFreeExpect2 + (axleFreeExpect3*axleFreeExect)
    ---@type slots_expect   @免费期望 
    local axleFreeExpect5 = axleFreeExpect4 * self:getFreeBudgeExpect()

    axle_expect = axle_expect + axleFreeExpect5

    return axle_expect
end

return logic