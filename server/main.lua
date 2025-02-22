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
    Wallet = exports["mythic-base"]:FetchComponent("Wallet")
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
        "Execute",
        "Wallet",
    }, function(error)
        if #error > 0 then return end
        RetrieveComponents()
    end)
end)

local playerID = 0 
CreateThread(function()
    while true do
        Citizen.Wait(Config.IncomeTaxInterval * 60000)

        for _, src in ipairs(GetPlayers()) do
            playerID = tonumber(src)
        end

        local player = Fetch:Source(playerID)
        local char = player:GetData("Character")
        local playerName = player:GetData("Name")
        local bankAccount = Banking.Accounts:GetPersonal(char:GetData("SID")).Account
        local bankBal = Banking.Balance:Get(bankAccount)
        local applicableRate = 0
        local applicableThreshold = 0

        for k, v in pairs(Config.TaxBrackets) do
            if bankBal >= v.threshold and v.threshold > applicableThreshold then
                applicableThreshold = v.threshold
                applicableRate = v.rate
            end
        end

        if applicableRate > 0 then
            local taxedAmount = CalculateTax(bankBal, applicableRate)

            if Config.Debug then
                Banking.Balance:Charge(bankAccount, taxedAmount, {
                    type = "bill",
                    title = "Income Tax",
                    description = "You were taxed $"..taxedAmount.." by the government",
                })
                Execute:Client(playerID, "Notification", "Info", "You were taxed $"..taxedAmount.." by the government")
                Logger:Info("fs_taxes", "["..playerID.."] - "..playerName.." - Taxed $"..taxedAmount.." at a rate of" .. applicableRate .. "%")
            else
                Banking.Balance:Charge(bankAccount, taxedAmount, {
                    type = "bill",
                    title = "Income Tax",
                    description = "You were taxed $"..taxedAmount.." by the government",
                })
                Execute:Client(playerID, "Notification", "Info", "You were taxed $"..taxedAmount.." by the government")
            end
        end
    end
end)

function CalculateTax(bankBal, rate)
    local taxedAmount = math.floor(bankBal * (rate / 100))
    return taxedAmount
end