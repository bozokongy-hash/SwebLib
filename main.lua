-- SwebWare GUI Library v1.0
-- feel free to edit and make changes but please give credits ty!

local SwebLib = {}
SwebLib.__index = SwebLib

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Theme Configuration
SwebLib.Theme = {
	Background = Color3.fromRGB(12, 12, 18),
	BackgroundSecondary = Color3.fromRGB(18, 18, 28),
	BackgroundTertiary = Color3.fromRGB(15, 15, 25),
	Accent = Color3.fromRGB(200, 30, 30),
	AccentHover = Color3.fromRGB(230, 40, 40),
	AccentBright = Color3.fromRGB(255, 50, 50),
	Border = Color3.fromRGB(40, 40, 55),
	Text = Color3.fromRGB(255, 255, 255),
	TextSecondary = Color3.fromRGB(180, 180, 180),
	TextDim = Color3.fromRGB(100, 100, 100),
	Success = Color3.fromRGB(100, 255, 100),
	Error = Color3.fromRGB(255, 100, 100)
}

-- Key System Class
function SwebLib:CreateKeySystem(config)
	local KeySystem = {}
	
	config = config or {}
	config.CorrectKey = config.CorrectKey or "TestKey123"
	config.DiscordLink = config.DiscordLink or "discord.gg/example"
	config.SaveFile = config.SaveFile or "key_system.txt"
	config.OnSuccess = config.OnSuccess or function() end
	
	-- Check if key is already saved
	local savedKey = nil
	pcall(function()
		savedKey = readfile(config.SaveFile)
	end)
	
	if savedKey == config.CorrectKey then
		config.OnSuccess()
		return KeySystem
	end
	
	-- Create Key System GUI
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "KeySystemGui"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.IgnoreGuiInset = true
	
	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	overlay.BackgroundTransparency = 0.3
	overlay.BorderSizePixel = 0
	overlay.ZIndex = 100
	overlay.Parent = screenGui
	
	local keyFrame = Instance.new("Frame")
	keyFrame.Size = UDim2.new(0, 450, 0, 320)
	keyFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
	keyFrame.BackgroundColor3 = SwebLib.Theme.Background
	keyFrame.BorderSizePixel = 0
	keyFrame.ZIndex = 101
	keyFrame.Parent = screenGui
	
	local keyCorner = Instance.new("UICorner")
	keyCorner.CornerRadius = UDim.new(0, 16)
	keyCorner.Parent = keyFrame
	
	local keyBorder = Instance.new("UIStroke")
	keyBorder.Color = SwebLib.Theme.Accent
	keyBorder.Thickness = 2
	keyBorder.Transparency = 0.2
	keyBorder.Parent = keyFrame
	
	-- Pulsing border animation
	spawn(function()
		while screenGui.Parent do
			TweenService:Create(keyBorder, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = SwebLib.Theme.AccentBright}):Play()
			wait(2)
			TweenService:Create(keyBorder, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = SwebLib.Theme.Accent}):Play()
			wait(2)
		end
	end)
	
	-- Title Section
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -40, 0, 35)
	titleLabel.Position = UDim2.new(0, 20, 0, 20)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = config.Title or "KEY SYSTEM"
	titleLabel.TextColor3 = SwebLib.Theme.AccentBright
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 28
	titleLabel.ZIndex = 102
	titleLabel.Parent = keyFrame
	
	local subtitleLabel = Instance.new("TextLabel")
	subtitleLabel.Size = UDim2.new(1, -40, 0, 20)
	subtitleLabel.Position = UDim2.new(0, 20, 0, 55)
	subtitleLabel.BackgroundTransparency = 1
	subtitleLabel.Text = config.Subtitle or "Authentication Required"
	subtitleLabel.TextColor3 = SwebLib.Theme.TextSecondary
	subtitleLabel.Font = Enum.Font.Gotham
	subtitleLabel.TextSize = 14
	subtitleLabel.ZIndex = 102
	subtitleLabel.Parent = keyFrame
	
	local discordLabel = Instance.new("TextLabel")
	discordLabel.Size = UDim2.new(1, -40, 0, 18)
	discordLabel.Position = UDim2.new(0, 20, 0, 77)
	discordLabel.BackgroundTransparency = 1
	discordLabel.Text = "Get key from: " .. config.DiscordLink
	discordLabel.TextColor3 = SwebLib.Theme.TextDim
	discordLabel.Font = Enum.Font.Gotham
	discordLabel.TextSize = 12
	discordLabel.ZIndex = 102
	discordLabel.Parent = keyFrame
	
	-- Key Input
	local inputContainer = Instance.new("Frame")
	inputContainer.Size = UDim2.new(1, -40, 0, 50)
	inputContainer.Position = UDim2.new(0, 20, 0, 115)
	inputContainer.BackgroundColor3 = SwebLib.Theme.BackgroundSecondary
	inputContainer.BorderSizePixel = 0
	inputContainer.ZIndex = 102
	inputContainer.Parent = keyFrame
	
	local inputCorner = Instance.new("UICorner")
	inputCorner.CornerRadius = UDim.new(0, 10)
	inputCorner.Parent = inputContainer
	
	local keyInput = Instance.new("TextBox")
	keyInput.Size = UDim2.new(1, -20, 1, -10)
	keyInput.Position = UDim2.new(0, 10, 0, 5)
	keyInput.BackgroundTransparency = 1
	keyInput.Text = ""
	keyInput.PlaceholderText = "Enter your key here..."
	keyInput.TextColor3 = SwebLib.Theme.Text
	keyInput.PlaceholderColor3 = SwebLib.Theme.TextDim
	keyInput.Font = Enum.Font.Gotham
	keyInput.TextSize = 14
	keyInput.TextXAlignment = Enum.TextXAlignment.Left
	keyInput.ClearTextOnFocus = false
	keyInput.ZIndex = 103
	keyInput.Parent = inputContainer
	
	-- Buttons
	local buttonsContainer = Instance.new("Frame")
	buttonsContainer.Size = UDim2.new(1, -40, 0, 50)
	buttonsContainer.Position = UDim2.new(0, 20, 0, 180)
	buttonsContainer.BackgroundTransparency = 1
	buttonsContainer.ZIndex = 102
	buttonsContainer.Parent = keyFrame
	
	local checkKeyBtn = Instance.new("TextButton")
	checkKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
	checkKeyBtn.BackgroundColor3 = SwebLib.Theme.Accent
	checkKeyBtn.Text = "Check Key"
	checkKeyBtn.TextColor3 = SwebLib.Theme.Text
	checkKeyBtn.Font = Enum.Font.GothamBold
	checkKeyBtn.TextSize = 15
	checkKeyBtn.AutoButtonColor = false
	checkKeyBtn.ZIndex = 103
	checkKeyBtn.Parent = buttonsContainer
	
	local checkBtnCorner = Instance.new("UICorner")
	checkBtnCorner.CornerRadius = UDim.new(0, 10)
	checkBtnCorner.Parent = checkKeyBtn
	
	local getKeyBtn = Instance.new("TextButton")
	getKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
	getKeyBtn.Position = UDim2.new(0.52, 0, 0, 0)
	getKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	getKeyBtn.Text = "Get Key"
	getKeyBtn.TextColor3 = SwebLib.Theme.Text
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
	statusLabel.TextColor3 = SwebLib.Theme.Text
	statusLabel.Font = Enum.Font.Gotham
	statusLabel.TextSize = 13
	statusLabel.ZIndex = 103
	statusLabel.Parent = keyFrame
	
	-- Button functionality
	checkKeyBtn.MouseButton1Click:Connect(function()
		local enteredKey = keyInput.Text
		
		if enteredKey == "" then
			statusLabel.Text = "✗ Please enter a key"
			statusLabel.TextColor3 = SwebLib.Theme.Error
			wait(2)
			statusLabel.Text = ""
			return
		end
		
		if enteredKey == config.CorrectKey then
			statusLabel.Text = "✓ Key Correct! Loading..."
			statusLabel.TextColor3 = SwebLib.Theme.Success
			
			pcall(function()
				writefile(config.SaveFile, enteredKey)
			end)
			
			TweenService:Create(overlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			TweenService:Create(keyFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
			
			wait(0.5)
			screenGui:Destroy()
			config.OnSuccess()
		else
			statusLabel.Text = "✗ Incorrect Key!"
			statusLabel.TextColor3 = SwebLib.Theme.Error
			
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
	
	getKeyBtn.MouseButton1Click:Connect(function()
		setclipboard(config.DiscordLink)
		statusLabel.Text = "✓ Link copied to clipboard!"
		statusLabel.TextColor3 = SwebLib.Theme.Success
		wait(2)
		statusLabel.Text = ""
	end)
	
	keyInput.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			checkKeyBtn.MouseButton1Click:Fire()
		end
	end)
	
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	
	KeySystem.Destroy = function()
		screenGui:Destroy()
	end
	
	return KeySystem
end

-- Window Class
function SwebLib:CreateWindow(config)
	local Window = {}
	Window.Pages = {}
	Window.CurrentPage = nil
	
	config = config or {}
	config.Title = config.Title or "Menu"
	config.Size = config.Size or UDim2.new(0, 700, 0, 480)
	config.ToggleKey = config.ToggleKey or Enum.KeyCode.RightControl
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MenuGui"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.IgnoreGuiInset = true
	
	-- Main Container
	local mainFrame = Instance.new("Frame")
	mainFrame.Size = config.Size
	mainFrame.Position = UDim2.new(0.5, -config.Size.X.Offset/2, 0.5, -config.Size.Y.Offset/2)
	mainFrame.BackgroundColor3 = SwebLib.Theme.Background
	mainFrame.BorderSizePixel = 0
	mainFrame.Visible = true
	mainFrame.Parent = screenGui
	
	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 16)
	mainCorner.Parent = mainFrame
	
	local glowBorder = Instance.new("UIStroke")
	glowBorder.Color = SwebLib.Theme.Accent
	glowBorder.Thickness = 2
	glowBorder.Transparency = 0.2
	glowBorder.Parent = mainFrame
	
	-- Player Card Section
	local playerCard = Instance.new("Frame")
	playerCard.Size = UDim2.new(1, -40, 0, 110)
	playerCard.Position = UDim2.new(0, 20, 0, 20)
	playerCard.BackgroundColor3 = SwebLib.Theme.BackgroundSecondary
	playerCard.BorderSizePixel = 0
	playerCard.Parent = mainFrame
	
	local playerCardCorner = Instance.new("UICorner")
	playerCardCorner.CornerRadius = UDim.new(0, 12)
	playerCardCorner.Parent = playerCard
	
	-- Avatar
	local avatarFrame = Instance.new("Frame")
	avatarFrame.Size = UDim2.new(0, 90, 0, 90)
	avatarFrame.Position = UDim2.new(0, 10, 0.5, -45)
	avatarFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
	avatarFrame.BorderSizePixel = 0
	avatarFrame.Parent = playerCard
	
	local avatarCorner = Instance.new("UICorner")
	avatarCorner.CornerRadius = UDim.new(0, 12)
	avatarCorner.Parent = avatarFrame
	
	local avatarImage = Instance.new("ImageLabel")
	avatarImage.Size = UDim2.new(1, -6, 1, -6)
	avatarImage.Position = UDim2.new(0, 3, 0, 3)
	avatarImage.BackgroundTransparency = 1
	avatarImage.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
	avatarImage.Parent = avatarFrame
	
	local avatarImageCorner = Instance.new("UICorner")
	avatarImageCorner.CornerRadius = UDim.new(0, 10)
	avatarImageCorner.Parent = avatarImage
	
	-- Player Info
	local infoContainer = Instance.new("Frame")
	infoContainer.Size = UDim2.new(1, -115, 1, -10)
	infoContainer.Position = UDim2.new(0, 110, 0, 5)
	infoContainer.BackgroundTransparency = 1
	infoContainer.Parent = playerCard
	
	local playerName = Instance.new("TextLabel")
	playerName.Size = UDim2.new(1, 0, 0, 24)
	playerName.BackgroundTransparency = 1
	playerName.Text = LocalPlayer.Name
	playerName.TextColor3 = SwebLib.Theme.Text
	playerName.Font = Enum.Font.GothamBold
	playerName.TextSize = 18
	playerName.TextXAlignment = Enum.TextXAlignment.Left
	playerName.Parent = infoContainer
	
	local playerDisplay = Instance.new("TextLabel")
	playerDisplay.Size = UDim2.new(1, 0, 0, 18)
	playerDisplay.Position = UDim2.new(0, 0, 0, 24)
	playerDisplay.BackgroundTransparency = 1
	playerDisplay.Text = "Display: " .. LocalPlayer.DisplayName
	playerDisplay.TextColor3 = SwebLib.Theme.TextSecondary
	playerDisplay.Font = Enum.Font.Gotham
	playerDisplay.TextSize = 13
	playerDisplay.TextXAlignment = Enum.TextXAlignment.Left
	playerDisplay.Parent = infoContainer
	
	-- Close button
	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 35, 0, 35)
	closeBtn.Position = UDim2.new(1, -45, 0, 10)
	closeBtn.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
	closeBtn.Text = "X"
	closeBtn.TextColor3 = SwebLib.Theme.Text
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
	
	-- Sidebar
	local sidebar = Instance.new("Frame")
	sidebar.Size = UDim2.new(0, 180, 1, 0)
	sidebar.BackgroundColor3 = SwebLib.Theme.BackgroundTertiary
	sidebar.BorderSizePixel = 0
	sidebar.Parent = contentContainer
	
	local sidebarCorner = Instance.new("UICorner")
	sidebarCorner.CornerRadius = UDim.new(0, 12)
	sidebarCorner.Parent = sidebar
	
	local sidebarScroll = Instance.new("ScrollingFrame")
	sidebarScroll.Size = UDim2.new(1, -10, 1, -10)
	sidebarScroll.Position = UDim2.new(0, 5, 0, 5)
	sidebarScroll.BackgroundTransparency = 1
	sidebarScroll.BorderSizePixel = 0
	sidebarScroll.ScrollBarThickness = 4
	sidebarScroll.ScrollBarImageColor3 = SwebLib.Theme.Accent
	sidebarScroll.Parent = sidebar
	
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
	contentArea.Size = UDim2.new(1, -195, 1, 0)
	contentArea.Position = UDim2.new(0, 190, 0, 0)
	contentArea.BackgroundColor3 = SwebLib.Theme.BackgroundTertiary
	contentArea.BorderSizePixel = 0
	contentArea.Parent = contentContainer
	
	local contentCorner = Instance.new("UICorner")
	contentCorner.CornerRadius = UDim.new(0, 12)
	contentCorner.Parent = contentArea
	
	-- Window functions
	function Window:AddPage(name)
		local Page = {}
		Page.Name = name
		Page.Elements = {}
		
		-- Create sidebar button
		local btn = Instance.new("TextButton")
		btn.Name = name .. "Button"
		btn.Size = UDim2.new(1, 0, 0, 45)
		btn.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
		btn.Text = ""
		btn.LayoutOrder = #Window.Pages + 1
		btn.AutoButtonColor = false
		btn.Parent = sidebarScroll
		
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(0, 10)
		btnCorner.Parent = btn
		
		local btnStroke = Instance.new("UIStroke")
		btnStroke.Color = Color3.fromRGB(50, 50, 70)
		btnStroke.Thickness = 1
		btnStroke.Transparency = 0.5
		btnStroke.Parent = btn
		
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
		
		-- Create content page
		local page = Instance.new("Frame")
		page.Name = name .. "Page"
		page.Size = UDim2.new(1, -20, 1, -20)
		page.Position = UDim2.new(0, 10, 0, 10)
		page.BackgroundTransparency = 1
		page.Visible = false
		page.Parent = contentArea
		
		local pageTitle = Instance.new("TextLabel")
		pageTitle.Size = UDim2.new(1, 0, 0, 35)
		pageTitle.BackgroundTransparency = 1
		pageTitle.Text = name
		pageTitle.TextColor3 = SwebLib.Theme.Text
		pageTitle.Font = Enum.Font.GothamBold
		pageTitle.TextSize = 20
		pageTitle.TextXAlignment = Enum.TextXAlignment.Left
		pageTitle.Parent = page
		
		local contentScroll = Instance.new("ScrollingFrame")
		contentScroll.Name = "Content"
		contentScroll.Size = UDim2.new(1, 0, 1, -45)
		contentScroll.Position = UDim2.new(0, 0, 0, 45)
		contentScroll.BackgroundTransparency = 1
		contentScroll.BorderSizePixel = 0
		contentScroll.ScrollBarThickness = 6
		contentScroll.ScrollBarImageColor3 = SwebLib.Theme.Accent
		contentScroll.Parent = page
		
		local contentList = Instance.new("UIListLayout")
		contentList.Padding = UDim.new(0, 10)
		contentList.SortOrder = Enum.SortOrder.LayoutOrder
		contentList.Parent = contentScroll
		
		-- Page functions
		function Page:AddToggle(config)
			config = config or {}
			local toggleFrame = Instance.new("Frame")
			toggleFrame.Size = UDim2.new(1, 0, 0, 40)
			toggleFrame.BackgroundColor3 = SwebLib.Theme.BackgroundSecondary
			toggleFrame.BorderSizePixel = 0
			toggleFrame.Parent = contentScroll
			
			local toggleCorner = Instance.new("UICorner")
			toggleCorner.CornerRadius = UDim.new(0, 10)
			toggleCorner.Parent = toggleFrame
			
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -70, 1, 0)
			label.Position = UDim2.new(0, 12, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = config.Name or "Toggle"
			label.TextColor3 = Color3.fromRGB(230, 230, 230)
			label.Font = Enum.Font.Gotham
			label.TextSize = 13
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = toggleFrame
			
			local toggleButton = Instance.new("TextButton")
			toggleButton.Size = UDim2.new(0, 45, 0, 22)
			toggleButton.Position = UDim2.new(1, -55, 0.5, -11)
			toggleButton.BackgroundColor3 = (config.Default and SwebLib.Theme.Accent) or Color3.fromRGB(50, 50, 65)
			toggleButton.Text = ""
			toggleButton.AutoButtonColor = false
			toggleButton.Parent = toggleFrame
			
			local toggleCorner2 = Instance.new("UICorner")
			toggleCorner2.CornerRadius = UDim.new(1, 0)
			toggleCorner2.Parent = toggleButton
			
			local toggleCircle = Instance.new("Frame")
			toggleCircle.Size = UDim2.new(0, 17, 0, 17)
			toggleCircle.Position = (config.Default and UDim2.new(1, -19.5, 0.5, -8.5)) or UDim2.new(0, 2.5, 0.5, -8.5)
			toggleCircle.BackgroundColor3 = SwebLib.Theme.Text
			toggleCircle.BorderSizePixel = 0
			toggleCircle.Parent = toggleButton
			
			local circleCorner = Instance.new("UICorner")
			circleCorner.CornerRadius = UDim.new(1, 0)
			circleCorner.Parent = toggleCircle
			
			local enabled = config.Default or false
			
			toggleButton.MouseButton1Click:Connect(function()
				enabled = not enabled
				
				TweenService:Create(toggleButton, TweenInfo.new(0.2), {
					BackgroundColor3 = enabled and SwebLib.Theme.Accent or Color3.fromRGB(50, 50, 65)
				}):Play()
				
				TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
					Position = enabled and UDim2.new(1, -19.5, 0.5, -8.5) or UDim2.new(0, 2.5, 0.5, -8.5)
				}):Play()
				
				if config.Callback then
					config.Callback(enabled)
				end
			end)
			
			return {
				SetValue = function(value)
					enabled = value
					TweenService:Create(toggleButton, TweenInfo.new(0.2), {
						BackgroundColor3 = enabled and SwebLib.Theme.Accent or Color3.fromRGB(50, 50, 65)
					}):Play()
					TweenService:Create(toggleCircle, TweenInfo.new(0.2), {
						Position = enabled and UDim2.new(1, -19.5, 0.5, -8.5) or UDim2.new(0, 2.5, 0.5, -8.5)
					}):Play()
				end
			}
		end
		
		function Page:AddSlider(config)
			config = config or {}
			local min = config.Min or 0
			local max = config.Max or 100
			local default = config.Default or min
			
			local sliderFrame = Instance.new("Frame")
			sliderFrame.Size = UDim2.new(1, 0, 0, 55)
			sliderFrame.BackgroundColor3 = SwebLib.Theme.BackgroundSecondary
			sliderFrame.BorderSizePixel = 0
			sliderFrame.Parent = contentScroll
			
			local sliderCorner = Instance.new("UICorner")
			sliderCorner.CornerRadius = UDim.new(0, 10)
			sliderCorner.Parent = sliderFrame
			
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -60, 0, 22)
			label.Position = UDim2.new(0, 12, 0, 5)
			label.BackgroundTransparency = 1
			label.Text = config.Name or "Slider"
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
			valueLabel.TextColor3 = SwebLib.Theme.Accent
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
			sliderFill.BackgroundColor3 = SwebLib.Theme.Accent
			sliderFill.BorderSizePixel = 0
			sliderFill.Parent = sliderBg
			
			local fillCorner = Instance.new("UICorner")
			fillCorner.CornerRadius = UDim.new(1, 0)
			fillCorner.Parent = sliderFill
			
			local sliderButton = Instance.new("TextButton")
			sliderButton.Size = UDim2.new(0, 14, 0, 14)
			sliderButton.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
			sliderButton.BackgroundColor3 = SwebLib.Theme.Text
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
					
					if config.Callback then
						config.Callback(value)
					end
				end
			end)
			
			return {
				SetValue = function(value)
					value = math.clamp(value, min, max)
					local pos = (value - min) / (max - min)
					sliderButton.Position = UDim2.new(pos, -7, 0.5, -7)
					sliderFill.Size = UDim2.new(pos, 0, 1, 0)
					valueLabel.Text = tostring(value)
				end
			}
		end
		
		function Page:AddButton(config)
			config = config or {}
			
			local buttonFrame = Instance.new("Frame")
			buttonFrame.Size = UDim2.new(1, 0, 0, 40)
			buttonFrame.BackgroundColor3 = SwebLib.Theme.BackgroundSecondary
			buttonFrame.BorderSizePixel = 0
			buttonFrame.Parent = contentScroll
			
			local buttonCorner = Instance.new("UICorner")
			buttonCorner.CornerRadius = UDim.new(0, 10)
			buttonCorner.Parent = buttonFrame
			
			local button = Instance.new("TextButton")
			button.Size = UDim2.new(1, -24, 1, -10)
			button.Position = UDim2.new(0, 12, 0, 5)
			button.BackgroundColor3 = SwebLib.Theme.Accent
			button.Text = config.Name or "Button"
			button.TextColor3 = SwebLib.Theme.Text
			button.Font = Enum.Font.GothamBold
			button.TextSize = 13
			button.AutoButtonColor = false
			button.Parent = buttonFrame
			
			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 8)
			btnCorner.Parent = button
			
			button.MouseButton1Click:Connect(function()
				if config.Callback then
					config.Callback()
				end
			end)
			
			button.MouseEnter:Connect(function()
				TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = SwebLib.Theme.AccentHover}):Play()
			end)
			
			button.MouseLeave:Connect(function()
				TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = SwebLib.Theme.Accent}):Play()
			end)
		end
		
		function Page:AddDropdown(config)
			config = config or {}
			local options = config.Options or {"Option 1", "Option 2"}
			local currentIndex = config.Default or 1
			
			local dropdownFrame = Instance.new("Frame")
			dropdownFrame.Size = UDim2.new(1, 0, 0, 40)
			dropdownFrame.BackgroundColor3 = SwebLib.Theme.BackgroundSecondary
			dropdownFrame.BorderSizePixel = 0
			dropdownFrame.Parent = contentScroll
			
			local dropdownCorner = Instance.new("UICorner")
			dropdownCorner.CornerRadius = UDim.new(0, 10)
			dropdownCorner.Parent = dropdownFrame
			
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.5, -15, 1, 0)
			label.Position = UDim2.new(0, 12, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = config.Name or "Dropdown"
			label.TextColor3 = Color3.fromRGB(230, 230, 230)
			label.Font = Enum.Font.Gotham
			label.TextSize = 13
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = dropdownFrame
			
			local dropdownButton = Instance.new("TextButton")
			dropdownButton.Size = UDim2.new(0.5, -15, 0, 28)
			dropdownButton.Position = UDim2.new(0.5, 3, 0.5, -14)
			dropdownButton.BackgroundColor3 = SwebLib.Theme.Accent
			dropdownButton.Text = options[currentIndex] or "Select"
			dropdownButton.TextColor3 = SwebLib.Theme.Text
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
				
				local selectedOption = options[currentIndex]
				dropdownButton.Text = selectedOption
				
				if config.Callback then
					pcall(function()
						config.Callback(selectedOption)
					end)
				end
			end)
			
			dropdownButton.MouseEnter:Connect(function()
				TweenService:Create(dropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = SwebLib.Theme.AccentHover}):Play()
			end)
			
			dropdownButton.MouseLeave:Connect(function()
				TweenService:Create(dropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = SwebLib.Theme.Accent}):Play()
			end)
			
			return {
				SetValue = function(value)
					for i, option in ipairs(options) do
						if option == value then
							currentIndex = i
							dropdownButton.Text = value
							if config.Callback then
								pcall(function()
									config.Callback(value)
								end)
							end
							break
						end
					end
				end
			}
		end
		
		function Page:AddLabel(config)
			config = config or {}
			
			local labelFrame = Instance.new("Frame")
			labelFrame.Size = UDim2.new(1, 0, 0, 30)
			labelFrame.BackgroundTransparency = 1
			labelFrame.Parent = contentScroll
			
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(1, -24, 1, 0)
			label.Position = UDim2.new(0, 12, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = config.Text or "Label"
			label.TextColor3 = SwebLib.Theme.TextSecondary
			label.Font = Enum.Font.Gotham
			label.TextSize = 13
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = labelFrame
			
			return {
				SetText = function(text)
					label.Text = text
				end
			}
		end
		
		-- Auto-update canvas size
		contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			contentScroll.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
		end)
		
		-- Button click handler
		btn.MouseButton1Click:Connect(function()
			Window:SelectPage(Page)
		end)
		
		btn.MouseEnter:Connect(function()
			if not btn:GetAttribute("Selected") then
				TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 55)}):Play()
			end
		end)
		
		btn.MouseLeave:Connect(function()
			if not btn:GetAttribute("Selected") then
				TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 35)}):Play()
			end
		end)
		
		Page.Button = btn
		Page.Stroke = btnStroke
		Page.Frame = page
		
		table.insert(Window.Pages, Page)
		
		-- Auto-select first page
		if #Window.Pages == 1 then
			Window:SelectPage(Page)
		end
		
		return Page
	end
	
	function Window:SelectPage(page)
		for _, p in pairs(Window.Pages) do
			p.Button:SetAttribute("Selected", false)
			TweenService:Create(p.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 35)}):Play()
			TweenService:Create(p.Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(50, 50, 70), Transparency = 0.5}):Play()
			p.Frame.Visible = false
		end
		
		page.Button:SetAttribute("Selected", true)
		TweenService:Create(page.Button, TweenInfo.new(0.2), {BackgroundColor3 = SwebLib.Theme.Accent}):Play()
		TweenService:Create(page.Stroke, TweenInfo.new(0.2), {Color = SwebLib.Theme.AccentBright, Transparency = 0}):Play()
		page.Frame.Visible = true
		
		Window.CurrentPage = page
	end
	
	function Window:Toggle()
		if mainFrame.Visible then
			TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), 
				{Size = UDim2.new(0, 0, 0, 0)}):Play()
			wait(0.3)
			mainFrame.Visible = false
		else
			mainFrame.Size = UDim2.new(0, 0, 0, 0)
			mainFrame.Visible = true
			TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), 
				{Size = config.Size}):Play()
		end
	end
	
	-- Close button
	closeBtn.MouseButton1Click:Connect(function()
		Window:Toggle()
	end)
	
	closeBtn.MouseEnter:Connect(function()
		TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
	end)
	
	closeBtn.MouseLeave:Connect(function()
		TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(150, 25, 25)}):Play()
	end)
	
	-- Toggle key
	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.KeyCode == config.ToggleKey then
			Window:Toggle()
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
	
	-- Auto-update sidebar canvas
	sidebarList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		sidebarScroll.CanvasSize = UDim2.new(0, 0, 0, sidebarList.AbsoluteContentSize.Y + 16)
	end)
	
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	
	Window.Destroy = function()
		screenGui:Destroy()
	end
	
	return Window
end

-- Notification System
function SwebLib:Notify(config)
	config = config or {}
	config.Title = config.Title or "Notification"
	config.Description = config.Description or "This is a notification"
	config.Duration = config.Duration or 3
	
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "NotificationGui"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.IgnoreGuiInset = true
	
	local notifFrame = Instance.new("Frame")
	notifFrame.Size = UDim2.new(0, 300, 0, 80)
	notifFrame.Position = UDim2.new(1, 20, 0, 20)
	notifFrame.BackgroundColor3 = SwebLib.Theme.BackgroundSecondary
	notifFrame.BorderSizePixel = 0
	notifFrame.Parent = screenGui
	
	local notifCorner = Instance.new("UICorner")
	notifCorner.CornerRadius = UDim.new(0, 12)
	notifCorner.Parent = notifFrame
	
	local notifStroke = Instance.new("UIStroke")
	notifStroke.Color = SwebLib.Theme.Accent
	notifStroke.Thickness = 2
	notifStroke.Parent = notifFrame
	
	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -20, 0, 25)
	title.Position = UDim2.new(0, 10, 0, 8)
	title.BackgroundTransparency = 1
	title.Text = config.Title
	title.TextColor3 = SwebLib.Theme.AccentBright
	title.Font = Enum.Font.GothamBold
	title.TextSize = 15
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Parent = notifFrame
	
	local description = Instance.new("TextLabel")
	description.Size = UDim2.new(1, -20, 0, 40)
	description.Position = UDim2.new(0, 10, 0, 33)
	description.BackgroundTransparency = 1
	description.Text = config.Description
	description.TextColor3 = SwebLib.Theme.TextSecondary
	description.Font = Enum.Font.Gotham
	description.TextSize = 13
	description.TextXAlignment = Enum.TextXAlignment.Left
	description.TextWrapped = true
	description.Parent = notifFrame
	
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	
	-- Slide in animation
	TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), 
		{Position = UDim2.new(1, -310, 0, 20)}):Play()
	
	-- Auto-remove after duration
	spawn(function()
		wait(config.Duration)
		TweenService:Create(notifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), 
			{Position = UDim2.new(1, 20, 0, 20)}):Play()
		wait(0.5)
		screenGui:Destroy()
	end)
end

return SwebLib
