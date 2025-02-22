Config = {}

-- General settings
Config.Debug = false

Config.IncomeTaxInterval = 5000 -- Tax Collection interval in minutes

Config.TaxBrackets = {
    {threshold = 10000, rate = 5},  -- 5% tax for balances above 10,000
    {threshold = 50000, rate = 10},  -- 10% tax for balances above 50,000
    {threshold = 100000, rate = 15}, -- 15% tax for balances above 100,000
    {threshold = 250000, rate = 20}, -- 20% tax for balances above 250,000
    {threshold = 500000, rate = 25}, -- 25% tax for balances above 500,000
}

