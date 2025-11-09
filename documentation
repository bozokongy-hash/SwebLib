# SwebWare GUI Library

## Getting Started

```lua
local Library = loadstring(game:HttpGet("YOUR_URL_HERE"))()
```

## Key System

```lua
local keyPassed = Library:CreateKeySystem({
	Key = "YourKey123",
	DiscordLink = "discord.gg/yourlink",
	SaveFile = "your_key.txt",
	Title = "YOUR HUB",
	Footer = "Created By You"
})

if not keyPassed then return end
```

## Create Window

```lua
local Window = Library:CreateWindow({
	Title = "Your Hub",
	Subtitle = "Your Subtitle",
	BrandText = "Join Discord",
	DiscordLink = "discord.gg/yourlink",
	ToggleKey = Enum.KeyCode.RightControl,
	Size = UDim2.new(0, 700, 0, 480)
})
```

## Create Pages

```lua
local Page1 = Window:CreatePage("Page Name")
local Page2 = Window:CreatePage("Another Page")
```

## Elements

### Toggle

```lua
Window:CreateToggle({
	Parent = Page1.Content,
	Text = "Toggle Name",
	Default = false,
	Callback = function(value)
		print(value)
	end
})
```

### Slider

```lua
Window:CreateSlider({
	Parent = Page1.Content,
	Text = "Slider Name",
	Min = 0,
	Max = 100,
	Default = 50,
	Callback = function(value)
		print(value)
	end
})
```

### Button

```lua
Window:CreateButton({
	Parent = Page1.Content,
	Text = "Button Name",
	Callback = function()
		print("Button clicked!")
	end
})
```

### Dropdown

```lua
Window:CreateDropdown({
	Parent = Page1.Content,
	Text = "Dropdown Name",
	Options = {"Option 1", "Option 2", "Option 3"},
	Default = "Option 1",
	Callback = function(value)
		print(value)
	end
})
```

### Label

```lua
Window:CreateLabel({
	Parent = Page1.Content,
	Text = "This is a label"
})
```
```
