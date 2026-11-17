local MARKER = "!commitstop"
local ALLOWED_MESSAGE_START = "blob"

local msg_file = arg[1]
if not msg_file then
    io.stderr:write("commitstop: no commit message file given\n")
    os.exit(1)
end

local function shell_quote(s)
    return "'" .. s:gsub("'", "'\\''") .. "'"
end

local function starts_with_blob(path)
    local f = assert(io.open(path, "r"))
    local content = f:read("a")
    f:close()
    if content and content:find(ALLOWED_MESSAGE_START, 1, true) then return true end
    return false
end

local function staged_files()
    local p = assert(io.popen("git diff --cached --name-only --diff-filter=ACM"))

    local files = {}
    for name in p:lines() do
        files[#files + 1] = name
    end
    p:close()
    return files
end

local hits = {}
for _, name in ipairs(staged_files()) do
    local p = assert(io.popen("git show :" .. shell_quote(name) .. " 2>/dev/null"))
    local content = p:read("*a")
    p:close()
    if content and content:find(MARKER, 1, true) then
        hits[#hits + 1] = name
    end
end

if #hits == 0 then
    os.exit(0)
end

if starts_with_blob(msg_file) then
    print("Blob commit! Not checking for commitstopping flags!")
    os.exit(0)
end

io.stderr:write("commitstop: commit blocked. Found " .. MARKER .. " in:\n")
for _, name in ipairs(hits) do
    io.stderr:write(name .. ":0:0\n")
end
io.stderr:write('There might be more "' ..
    MARKER .. '" flags in other files. We stop searching after finding the first one.\n')
io.stderr:write('Remove the marker, or start the commit message with "' .. ALLOWED_MESSAGE_START .. '" to override.\n')
os.exit(1)
