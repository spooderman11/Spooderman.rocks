--[[
    Simple webhook module for roblox. Usable with syanpse x, krnl, and other executors. It can also be used without an executor.
    
    Credits and Licensing:
    - This module was made by me, and is free to use in any way you want.
    - You can use this module in any way you want, as long as you give me credit.
    - Claming this module as your own is not permissable.
]]

--// services and variables
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

--// variables
local executor = false
local webhook = "https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

--// module stack
local module = {}

--// module functions
function module:Init(info)
    info = info or {}
    info.Executor = info.Executor or false
    info.Webhook = info.Webhook or "nil"

    if info.Executor then
        executor = info.Executor
    end

    if info.Webhook then
        webhook = info.Webhook
    end

    local mainfuncs = {}

    function mainfuncs:Message(info)
        info = info or {}
        info.Message = info.Message or "nil"

        local data = {
            ["content"] = info.Message
        }

        local data = HttpService:JSONEncode(data)

        local headers = {
            ["Content-Type"] = "application/json"
        }

        local messagefuncs = {}

        function messagefuncs:Send()
            if not executor then
                local success, err = pcall(function()
                    local response = game:HttpGet(webhook, true, data, headers)
    
                    if response then
                        return response
                    end
                end)
    
            else
                local req = syn and syn.request or request
    
                local success, err = pcall(function()
                    local response = req({
                        Url = webhook,
                        Method = "POST",
                        Headers = headers,
                        Body = data
                    })
    
                    if response then
                        return response
                    end
                end)
            end
        end
        return messagefuncs
    end
    function mainfuncs:Embed(info)
        info = info or {}
        info.Title = info.Title or "nil"
        info.Description = info.Description or "nil"
        info.Color = info.Color or "nil"
        info.Footer = info.Footer or "nil"
        info.Image = info.Image or "nil"
        info.Thumbnail = info.Thumbnail or "nil"
        info.Author = info.Author or "nil"
        info.Fields = info.Fields or {}

        local data = {
            ["embeds"] = {{
                ["title"] = info.Title,
                ["description"] = info.Description,
                ["color"] = info.Color,
                ["footer"] = {
                    ["text"] = info.Footer
                },
                ["image"] = {
                    ["url"] = info.Image
                },
                ["thumbnail"] = {
                    ["url"] = info.Thumbnail
                },
                ["author"] = {
                    ["name"] = info.Author
                },
                ["fields"] = info.Fields
            }}
        }

        local data = HttpService:JSONEncode(data)

        local headers = {
            ["Content-Type"] = "application/json"
        }

        local embedfuncs = {}

        function embedfuncs:Send()
            if not executor then
                local success, err = pcall(function()
                    local response = game:HttpGet(webhook, true, data, headers)
    
                    if response then
                        return response
                    end
                end)
    
            else
                local req = syn and syn.request or request
    
                local success, err = pcall(function()
                    local response = req({
                        Url = webhook,
                        Method = "POST",
                        Headers = headers,
                        Body = data
                    })
    
                    if response then
                        return response
                    end
                end)
            end
        end
        return embedfuncs
    end
    return mainfuncs
end
--// return the module
return module
