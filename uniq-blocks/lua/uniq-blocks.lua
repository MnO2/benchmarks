function usage(program_name)
    print("Usage: " .. program_name .. " filename")
end

function dedupeFile(file)
    local f = io.open(file, "rb")
    local t = {}

    while true do
        local block = f:read(512)

        if not block then break end

        if t[block] == nil then
            t[block] = 1
        else
            t[block] = t[block] + 1
        end
    end

    f:close()
end

if arg[1] == nil then
    usage(arg[0])
    do return end
else
    filename = arg[1]
    dedupeFile(filename)
end 
