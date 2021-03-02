require "src/util"
require "src/Adapter"

--[[
    * FileAdapter is the file adapter for Casbin.
    * It can load policy from file or save policy to file.
]]
FileAdapter = {
    filePath,
    readOnly = false
}
FileAdapter = setmetatable(FileAdapter,Adapter)

--[[
    * FileAdapter:new(filePath) returns a new FileAdapter
    *
    * @param filePath the path of the policy file.
]]
function FileAdapter:new(filePath)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.filePath = filePath
    return o
end

--[[
    * loadPolicy loads all policy rules from the storage.
]]
function FileAdapter:loadPolicy(model)
    local f = assert(io.open(self.filePath,"r"))

    if f then
        for line in f:lines() do
            loadPolicyLine(line, model)
        end
    end

    f:close()
end

--[[
    * savePolicy saves all policy rules to the storage.
]]
function FileAdapter:savePolicy(filePath)
    local f = assert(io.open(self.filePath,"w"))

    for ptype, ast in pairs(model.model["p"]) do
        local str = ptype
        for _, rule in pairs(ast.policy) do
            str = str .. arrayToString(rule) .. "\n"
        end
        f:write(str)
    end

    for ptype, ast in pairs(model.model["g"]) do
        local str = ptype
        for _, rule in pairs(ast.policy) do
            str = str .. arrayToString(rule) .. "\n"
        end
        f:write(str)
    end

    f:close()
end

--[[
    * addPolicy adds a policy rule to the storage.
]]
function FileAdapter:addPolicy(sec, ptype, rule)
    error("not implemented")
end

--[[
    * removePolicy removes a policy rule from the storage.
]]
function FileAdapter:removePolicy(sec, ptype, rule)
    error("not implemented")
end

--[[
    * removeFilteredPolicy removes policy rules that match the filter from the storage.
]]
function FileAdapter:removeFilteredPolicy(sec, ptype, fieldIndex, fieldValues)
    error("not implemented")
end 
