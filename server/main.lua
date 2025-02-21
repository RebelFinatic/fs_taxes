AddEventHandler("fs_taxes", RetrieveComponents)
function RetrieveComponents()
    Logger = exports["mythic-base"]:FetchComponent("Logger")
    Chat = exports["mythic-base"]:FetchComponent("Chat")
    Vehicles = exports["mythic-base"]:FetchComponent("Vehicles")
    Game = exports["mythic-base"]:FetchComponent("Game")
    Chat = exports["mythic-base"]:FetchComponent("Chat")
    Fetch = exports["mythic-base"]:FetchComponent("Fetch")
    Jobs = exports["mythic-base"]:FetchComponent("Jobs")
	Banking = exports["mythic-base"]:FetchComponent("Banking")
	Execute = exports["mythic-base"]:FetchComponent("Execute")
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
        "Banking",
        "Execute"
    }, function(error)
        if #error > 0 then return end
        RetrieveComponents()
    end)
end)



CreateThread(function()
    while true do
        Citizen.Wait(Config.IncomeTaxInterval)
        local player = Fetch:Source(1)
        local char = player:GetData("Character")
        local bankBal = char:GetData("BankAccount")
        Execute:Client(1, "Notification", "Info", "Your Current Cash: $" .. bankBal)

        -- Determine the highest applicable tax bracket
        local applicableRate = 0
        local applicableThreshold = 0

        for k, v in pairs(Config.TaxBrackets) do
            if bankBal >= v.threshold and v.threshold > applicableThreshold then
                applicableThreshold = v.threshold
                applicableRate = v.rate
            end
        end

        if applicableRate > 0 then
            print("Applying tax for threshold $" .. applicableThreshold .. " at rate " .. applicableRate .. "%")
            bankBal = CalculateTax(bankBal, applicableRate)
        end
    end
end)

function CalculateTax(bankBal, rate)
    local taxedAmount = math.floor(bankBal * (rate / 100))
    local updatedbankBal = bankBal - taxedAmount
    return updatedbankBal
end