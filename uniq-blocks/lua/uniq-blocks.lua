function readAll(file)
    local f = io.open(file, "rb")
    local content = f:read("*all")
    f:close()
    return content
end


local file = 'uniq-blocks.lua'

c = readAll(file)
print(c)
