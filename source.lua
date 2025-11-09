-- SwebWare GUI Library
-- Feel free to make edits just give credits ty!

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Library = {}
Library.__index = Library

-- Configuration
Library.Theme = {
	Background = Color3.fromRGB(12, 12, 18),
	Secondary = Color3.fromRGB(15, 15, 25),
	Tertiary = Color3.fromRGB(18, 18, 28),
	Accent = Color3.fromRGB(200, 30, 30),
	AccentHover = Color3.fromRGB(230, 40, 40),
	AccentBright = Color3.fromRGB(255, 50, 50),
	Text = Color3.fromRGB(255, 255, 255),
	TextDark = Color3.fromRGB(180, 180, 180),
	TextDarker = Color3.fromRGB(150, 150, 150),
	Border = Color3.fromRGB(40, 40, 55),
}

-- Key System Function
function Library:CreateKeySystem(config)
	config = config or {}
	local correctKey = config.Key or "DefaultKey123"
	local discordLink = config.DiscordLink or "discord.gg/yourlink"
	local keyFileName = config.SaveFile or "library_key.txt"
	
	-- Check if key is already saved
	local savedKey = nil
	pcall(function()
		savedKey = readfile(keyFileName)
	end)
	
	-- If saved key matches, skip key system
	if savedKey == correctKey then
		return true
	end
	
	-- Create Key System GUI
	local keyScreenGui = Instance.new("ScreenGui")
	keyScreenGui.Name = "KeySystemGUI"
	keyScreenGui.ResetOnSpawn = false
	keyScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	keyScreenGui.IgnoreGuiInset = true
	
	-- Dark overlay
	local overlay = Instance.new("Frame")
	overlay.Name = "Overlay"
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	overlay.BackgroundTransparency = 0.3
	overlay.BorderSizePixel = 0
	overlay.ZIndex = 100
	overlay.Parent = keyScreenGui
	
	-- Key System Main Frame
	local keyFrame = Instance.new("Frame")
	keyFrame.Name = "KeyFrame"
	keyFrame.Size = UDim2.new(0, 450, 0, 320)
	keyFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
	keyFrame.BackgroundColor3 = Library.Theme.Background
	keyFrame.BorderSizePixel = 0
	keyFrame.ZIndex = 101
	keyFrame.Parent = keyScreenGui
	
	local keyCorner = Instance.new("UICorner")
	keyCorner.CornerRadius = UDim.new(0, 16)
	keyCorner.Parent = keyFrame
	
	local keyGradient = Instance.new("UIGradient")
	keyGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 12, 15)),
		ColorSequenceKeypoint.new(1, Library.Theme.Background)
	}
	keyGradient.Rotation = 45
	keyGradient.Parent = keyFrame
	
	local keyBorder = Instance.new("UIStroke")
	keyBorder.Color = Library.Theme.Accent
	keyBorder.Thickness = 2
	keyBorder.Transparency = 0.2
	keyBorder.Parent = keyFrame
	
	-- Pulsing border animation
	spawn(function()
		while keyScreenGui.Parent do
			TweenService:Create(keyBorder, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = Library.Theme.AccentBright}):Play()
			wait(2)
			TweenService:Create(keyBorder, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = Library.Theme.Accent}):Play()
			wait(2)
		end
	end)
	
	-- Logo/Title Section
	local logoContainer = Instance.new("Frame")
	logoContainer.Size = UDim2.new(1, -40, 0, 80)
	logoContainer.Position = UDim2.new(0, 20, 0, 20)
	logoContainer.BackgroundTransparency = 1
	logoContainer.ZIndex = 102
	logoContainer.Parent = keyFrame
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, 0, 0, 35)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = config.Title or "SWEBWARE"
	titleLabel.TextColor3 = Library.Theme.AccentBright
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 28
	titleLabel.ZIndex = 102
	titleLabel.Parent = logoContainer
	
	local subtitleLabel = Instance.new("TextLabel")
	subtitleLabel.Size = UDim2.new(1, 0, 0, 20)
	subtitleLabel.Position = UDim2.new(0, 0, 0, 35)
	subtitleLabel.BackgroundTransparency = 1
	subtitleLabel.Text = "Key System Authentication"
	subtitleLabel.TextColor3 = Library.Theme.TextDark
	subtitleLabel.Font = Enum.Font.Gotham
	subtitleLabel.TextSize = 14
	subtitleLabel.ZIndex = 102
	subtitleLabel.Parent = logoContainer
	
	local discordLabel = Instance.new("TextLabel")
	discordLabel.Size = UDim2.new(1, 0, 0, 18)
	discordLabel.Position = UDim2.new(0, 0, 0, 57)
	discordLabel.BackgroundTransparency = 1
	discordLabel.Text = "Get key from: " .. discordLink
	discordLabel.TextColor3 = Library.Theme.TextDarker
	discordLabel.Font = Enum.Font.Gotham
	discordLabel.TextSize = 12
	discordLabel.ZIndex = 102
	discordLabel.Parent = logoContainer
	
	-- Key Input Section
	local inputContainer = Instance.new("Frame")
	inputContainer.Size = UDim2.new(1, -40, 0, 50)
	inputContainer.Position = UDim2.new(0, 20, 0, 115)
	inputContainer.BackgroundColor3 = Library.Theme.Tertiary
	inputContainer.BorderSizePixel = 0
	inputContainer.ZIndex = 102
	inputContainer.Parent = keyFrame
	
	local inputCorner = Instance.new("UICorner")
	inputCorner.CornerRadius = UDim.new(0, 10)
	inputCorner.Parent = inputContainer
	
	local inputStroke = Instance.new("UIStroke")
	inputStroke.Color = Library.Theme.Border
	inputStroke.Thickness = 1
	inputStroke.Parent = inputContainer
	
	local keyInput = Instance.new("TextBox")
	keyInput.Size = UDim2.new(1, -20, 1, -10)
	keyInput.Position = UDim2.new(0, 10, 0, 5)
	keyInput.BackgroundTransparency = 1
	keyInput.Text = ""
	keyInput.PlaceholderText = "Enter your key here..."
	keyInput.TextColor3 = Library.Theme.Text
	keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
	keyInput.Font = Enum.Font.Gotham
	keyInput.TextSize = 14
	keyInput.TextXAlignment = Enum.TextXAlignment.Left
	keyInput.ClearTextOnFocus = false
	keyInput.ZIndex = 103
	keyInput.Parent = inputContainer
	
	-- Buttons Container
	local buttonsContainer = Instance.new("Frame")
	buttonsContainer.Size = UDim2.new(1, -40, 0, 50)
	buttonsContainer.Position = UDim2.new(0, 20, 0, 180)
	buttonsContainer.BackgroundTransparency = 1
	buttonsContainer.ZIndex = 102
	buttonsContainer.Parent = keyFrame
	
	-- Check Key Button
	local checkKeyBtn = Instance.new("TextButton")
	checkKeyBtn.Name = "CheckKeyButton"
	checkKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
	checkKeyBtn.Position = UDim2.new(0, 0, 0, 0)
	checkKeyBtn.BackgroundColor3 = Library.Theme.Accent
	checkKeyBtn.Text = "Check Key"
	checkKeyBtn.TextColor3 = Library.Theme.Text
	checkKeyBtn.Font = Enum.Font.GothamBold
	checkKeyBtn.TextSize = 15
	checkKeyBtn.AutoButtonColor = false
	checkKeyBtn.ZIndex = 103
	checkKeyBtn.Parent = buttonsContainer
	
	local checkBtnCorner = Instance.new("UICorner")
	checkBtnCorner.CornerRadius = UDim.new(0, 10)
	checkBtnCorner.Parent = checkKeyBtn
	
	-- Get Key Button
	local getKeyBtn = Instance.new("TextButton")
	getKeyBtn.Name = "GetKeyButton"
	getKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
	getKeyBtn.Position = UDim2.new(0.52, 0, 0, 0)
	getKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	getKeyBtn.Text = "Get Key"
	getKeyBtn.TextColor3 = Library.Theme.Text
	getKeyBtn.Font = Enum.Font.GothamBold
	getKeyBtn.TextSize = 15
	getKeyBtn.AutoButtonColor = false
	getKeyBtn.ZIndex = 103
	getKeyBtn.Parent = buttonsContainer
	
	local getBtnCorner = Instance.new("UICorner")
	getBtnCorner.CornerRadius = UDim.new(0, 10)
	getBtnCorner.Parent = getKeyBtn
	
	-- Status Label
	local statusLabel = Instance.new("TextLabel")
	statusLabel.Size = UDim2.new(1, -40, 0, 25)
	statusLabel.Position = UDim2.new(0, 20, 0, 245)
	statusLabel.BackgroundTransparency = 1
	statusLabel.Text = ""
	statusLabel.TextColor3 = Library.Theme.Text
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextSize = 13
	statusLabel.ZIndex = 103
	statusLabel.Parent = keyFrame
	
	-- Footer
	local footerLabel = Instance.new("TextLabel")
	footerLabel.Size = UDim2.new(1, 0, 0, 20)
	footerLabel.Position = UDim2.new(0, 0, 1, -30)
	footerLabel.BackgroundTransparency = 1
	footerLabel.Text = config.Footer or "Created By Sweb"
	footerLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
	footerLabel.Font = Enum.Font.Gotham
	footerLabel.TextSize = 11
	footerLabel.ZIndex = 102
	footerLabel.Parent = keyFrame
	
	-- Button Hover Effects
	checkKeyBtn.MouseEnter:Connect(function()
		TweenService:Create(checkKeyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.AccentHover}):Play()
	end)
	
	checkKeyBtn.MouseLeave:Connect(function()
		TweenService:Create(checkKeyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.Accent}):Play()
	end)
	
	getKeyBtn.MouseEnter:Connect(function()
		TweenService:Create(getKeyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 90)}):Play()
	end)
	
	getKeyBtn.MouseLeave:Connect(function()
		TweenService:Create(getKeyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
	end)
	
	-- Get Key Button Logic
	getKeyBtn.MouseButton1Click:Connect(function()
		setclipboard(discordLink)
		statusLabel.Text = "✓ Discord link copied to clipboard!"
		statusLabel.TextColor3 = Color3.new(0.39, 1, 0.39)
		wait(2)
		statusLabel.Text = ""
	end)
	
	-- Promise for key validation
	local keyValidated = false
	local keyPromise = Instance.new("BindableEvent")
	
	-- Check Key Button Logic
	checkKeyBtn.MouseButton1Click:Connect(function()
		local enteredKey = keyInput.Text
		
		if enteredKey == "" then
			statusLabel.Text = "✗ Please enter a key"
			statusLabel.TextColor3 = Color3.new(1, 0.39, 0.39)
			wait(2)
			statusLabel.Text = ""
			return
		end
		
		if enteredKey == correctKey then
			statusLabel.Text = "✓ Key Correct! Loading..."
			statusLabel.TextColor3 = Color3.new(0.39, 1, 0.39)
			
			-- Save the key
			pcall(function()
				writefile(keyFileName, enteredKey)
			end)
			
			-- Fade out animation
			TweenService:Create(keyFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			TweenService:Create(keyBorder, TweenInfo.new(0.5), {Transparency = 1}):Play()
			TweenService:Create(overlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			
			for _, child in pairs(keyFrame:GetDescendants()) do
				if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
					TweenService:Create(child, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
				end
			end
			
			wait(0.5)
			keyScreenGui:Destroy()
			keyValidated = true
			keyPromise:Fire()
		else
			statusLabel.Text = "✗ Incorrect Key!"
			statusLabel.TextColor3 = Color3.new(1, 0.39, 0.39)
			
			-- Shake animation
			local originalPos = keyFrame.Position
			for i = 1, 3 do
				TweenService:Create(keyFrame, TweenInfo.new(0.05), {Position = originalPos + UDim2.new(0, 10, 0, 0)}):Play()
				wait(0.05)
				TweenService:Create(keyFrame, TweenInfo.new(0.05), {Position = originalPos - UDim2.new(0, 10, 0, 0)}):Play()
				wait(0.05)
			end
			TweenService:Create(keyFrame, TweenInfo.new(0.05), {Position = originalPos}):Play()
			
			wait(2)
			statusLabel.Text = ""
		end
	end)
	
	-- Enter key to check
	keyInput.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			checkKeyBtn.MouseButton1Click:Fire()
		end
	end)
	
	-- Show key system
	keyScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	
	-- Wait for validation
	keyPromise.Event:Wait()
	return keyValidated
end

-- Create a new window
function Library:CreateWindow(config)
	config = config or {}
	local window = {
		Title = config.Title or "SwebWare",
		Subtitle = config.Subtitle or "GUI Library",
		ToggleKey = config.ToggleKey or Enum.KeyCode.RightControl,
		Size = config.Size or UDim2.new(0, 700, 0, 480),
		Pages = {},
		CurrentPage = nil
	}
	
	-- Create ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SwebWareGUI"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.IgnoreGuiInset = true
	window.ScreenGui = screenGui
	
	-- Brand Tag (Bottom Left)
	local brandTag = Instance.new("Frame")
	brandTag.Name = "BrandTag"
	brandTag.Size = UDim2.new(0, 260, 0, 70)
	brandTag.Position = UDim2.new(0, 15, 1, -85)
	brandTag.BackgroundColor3 = Library.Theme.Background
	brandTag.BorderSizePixel = 0
	brandTag.Parent = screenGui
	
	local brandCorner = Instance.new("UICorner")
	brandCorner.CornerRadius = UDim.new(0, 10)
	brandCorner.Parent = brandTag
	
	local brandStroke = Instance.new("UIStroke")
	brandStroke.Color = Library.Theme.Accent
	brandStroke.Thickness = 2
	brandStroke.Transparency = 0.3
	brandStroke.Parent = brandTag
	
	local brandTitle = Instance.new("TextLabel")
	brandTitle.Size = UDim2.new(1, -20, 0, 25)
	brandTitle.Position = UDim2.new(0, 10, 0, 8)
	brandTitle.BackgroundTransparency = 1
	brandTitle.Text = config.BrandText or "Join SwebWare"
	brandTitle.TextColor3 = Library.Theme.AccentBright
	brandTitle.Font = Enum.Font.GothamBold
	brandTitle.TextSize = 16
	brandTitle.TextXAlignment = Enum.TextXAlignment.Left
	brandTitle.Parent = brandTag
	
	local discordLink = Instance.new("TextLabel")
	discordLink.Size = UDim2.new(1, -20, 0, 20)
	discordLink.Position = UDim2.new(0, 10, 0, 35)
	discordLink.BackgroundTransparency = 1
	discordLink.Text = config.DiscordLink or "discord.gg/yourlink"
	discordLink.TextColor3 = Library.Theme.TextDark
	discordLink.Font = Enum.Font.Gotham
	discordLink.TextSize = 13
	discordLink.TextXAlignment = Enum.TextXAlignment.Left
	discordLink.Parent = brandTag
	
	-- Pulsing effect for brand tag
	spawn(function()
		while screenGui.Parent do
			TweenService:Create(brandStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {Transparency = 0}):Play()
			wait(1.5)
			TweenService:Create(brandStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {Transparency = 0.5}):Play()
			wait(1.5)
		end
	end)
	
	-- Main Container
	local mainFrame = Instance.new("Frame")
	mainFrame.Name = "MainContainer"
	mainFrame.Size = window.Size
	mainFrame.Position = UDim2.new(0.5, -window.Size.X.Offset/2, 0.5, -window.Size.Y.Offset/2)
	mainFrame.BackgroundColor3 = Library.Theme.Background
	mainFrame.BorderSizePixel = 0
	mainFrame.Visible = true
	mainFrame.Parent = screenGui
	window.MainFrame = mainFrame
	
	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 16)
	mainCorner.Parent = mainFrame
	
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 12, 15)),
		ColorSequenceKeypoint.new(1, Library.Theme.Background)
	}
	gradient.Rotation = 45
	gradient.Parent = mainFrame
	
	-- Animated border
	local glowBorder = Instance.new("UIStroke")
	glowBorder.Color = Library.Theme.Accent
	glowBorder.Thickness = 2
	glowBorder.Transparency = 0.2
	glowBorder.Parent = mainFrame
	
	spawn(function()
		while screenGui.Parent do
			TweenService:Create(glowBorder, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = Library.Theme.AccentBright}):Play()
			wait(2)
			TweenService:Create(glowBorder, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = Library.Theme.Accent}):Play()
			wait(2)
		end
	end)
	
	-- Particle background
	local particleBg = Instance.new("Frame")
	particleBg.Size = UDim2.new(1, 0, 1, 0)
	particleBg.BackgroundTransparency = 1
	particleBg.ZIndex = 0
	particleBg.ClipsDescendants = true
	particleBg.Parent = mainFrame
	
	-- Player Card Section
	local playerCard = Instance.new("Frame")
	playerCard.Name = "PlayerCard"
	playerCard.Size = UDim2.new(1, -40, 0, 110)
	playerCard.Position = UDim2.new(0, 20, 0, 20)
	playerCard.BackgroundColor3 = Library.Theme.Tertiary
	playerCard.BorderSizePixel = 0
	playerCard.Parent = mainFrame
	window.PlayerCard = playerCard
	
	local playerCardCorner = Instance.new("UICorner")
	playerCardCorner.CornerRadius = UDim.new(0, 12)
	playerCardCorner.Parent = playerCard
	
	local playerCardStroke = Instance.new("UIStroke")
	playerCardStroke.Color = Library.Theme.Accent
	playerCardStroke.Thickness = 1.5
	playerCardStroke.Transparency = 0.3
	playerCardStroke.Parent = playerCard
	
	-- Avatar Section
	local avatarFrame = Instance.new("Frame")
	avatarFrame.Size = UDim2.new(0, 90, 0, 90)
	avatarFrame.Position = UDim2.new(0, 10, 0.5, -45)
	avatarFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
	avatarFrame.BorderSizePixel = 0
	avatarFrame.Parent = playerCard
	
	local avatarCorner = Instance.new("UICorner")
	avatarCorner.CornerRadius = UDim.new(0, 12)
	avatarCorner.Parent = avatarFrame
	
	local avatarStroke = Instance.new("UIStroke")
	avatarStroke.Color = Library.Theme.AccentBright
	avatarStroke.Thickness = 3
	avatarStroke.Parent = avatarFrame
	
	local avatarImage = Instance.new("ImageLabel")
	avatarImage.Size = UDim2.new(1, -6, 1, -6)
	avatarImage.Position = UDim2.new(0, 3, 0, 3)
	avatarImage.BackgroundTransparency = 1
	avatarImage.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
	avatarImage.Parent = avatarFrame
	
	local avatarImageCorner = Instance.new("UICorner")
	avatarImageCorner.CornerRadius = UDim.new(0, 10)
	avatarImageCorner.Parent = avatarImage
	
	-- Pulsing avatar border
	spawn(function()
		while screenGui.Parent do
			TweenService:Create(avatarStroke, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = Color3.fromRGB(255, 80, 80)}):Play()
			wait(2)
			TweenService:Create(avatarStroke, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = Library.Theme.Accent}):Play()
			wait(2)
		end
	end)
	
	-- Player Info Container
	local infoContainer = Instance.new("Frame")
	infoContainer.Size = UDim2.new(1, -115, 1, -10)
	infoContainer.Position = UDim2.new(0, 110, 0, 5)
	infoContainer.BackgroundTransparency = 1
	infoContainer.Parent = playerCard
	
	local playerName = Instance.new("TextLabel")
	playerName.Size = UDim2.new(1, 0, 0, 24)
	playerName.BackgroundTransparency = 1
	playerName.Text = LocalPlayer.Name
	playerName.TextColor3 = Library.Theme.Text
	playerName.Font = Enum.Font.GothamBold
	playerName.TextSize = 18
	playerName.TextXAlignment = Enum.TextXAlignment.Left
	playerName.Parent = infoContainer
	
	local playerDisplay = Instance.new("TextLabel")
	playerDisplay.Size = UDim2.new(1, 0, 0, 18)
	playerDisplay.Position = UDim2.new(0, 0, 0, 24)
	playerDisplay.BackgroundTransparency = 1
	playerDisplay.Text = "Display: " .. LocalPlayer.DisplayName
	playerDisplay.TextColor3 = Library.Theme.TextDark
	playerDisplay.Font = Enum.Font.Gotham
	playerDisplay.TextSize = 13
	playerDisplay.TextXAlignment = Enum.TextXAlignment.Left
	playerDisplay.Parent = infoContainer
	
	local playerID = Instance.new("TextLabel")
	playerID.Size = UDim2.new(1, 0, 0, 18)
	playerID.Position = UDim2.new(0, 0, 0, 44)
	playerID.BackgroundTransparency = 1
	playerID.Text = "User ID: " .. LocalPlayer.UserId
	playerID.TextColor3 = Library.Theme.TextDark
	playerID.Font = Enum.Font.Gotham
	playerID.TextSize = 12
	playerID.TextXAlignment = Enum.TextXAlignment.Left
	playerID.Parent = infoContainer
	
	local gameID = Instance.new("TextLabel")
	gameID.Size = UDim2.new(1, 0, 0, 18)
	gameID.Position = UDim2.new(0, 0, 0, 64)
	gameID.BackgroundTransparency = 1
	gameID.Text = "Game ID: " .. game.PlaceId
	gameID.TextColor3 = Library.Theme.TextDark
	gameID.Font = Enum.Font.Gotham
	gameID.TextSize = 12
	gameID.TextXAlignment = Enum.TextXAlignment.Left
	gameID.Parent = infoContainer
	
	local accountAge = Instance.new("TextLabel")
	accountAge.Size = UDim2.new(1, 0, 0, 18)
	accountAge.Position = UDim2.new(0, 0, 0, 84)
	accountAge.BackgroundTransparency = 1
	accountAge.Text = "Age: " .. LocalPlayer.AccountAge .. " days"
	accountAge.TextColor3 = Library.Theme.TextDark
	accountAge.Font = Enum.Font.Gotham
	accountAge.TextSize = 12
	accountAge.TextXAlignment = Enum.TextXAlignment.Left
	accountAge.Parent = infoContainer
	
	-- Close button
	local closeBtn = Instance.new("TextButton")
	closeBtn.Name = "CloseButton"
	closeBtn.Size = UDim2.new(0, 35, 0, 35)
	closeBtn.Position = UDim2.new(1, -45, 0, 10)
	closeBtn.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
	closeBtn.Text = "X"
	closeBtn.TextColor3 = Library.Theme.Text
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 16
	closeBtn.ZIndex = 10
	closeBtn.Parent = mainFrame
	
	local closeBtnCorner = Instance.new("UICorner")
	closeBtnCorner.CornerRadius = UDim.new(0, 10)
	closeBtnCorner.Parent = closeBtn
	
	-- Content container
	local contentContainer = Instance.new("Frame")
	contentContainer.Size = UDim2.new(1, -40, 1, -150)
	contentContainer.Position = UDim2.new(0, 20, 0, 140)
	contentContainer.BackgroundTransparency = 1
	contentContainer.Parent = mainFrame
	window.ContentContainer = contentContainer
	
	-- Sidebar
	local sidebar = Instance.new("Frame")
	sidebar.Name = "Sidebar"
	sidebar.Size = UDim2.new(0, 180, 1, 0)
	sidebar.BackgroundColor3 = Library.Theme.Secondary
	sidebar.BorderSizePixel = 0
	sidebar.Parent = contentContainer
	
	local sidebarCorner = Instance.new("UICorner")
	sidebarCorner.CornerRadius = UDim.new(0, 12)
	sidebarCorner.Parent = sidebar
	
	local sidebarStroke = Instance.new("UIStroke")
	sidebarStroke.Color = Library.Theme.Accent
	sidebarStroke.Thickness = 1
	sidebarStroke.Transparency = 0.5
	sidebarStroke.Parent = sidebar
	
	-- Sidebar scroll
	local sidebarScroll = Instance.new("ScrollingFrame")
	sidebarScroll.Name = "MenuScroll"
	sidebarScroll.Size = UDim2.new(1, -10, 1, -10)
	sidebarScroll.Position = UDim2.new(0, 5, 0, 5)
	sidebarScroll.BackgroundTransparency = 1
	sidebarScroll.BorderSizePixel = 0
	sidebarScroll.ScrollBarThickness = 4
	sidebarScroll.ScrollBarImageColor3 = Library.Theme.Accent
	sidebarScroll.Parent = sidebar
	window.SidebarScroll = sidebarScroll
	
	local sidebarList = Instance.new("UIListLayout")
	sidebarList.Padding = UDim.new(0, 8)
	sidebarList.SortOrder = Enum.SortOrder.LayoutOrder
	sidebarList.Parent = sidebarScroll
	
	local sidebarPadding = Instance.new("UIPadding")
	sidebarPadding.PaddingTop = UDim.new(0, 8)
	sidebarPadding.PaddingBottom = UDim.new(0, 8)
	sidebarPadding.PaddingLeft = UDim.new(0, 5)
	sidebarPadding.PaddingRight = UDim.new(0, 5)
	sidebarPadding.Parent = sidebarScroll
	
	-- Content Area
	local contentArea = Instance.new("Frame")
	contentArea.Name = "ContentArea"
	contentArea.Size = UDim2.new(1, -195, 1, 0)
	contentArea.Position = UDim2.new(0, 190, 0, 0)
	contentArea.BackgroundColor3 = Library.Theme.Secondary
	contentArea.BorderSizePixel = 0
	contentArea.Parent = contentContainer
	window.ContentArea = contentArea
	
	local contentCorner = Instance.new("UICorner")
	contentCorner.CornerRadius = UDim.new(0, 12)
	contentCorner.Parent = contentArea
	
	local contentStroke = Instance.new("UIStroke")
	contentStroke.Color = Library.Theme.Accent
	contentStroke.Thickness = 1
	contentStroke.Transparency = 0.5
	contentStroke.Parent = contentArea
	
	-- Close button functionality
	closeBtn.MouseButton1Click:Connect(function()
		TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
			{Size = UDim2.new(0, 0, 0, 0)}):Play()
		wait(0.3)
		mainFrame.Visible = false
	end)
	
	closeBtn.MouseEnter:Connect(function()
		TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.AccentBright}):Play()
	end)
	
	closeBtn.MouseLeave:Connect(function()
		TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(150, 25, 25)}):Play()
	end)
	
	-- Toggle menu functionality
	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		
		if input.KeyCode == window.ToggleKey then
			if mainFrame.Visible then
				TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
					{Size = UDim2.new(0, 0, 0, 0)}):Play()
				wait(0.3)
				mainFrame.Visible = false
			else
				mainFrame.Size = UDim2.new(0, 0, 0, 0)
				mainFrame.Visible = true
				TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
					{Size = window.Size}):Play()
			end
		end
	end)
	
	-- Make draggable
	local dragging = false
	local dragInput, mousePos, framePos
	
	local function update(input)
		local delta = input.Position - mousePos
		mainFrame.Position = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
	end
	
	playerCard.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			mousePos = input.Position
			framePos = mainFrame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
		
		if dragging and dragInput then
			update(dragInput)
		end
	end)
	
	-- Auto-update scroll sizes
	sidebarList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		sidebarScroll.CanvasSize = UDim2.new(0, 0, 0, sidebarList.AbsoluteContentSize.Y + 16)
	end)
	
	-- Particle effects
	spawn(function()
		for i = 1, 15 do
			local particle = Instance.new("Frame")
			particle.Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8))
			particle.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.1, 0)
			particle.BackgroundColor3 = Color3.fromRGB(255, math.random(30, 80), 30)
			particle.BorderSizePixel = 0
			particle.BackgroundTransparency = math.random(30, 70) / 100
			particle.ZIndex = 0
			particle.Parent = particleBg
			
			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(1, 0)
			corner.Parent = particle
			
			spawn(function()
				while screenGui.Parent do
					local duration = math.random(6, 12)
					local endPos = UDim2.new(particle.Position.X.Scale + math.random(-15, 15) / 100, 0, 1.1, 0)
					TweenService:Create(particle, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Position = endPos}):Play()
					TweenService:Create(particle, TweenInfo.new(duration / 2, Enum.EasingStyle.Sine), {BackgroundTransparency = 0.9}):Play()
					wait(duration)
					particle.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.1, 0)
					particle.BackgroundTransparency = math.random(30, 70) / 100
				end
			end)
			
			wait(0.3)
		end
	end)
	
	-- Show GUI
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	
	setmetatable(window, Library)
	return window
end

-- Create a new page/tab
function Library:CreatePage(name)
	local page = {
		Name = name,
		Window = self,
		Elements = {}
	}
	
	-- Create menu button
	local btn = Instance.new("TextButton")
	btn.Name = name .. "Button"
	btn.Size = UDim2.new(1, 0, 0, 45)
	btn.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
	btn.Text = ""
	btn.LayoutOrder = #self.Pages + 1
	btn.AutoButtonColor = false
	btn.Parent = self.SidebarScroll
	page.Button = btn
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 10)
	btnCorner.Parent = btn
	
	local btnStroke = Instance.new("UIStroke")
	btnStroke.Color = Library.Theme.Border
	btnStroke.Thickness = 1
	btnStroke.Transparency = 0.5
	btnStroke.Parent = btn
	page.ButtonStroke = btnStroke
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -20, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Color3.fromRGB(220, 220, 220)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = btn
	
	-- Button hover effects
	btn.MouseEnter:Connect(function()
		if not page.Selected then
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 55)}):Play()
			TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
		end
	end)
	
	btn.MouseLeave:Connect(function()
		if not page.Selected then
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 35)}):Play()
			TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
		end
	end)
	
	-- Create page content
	local pageFrame = Instance.new("Frame")
	pageFrame.Name = name .. "Page"
	pageFrame.Size = UDim2.new(1, -20, 1, -20)
	pageFrame.Position = UDim2.new(0, 10, 0, 10)
	pageFrame.BackgroundTransparency = 1
	pageFrame.Visible = false
	pageFrame.Parent = self.ContentArea
	page.Frame = pageFrame
	
	local pageTitle = Instance.new("TextLabel")
	pageTitle.Size = UDim2.new(1, 0, 0, 35)
	pageTitle.BackgroundTransparency = 1
	pageTitle.Text = name
	pageTitle.TextColor3 = Library.Theme.Text
	pageTitle.Font = Enum.Font.GothamBold
	pageTitle.TextSize = 20
	pageTitle.TextXAlignment = Enum.TextXAlignment.Left
	pageTitle.Parent = pageFrame
	
	local titleLine = Instance.new("Frame")
	titleLine.Size = UDim2.new(0, 50, 0, 3)
	titleLine.Position = UDim2.new(0, 0, 0, 33)
	titleLine.BackgroundColor3 = Library.Theme.Accent
	titleLine.BorderSizePixel = 0
	titleLine.Parent = pageFrame
	
	local lineCorner = Instance.new("UICorner")
	lineCorner.CornerRadius = UDim.new(1, 0)
	lineCorner.Parent = titleLine
	
	local contentScroll = Instance.new("ScrollingFrame")
	contentScroll.Name = "Content"
	contentScroll.Size = UDim2.new(1, 0, 1, -45)
	contentScroll.Position = UDim2.new(0, 0, 0, 45)
	contentScroll.BackgroundTransparency = 1
	contentScroll.BorderSizePixel = 0
	contentScroll.ScrollBarThickness = 6
	contentScroll.ScrollBarImageColor3 = Library.Theme.Accent
	contentScroll.Parent = pageFrame
	page.Content = contentScroll
	
	local contentList = Instance.new("UIListLayout")
	contentList.Padding = UDim.new(0, 10)
	contentList.SortOrder = Enum.SortOrder.LayoutOrder
	contentList.Parent = contentScroll
	
	-- Auto-update scroll size
	contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		contentScroll.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
	end)
	
	-- Button click to switch pages
	btn.MouseButton1Click:Connect(function()
		self:SelectPage(page)
	end)
	
	table.insert(self.Pages, page)
	
	-- Select first page automatically
	if #self.Pages == 1 then
		self:SelectPage(page)
	end
	
	return page
end

-- Select a page
function Library:SelectPage(page)
	for _, p in pairs(self.Pages) do
		p.Selected = false
		p.Frame.Visible = false
		TweenService:Create(p.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 35)}):Play()
		TweenService:Create(p.ButtonStroke, TweenInfo.new(0.2), {Color = Library.Theme.Border, Transparency = 0.5}):Play()
	end
	
	page.Selected = true
	page.Frame.Visible = true
	TweenService:Create(page.Button, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.Accent}):Play()
	TweenService:Create(page.ButtonStroke, TweenInfo.new(0.2), {Color = Library.Theme.AccentBright, Transparency = 0}):Play()
	self.CurrentPage = page
end

-- Create a toggle
function Library:CreateToggle(config)
	config = config or {}
	local parent = config.Parent or self.CurrentPage.Content
	local labelText = config.Text or "Toggle"
	local defaultState = config.Default or false
	local callback = config.Callback or function() end
	
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Size = UDim2.new(1, 0, 0, 40)
	toggleFrame.BackgroundColor3 = Library.Theme.Tertiary
	toggleFrame.BorderSizePixel = 0
	toggleFrame.Parent = parent
	
	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(0, 10)
	toggleCorner.Parent = toggleFrame
	
	local toggleStroke = Instance.new("UIStroke")
	toggleStroke.Color = Library.Theme.Border
	toggleStroke.Thickness = 1
	toggleStroke.Parent = toggleFrame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -70, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(230, 230, 230)
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = toggleFrame
	
	local toggleButton = Instance.new("TextButton")
	toggleButton.Size = UDim2.new(0, 45, 0, 22)
	toggleButton.Position = UDim2.new(1, -55, 0.5, -11)
	toggleButton.BackgroundColor3 = defaultState and Library.Theme.Accent or Color3.fromRGB(50, 50, 65)
	toggleButton.Text = ""
	toggleButton.AutoButtonColor = false
	toggleButton.Parent = toggleFrame
	
	local toggleCorner2 = Instance.new("UICorner")
	toggleCorner2.CornerRadius = UDim.new(1, 0)
	toggleCorner2.Parent = toggleButton
	
	local toggleCircle = Instance.new("Frame")
	toggleCircle.Size = UDim2.new(0, 17, 0, 17)
	toggleCircle.Position = defaultState and UDim2.new(1, -19.5, 0.5, -8.5) or UDim2.new(0, 2.5, 0.5, -8.5)
	toggleCircle.BackgroundColor3 = Library.Theme.Text
	toggleCircle.BorderSizePixel = 0
	toggleCircle.Parent = toggleButton
	
	local circleCorner = Instance.new("UICorner")
	circleCorner.CornerRadius = UDim.new(1, 0)
	circleCorner.Parent = toggleCircle
	
	local enabled = defaultState
	
	toggleButton.MouseButton1Click:Connect(function()
		enabled = not enabled
		
		TweenService:Create(toggleButton, TweenInfo.new(0.2), {
			BackgroundColor3 = enabled and Library.Theme.Accent or Color3.fromRGB(50, 50, 65)
		}):Play()
		
		TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
			Position = enabled and UDim2.new(1, -19.5, 0.5, -8.5) or UDim2.new(0, 2.5, 0.5, -8.5)
		}):Play()
		
		callback(enabled)
	end)
	
	return toggleFrame
end

-- Create a slider
function Library:CreateSlider(config)
	config = config or {}
	local parent = config.Parent or self.CurrentPage.Content
	local labelText = config.Text or "Slider"
	local min = config.Min or 0
	local max = config.Max or 100
	local default = config.Default or min
	local callback = config.Callback or function() end
	
	local sliderFrame = Instance.new("Frame")
	sliderFrame.Size = UDim2.new(1, 0, 0, 55)
	sliderFrame.BackgroundColor3 = Library.Theme.Tertiary
	sliderFrame.BorderSizePixel = 0
	sliderFrame.Parent = parent
	
	local sliderCorner = Instance.new("UICorner")
	sliderCorner.CornerRadius = UDim.new(0, 10)
	sliderCorner.Parent = sliderFrame
	
	local sliderStroke = Instance.new("UIStroke")
	sliderStroke.Color = Library.Theme.Border
	sliderStroke.Thickness = 1
	sliderStroke.Parent = sliderFrame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -60, 0, 22)
	label.Position = UDim2.new(0, 12, 0, 5)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(230, 230, 230)
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = sliderFrame
	
	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0, 50, 0, 22)
	valueLabel.Position = UDim2.new(1, -55, 0, 5)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(default)
	valueLabel.TextColor3 = Library.Theme.Accent
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 13
	valueLabel.Parent = sliderFrame
	
	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(1, -24, 0, 6)
	sliderBg.Position = UDim2.new(0, 12, 1, -18)
	sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = sliderFrame
	
	local sliderBgCorner = Instance.new("UICorner")
	sliderBgCorner.CornerRadius = UDim.new(1, 0)
	sliderBgCorner.Parent = sliderBg
	
	local sliderFill = Instance.new("Frame")
	sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	sliderFill.BackgroundColor3 = Library.Theme.Accent
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBg
	
	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(1, 0)
	fillCorner.Parent = sliderFill
	
	local sliderButton = Instance.new("TextButton")
	sliderButton.Size = UDim2.new(0, 14, 0, 14)
	sliderButton.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
	sliderButton.BackgroundColor3 = Library.Theme.Text
	sliderButton.Text = ""
	sliderButton.AutoButtonColor = false
	sliderButton.Parent = sliderBg
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(1, 0)
	btnCorner.Parent = sliderButton
	
	local dragging = false
	
	sliderButton.MouseButton1Down:Connect(function()
		dragging = true
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
			local value = math.floor(min + (max - min) * pos)
			
			sliderButton.Position = UDim2.new(pos, -7, 0.5, -7)
			sliderFill.Size = UDim2.new(pos, 0, 1, 0)
			valueLabel.Text = tostring(value)
			
			callback(value)
		end
	end)
	
	return sliderFrame
end

-- Create a button
function Library:CreateButton(config)
	config = config or {}
	local parent = config.Parent or self.CurrentPage.Content
	local text = config.Text or "Button"
	local callback = config.Callback or function() end
	
	local buttonFrame = Instance.new("Frame")
	buttonFrame.Size = UDim2.new(1, 0, 0, 40)
	buttonFrame.BackgroundColor3 = Library.Theme.Tertiary
	buttonFrame.BorderSizePixel = 0
	buttonFrame.Parent = parent
	
	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 10)
	buttonCorner.Parent = buttonFrame
	
	local buttonStroke = Instance.new("UIStroke")
	buttonStroke.Color = Library.Theme.Border
	buttonStroke.Thickness = 1
	buttonStroke.Parent = buttonFrame
	
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -24, 0, 28)
	button.Position = UDim2.new(0, 12, 0.5, -14)
	button.BackgroundColor3 = Library.Theme.Accent
	button.Text = text
	button.TextColor3 = Library.Theme.Text
	button.Font = Enum.Font.GothamBold
	button.TextSize = 13
	button.AutoButtonColor = false
	button.Parent = buttonFrame
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = button
	
	button.MouseButton1Click:Connect(function()
		callback()
	end)
	
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.AccentHover}):Play()
	end)
	
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.Accent}):Play()
	end)
	
	return buttonFrame
end

-- Create a dropdown
function Library:CreateDropdown(config)
	config = config or {}
	local parent = config.Parent or self.CurrentPage.Content
	local labelText = config.Text or "Dropdown"
	local options = config.Options or {"Option 1", "Option 2"}
	local defaultOption = config.Default or options[1]
	local callback = config.Callback or function() end
	
	local dropdownFrame = Instance.new("Frame")
	dropdownFrame.Size = UDim2.new(1, 0, 0, 40)
	dropdownFrame.BackgroundColor3 = Library.Theme.Tertiary
	dropdownFrame.BorderSizePixel = 0
	dropdownFrame.Parent = parent
	
	local dropdownCorner = Instance.new("UICorner")
	dropdownCorner.CornerRadius = UDim.new(0, 10)
	dropdownCorner.Parent = dropdownFrame
	
	local dropdownStroke = Instance.new("UIStroke")
	dropdownStroke.Color = Library.Theme.Border
	dropdownStroke.Thickness = 1
	dropdownStroke.Parent = dropdownFrame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.5, -15, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = labelText
	label.TextColor3 = Color3.fromRGB(230, 230, 230)
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = dropdownFrame
	
	local currentValue = defaultOption
	local currentIndex = table.find(options, defaultOption) or 1
	
	local dropdownButton = Instance.new("TextButton")
	dropdownButton.Size = UDim2.new(0.5, -15, 0, 28)
	dropdownButton.Position = UDim2.new(0.5, 3, 0.5, -14)
	dropdownButton.BackgroundColor3 = Library.Theme.Accent
	dropdownButton.Text = currentValue
	dropdownButton.TextColor3 = Library.Theme.Text
	dropdownButton.Font = Enum.Font.GothamBold
	dropdownButton.TextSize = 12
	dropdownButton.AutoButtonColor = false
	dropdownButton.Parent = dropdownFrame
	
	local dropdownCorner2 = Instance.new("UICorner")
	dropdownCorner2.CornerRadius = UDim.new(0, 8)
	dropdownCorner2.Parent = dropdownButton
	
	dropdownButton.MouseButton1Click:Connect(function()
		currentIndex = currentIndex + 1
		if currentIndex > #options then
			currentIndex = 1
		end
		
		currentValue = options[currentIndex]
		dropdownButton.Text = currentValue
		callback(currentValue)
	end)
	
	dropdownButton.MouseEnter:Connect(function()
		TweenService:Create(dropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.AccentHover}):Play()
	end)
	
	dropdownButton.MouseLeave:Connect(function()
		TweenService:Create(dropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.Accent}):Play()
	end)
	
	return dropdownFrame
end

-- Create a label
function Library:CreateLabel(config)
	config = config or {}
	local parent = config.Parent or self.CurrentPage.Content
	local text = config.Text or "Label"
	
	local labelFrame = Instance.new("Frame")
	labelFrame.Size = UDim2.new(1, 0, 0, 30)
	labelFrame.BackgroundColor3 = Library.Theme.Tertiary
	labelFrame.BorderSizePixel = 0
	labelFrame.Parent = parent
	
	local labelCorner = Instance.new("UICorner")
	labelCorner.CornerRadius = UDim.new(0, 10)
	labelCorner.Parent = labelFrame
	
	local labelStroke = Instance.new("UIStroke")
	labelStroke.Color = Library.Theme.Border
	labelStroke.Thickness = 1
	labelStroke.Parent = labelFrame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -24, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Library.Theme.TextDark
	label.Font = Enum.Font.Gotham
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = labelFrame
	
	return labelFrame
end

return Library
