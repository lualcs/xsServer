--[[
    file:slotsLogic.lua 
    desc:slots逻辑
    auth:Caorl Luo
]]
local ipairs = ipairs
local math = math
local sort = require("extend_sort")
local table = require("extend_table")
local class = require("class")
local gameLogic = require("gameLogic")
local slotsEnum = require("slotsEnum")
---@class slotsLogic:gameLogic
local slotsLogic = class(gameLogic)

---构造
---@param gameTable slotsTable
function slotsLogic:ctor(gameTable)
    ---@type slotsTable
    self._table = self._table
end

---满线
---@return boolean
function slotsLogic:isFull()
    ---@type slots_inf @slots信息
    local inf = self:getGameInfo()
    return inf.fulllin
end

---双向
---@return boolean
function slotsLogic:isBothway()
    ---@type slots_inf @slots信息
    local inf = self:getGameInfo()
    return inf.bothway
end

--普通
---@param icon slots_icon @图标
---@return boolean
function slotsLogic:isNormal(icon)
    return not self:isWild(icon) and not self:isScatter(icon)
end

---scatter
---@param icon slots_icon @图标
---@return boolean
function slotsLogic:isScatter(icon)
    return icon == self:getScatterID()
end

---wild
---@param icon slots_icon @图标
---@return boolean
function slotsLogic:isWild(icon)
    return icon == self:getWildID()
end

---免费
---获取重转轴
---@return boolean
function slotsLogic:isRotateFree()
    local player = self:getCurPlayer()
    local quest  = player:getRequest()
    local rota = slotsEnum.rotateFree()
    local scmd = table.lastBy(quest.channel)
    if rota ~= scmd then
        return false
    end
    return true
end

---普通
---获取重转轴
---@return boolean
function slotsLogic:isRotateNormal()
    local player = self:getCurPlayer()
    local quest  = player:getRequest()
    local rota = slotsEnum.rotateNormal()
    local scmd = table.lastBy(quest.channel)
    if rota ~= scmd then
        return false
    end
    return true
end

---重转
---获取重转轴
---@return boolean
function slotsLogic:isRotateAxle()
    local player = self:getCurPlayer()
    local quest  = player:getRequest()
    
    local rota = slotsEnum.rotateRoller()
    local scmd = table.lastBy(quest.channel)
    if rota ~= scmd then
        return false
    end
    return true
end

---名字 
---@return table<slots_icon,name>
function slotsLogic:getIconNames()
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return cfg.icon_names
end

---阶段
---@return slots_base[]
function slotsLogic:getStageLevels()
     ---@type slots_cfg
     local cfg = self:getGameConf()
     return cfg.stageLevels
end

---scatter免费次数
---@return table<count,count>
function slotsLogic:getScatterFrees()
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return cfg.scatter_free
end

---jetton下注配置
---@return slots_jetton[]
function slotsLogic:getJettonPairs()
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return cfg.jetton_pair
end

---路径配置
---@return slots_post[][]
function slotsLogic:getLinePath()
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return cfg.line_paths
end

---图标倍数
---@return table<leng,slots_base>
function slotsLogic:getLineBases()
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return cfg.line_bases
end

---scatter图标
---@return slots_icon
function slotsLogic:getScatterID()
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return cfg.scatter_icon
end

---wild图标
---@return slots_icon
function slotsLogic:getWildID()
    ---@type slots_cfg
    local cfg = self:getGameConf()
    return cfg.wild_icon
end

---获取唯一配置
---@return slots_icon[]
function slotsLogic:getSoleIcon()
    return self._table:getSoleIcon()
end

---获取游戏布局
---@return slots_layout_info
function slotsLogic:getLayoutInfo()
    return self._table:getLayoutInfo()
end

---获取使用权重
---@return slots_wight_info[]
function slotsLogic:getRunIconWeithts()
    return self._table:getRunIconWeithts()
end

---获取转轴权重
---@param x number @转轴
---@return slots_wight_info
function slotsLogic:getAxleIconWeithts(x)
    local wgts = self:getRunIconWeithts()
    return wgts[x]
end

---获取转轴权重
---@param x     number      @转轴
---@param icon  slots_icon  @图标
---@return slots_wight
function slotsLogic:getAxleWeithtBy(x,icon)
    local wgts = self:getAxleIconWeithts(x)
    return wgts.wgt[icon]
end

---获取下注请求
---@return slots_jetton
function slotsLogic:getJetton()
    local player = self:getCurPlayer()
    return player:getJetton()
end

---获取单线下注
---@return slots_scope
function slotsLogic:getLineBet()
    local jetton = self:getJetton()
    return jetton.single
end

---获取重转轴
---@return xpost
function slotsLogic:getCurAxle()
    local player = self:getCurPlayer()
    local quest  = player:getRequest()
    ---@type slots_ernie_alxe
    local details  = quest.details
    return details.alxe
end

---转出图标
---@return slots_icon[]
function slotsLogic:rotateIcon()
    local layt = self.getLayoutInfo()
    local icons  = {nil}
    for y=1,layt.maximumX do
        for x=1,layt.maximumY do
            self:createIcon(x,y,icons)
        end
    end
    return icons
end
---创建图标
---@param x number @x
---@param y number @y
function slotsLogic:createIcon(x,y,icons)
    local layt = self.getLayoutInfo()
    local wgts = self:getAxleIconWeithts(x)
    local sole = self:getSoleIcon()
    local sums = wgts.sum
    local list = wgts.wgt

    --转轴图标:唯一处理
    local igns = {nil}
    for iy=1,y-1 do
        local pos = x + ((iy-1)*layt.maximumX)
        local ico = icons[pos]
        if table.exist(sole,ico) then
            sums = sums - list[ico]
            igns[ico] = true
        end
    end

    --随机图标:遍历权重
    local rdm = math.random(1,sums)
    for icon,weight in ipairs(list) do
        if not igns[icon] then
            rdm = rdm - weight
            if rdm <= 0 then
                table.insert(icons,icon)
                break
            end
        end
    end
end


---正常摇奖
---@return slots_result_normal
function slotsLogic:rotateNormal()
    ---@type slots_result_normal
    local result = {nil}
    local gmtype = slotsEnum.rotateNormal()
    local jetton = self:getJetton()
    local costcn = jetton.total
    local single = jetton.single
    local icnlis = self:rotateIcon()
    local linlis = self:getLineList(icnlis)
    local gmcoin = self:getGainCoin(linlis)
    local addfre = self:getFreePush(icnlis)
    local leffre = self:getFreeLeft(addfre)
    result.game_type    = gmtype                    --正常摇奖
    result.game_jetton  = jetton                    --下注信息
    result.game_cost    = costcn                    --游戏成本
    result.free_push    = addfre                    --增加免费
    result.free_left    = leffre                    --剩余免费
    result.icon_list    = icnlis                    --转出图标
    result.line_list    = linlis                    --连线结果
    result.gain_coin    = gmcoin                    --获取分数
    return result
end

---免费摇奖
---@return slots_result_normal
function slotsLogic:rotateFree()
    ---@type slots_result_normal
    local result = {nil}
    local gmtype = slotsEnum.rotateFree()
    local jetton = self:getJetton()
    local costcn = jetton.total
    local single = jetton.single
    local icnlis = self:rotateIcon()
    local linlis = self:getLineList(icnlis)
    local gmcoin = self:getGainCoin(linlis)
    local addfre = self:getFreePush(icnlis)
    local leffre = self:getFreeLeft(addfre)
    result.game_type    = gmtype                    --正常摇奖
    result.game_jetton  = jetton                    --下注信息
    result.game_cost    = costcn                    --游戏成本
    result.free_push    = addfre                    --增加免费
    result.free_left    = leffre                    --剩余免费
    result.icon_list    = icnlis                    --转出图标
    result.line_list    = linlis                    --连线结果
    result.gain_coin    = gmcoin                    --获取分数
    return result
end

---重转摇将
---@return slots_result_normal
function slotsLogic:rotateRoller(axle)
    ---@type slots_result_normal
    local result = {nil}
    local gmtype = slotsEnum.rotateRoller()
    local jetton = self:getJetton()
    local costcn = jetton.total
    local single = jetton.single
    local icnlis = self:rotateIcon()
    local linlis = self:getLineList(icnlis)
    local addfre = self:getFreePush(icnlis)
    local gmcoin = self:getGainCoin(linlis)
    local leffre = self:getFreeLeft(addfre)
    result.game_type    = gmtype                    --正常摇奖
    result.game_jetton  = jetton                    --下注信息
    result.game_cost    = costcn                    --游戏成本
    result.free_push    = addfre                    --增加免费
    result.free_left    = leffre                    --剩余免费
    result.icon_list    = icnlis                    --转出图标
    result.line_list    = linlis                    --连线结果
    result.gain_coin    = gmcoin                    --获取分数
    return result
end

---增加免费
---@param icnlis slots_icon[]
---@return count
function slotsLogic:getFreePush(icnlis)
    ---@type slots_cfg
    local cfg = self:getGameConf()
    local scf = cfg.scatter_free

    ---检查scatter
    local count = 0
    for _,icon in ipairs(icnlis) do
        if self:isScatter(icon) then
            count = count + 1
        end        
    end

    local addfre = scf[count] or 0
    return addfre
end

---@param  path         slots_post[]    @路线
---@param  icons        slots_icon[]    @结果
---@param  path_index   index           @几路
---@param  left_right   boolean         @true:从左到右 false:从右到左
---@return slots_line_path
function slotsLogic:lineCheck(path,icons,path_index,left_right)
     ---@type table<leng,base>
     local line_bases = self:getLineBases()
     ---@type slotsHelper
     local hlp = self._table._hlp
     ---@type score
     local lineBase = self:getLineBet()
    --定图标
    local image
    for leng,pos in ipairs(path) do
        local icon = icons[pos]
        if not hlp:isScatter(icon) then
            if not hlp:isNormal(icon) then
                --普通图标
                image = icon
                break
            end
        else
            break--scatter不连线
        end
    end
    if image then
        ---@type slots_icon_post[]
        local path_place = {nil}
        ---@type leng
        local line_leng = 0
        --左->右->检查
        for leng,post in ipairs(path) do
            local icon = icons[post]
            if image == icon or hlp:isWild(icon) then
                table.insert(path_place,{
                    icon = icon,
                    post = post,
                })
                line_leng = leng
            else
                break
            end
        end
        ---@type slots_base
        local line_again = line_bases[line_leng]
        if line_again > 0 then
            ---@type slots_scope
            local line_score = lineBase * line_again
            ---@type slots_line_path
            return {
                left_right = left_right,
                path_index = path_index,
                path_place = path_place,
                line_again = line_again,
                line_score = line_score,
            }
        end
    end
end

---连线结果
---@param icnlis slots_icon[]
---@return slots_line_path[]
function slotsLogic:getLineList(icnlis)
    local paths = self:getLinePath()
    if not paths then
        return
    end
    local linePath = {nil}
    --left->right
    for path_index,line_path in ipairs(paths) do
        local info = self:lineCheck(line_path,icnlis,path_index,true)
        table.insert(linePath,info)
    end

    if self:isBothway() then
        --right->left
        for path_index,line_path in ipairs(paths) do
            sort.reverse(line_path)
            local info = self:lineCheck(line_path,icnlis,path_index,false)
            table.insert(linePath,info)
            sort.reverse(line_path)
        end
    end
    return linePath
end

---计算彩金
---@param linlis slots_line_path[]
---@return score
function slotsLogic:getGainCoin(linlis)
    local score = 0
    for _,item in ipairs(linlis) do
        score = score + item.line_score
    end
    return score
end

---剩余免费
---@return count
function slotsLogic:getFreeLeft(addfre)
    local player = self:getCurPlayer()
    local count = player:getFreeCount()
    return count + addfre
end



return slotsLogic