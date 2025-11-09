local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bozokongy-hash/SwebLib/refs/heads/main/source.lua"))()

local keyPassed = Library:CreateKeySystem({
	Key = "MyKey123",
	DiscordLink = "discord.gg/example",
	SaveFile = "mykey.txt",
	Title = "MY HUB",
	Footer = "Created By Me"
})

if not keyPassed then return end

local Window = Library:CreateWindow({
	Title = "My Hub",
	Subtitle = "Version 1.0",
	BrandText = "Join Discord",
	DiscordLink = "discord.gg/example",
	ToggleKey = Enum.KeyCode.RightControl,
	Size = UDim2.new(0, 700, 0, 480)
})

local MainPage = Window:CreatePage("Main")
local SettingsPage = Window:CreatePage("Settings")

Window:CreateToggle({
	Parent = MainPage.Content,
	Text = "Enable Feature",
	Default = false,
	Callback = function(value)
		_G.FeatureEnabled = value
	end
})

Window:CreateSlider({
	Parent = MainPage.Content,
	Text = "Speed",
	Min = 16,
	Max = 100,
	Default = 16,
	Callback = function(value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
	end
})

Window:CreateButton({
	Parent = SettingsPage.Content,
	Text = "Reset Settings",
	Callback = function()
		print("Settings reset!")
	end
})

Window:CreateDropdown({
	Parent = SettingsPage.Content,
	Text = "Theme",
	Options = {"Dark", "Light", "Blue"},
	Default = "Dark",
	Callback = function(value)
		print("Theme:", value)
	end
})

Window:CreateLabel({
	Parent = SettingsPage.Content,
	Text = "Made by @YourName"
})
