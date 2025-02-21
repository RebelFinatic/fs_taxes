AddEventHandler("fs_taxes:DependencyUpdate", RetrieveComponents)
function RetrieveComponents()
    Logger = exports["mythic-base"]:FetchComponent("Logger")
    Chat = exports["mythic-base"]:FetchComponent("Chat")
    Vehicles = exports["mythic-base"]:FetchComponent("Vehicles")
    Game = exports["mythic-base"]:FetchComponent("Game")
    Chat = exports["mythic-base"]:FetchComponent("Chat")
    Fetch = exports["mythic-base"]:FetchComponent("Fetch")
    Jobs = exports["mythic-base"]:FetchComponent("Jobs")
end

AddEventHandler('Core:Shared:Ready', function()
    exports["mythic-base"]:RequestDependencies("Taxes", {
        "Logger",
        "Chat",
        "Vehicles",
        "Game",
        "Chat",
        "Fetch",
        "Jobs",
    }, function(error)
        if #error > 0 then return end
        RetrieveComponents()
    end)
end)