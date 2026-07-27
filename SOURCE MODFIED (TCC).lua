local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Library = {}
Library.__index = Library

function Library.CreateWindow(title,subtitle,size,version)
	local self = setmetatable({}, Library)

	self.mainTabs = {}
	self.CurrentTab = nil
	self.Elements = {}
	self.Notipos = 0.9
	self.tabpos = 0
	self.Theme = {
		BackGroundIcon = "rbxassetid://139069464889319",
		TextColor = Color3.fromRGB(255, 255, 255),
		SubTtitleTextColor = Color3.fromRGB(125, 125, 125),
		Notisubtitlecolor = Color3.fromRGB(199, 199, 199),
		HeaderColor = Color3.fromRGB(16, 17, 31),
		headerlinecolor = Color3.fromRGB(255, 255, 255),
		headerlinetrans = 1,
		TabsScrollingBarFrameColor = Color3.fromRGB(255, 255, 255),
		NotiImg = "rbxassetid://133419353491012",
		NotiTitleColor = Color3.fromRGB(255, 255, 255),
		BackGroundTran = 0.05,
		DestroyGFrame = Color3.fromRGB(22, 23, 42),
		DestroyGFrameTransparency = 0,
		dbtntran = 0.95,
		TabTransparancy = 0.95,
		dbtncolor = Color3.fromRGB(255, 255, 255),
		versionBackgroundColor3 = Color3.fromRGB(224, 206, 255),
		versionBackgroundTransparency = 0,
		versionTextColor = Color3.fromRGB(0, 0, 0),
		IOSdraglineColor = Color3.fromRGB(63, 59, 126),
		TabTextColor = Color3.fromRGB(255, 255, 255),
		TabColor = Color3.fromRGB(255, 255, 255),
		TabSubTtitleTextColor = Color3.fromRGB(199, 199, 199),
		TogleActivColor = Color3.fromRGB(63, 59, 126),
		DropDownArrowImg = Color3.fromRGB(69, 65, 140),
		TabsIconColor = Color3.fromRGB(255, 255, 255),
		InputTextColor = Color3.fromRGB(175, 175, 175),
		BackGroundElemTran = 0.95,
		BackGroundElemCol = Color3.fromRGB(255, 255, 255),
		BackGroundButtonTran = 0.95,
		ActionBackColor = Color3.fromRGB(255, 255, 255),
		ToggleButton = Color3.fromRGB(255, 255, 255),
		ToggleTran = 0.9,
		SectionsScrollingBarFrameColor = Color3.fromRGB(255, 255, 255),
		DropDownColor = Color3.fromRGB(16, 17, 31),
		DropDownTransparency = 0,
		DropDownFrameColor = Color3.fromRGB(63, 59, 126),
		SliderUnderLineColor = Color3.fromRGB(63, 59, 126),
		Togglebtn = Color3.fromRGB(255, 255, 255),
		Sliderball = Color3.fromRGB(255, 255, 255),
		ColorPickerColoro = Color3.fromRGB(16, 17, 31),
		ListFrameColor = Color3.fromRGB(16, 17, 31)
	}
	self.CurrentThemeName = "Cursed"
	self.AllElements = {
		Toggles = {},
		Keybinds = {},
		Dropdowns = {},
		Sliders = {},
		ColorPickers = {},
		Inputs = {}
	}
	self.ScrollingFrameCanvasSize = 0
	self.BlurEffect = nil
	self.Connections = {}
	self.ActiveTweens = {}
	self.Windowscd = false
	self.userinfo = true
	self.saveFolder = nil
	self.saveFileName = nil
	self.ActiveNotifications = {}
	self.OriginalTabElements = {}
	self.CurrentSearchResults = {}
	self.IsSearching = false

	local function getTargetContainer()
		if RunService:IsStudio() then
			return Players.LocalPlayer:WaitForChild("PlayerGui")
		end

		if typeof(gethui) == "function" then
			return gethui()
		end

		local success, coreGui = pcall(function()
			return game:GetService("CoreGui")
		end)

		if success and coreGui then
			return coreGui
		end

		return nil
	end

	self.UI = Instance.new("ScreenGui")
	self.UI.Name = math.random(100000, 999999)
	self.UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	self.UI.Parent = getTargetContainer()

	self.ImageLabel = Instance.new("ImageLabel")
	self.ImageLabel.Parent = self.UI
	self.ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.ImageLabel.BackgroundTransparency = 1
	self.ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.ImageLabel.BorderSizePixel = 0
	self.ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	self.ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	self.ImageLabel.Size = UDim2.new(0,10,0,10)

	if UserInputService.touchEnabled then
		local uiScale = Instance.new("UIScale")
		uiScale.Scale = 0.75
		uiScale.Parent = self.ImageLabel
	end

	self.ImageLabel.Image = self.Theme.BackGroundIcon
	self.ImageLabel.Active = true
	self.ImageLabel.Selectable = true
	self.ImageLabel.Draggable = true
	self.ImageLabel.ImageTransparency = 0.05

	self.IOSdragline = Instance.new("Frame")
	self.IOSdragline.Parent = self.ImageLabel
	self.IOSdragline.BackgroundColor3 = self.Theme.IOSdraglineColor
	self.IOSdragline.BackgroundTransparency = 0.4
	self.IOSdragline.BorderSizePixel = 0
	self.IOSdragline.Position = UDim2.new(0.31, 0, 0.99, 0)
	self.IOSdragline.Size = UDim2.new(0.4, 0, 0, 5)
	self.IOSdragline.ZIndex = 2

	local UIcorner = Instance.new("UICorner")
	UIcorner.Parent = self.IOSdragline
	UIcorner.CornerRadius = UDim.new(0, 12)

	self.IOSdragHitbox = Instance.new("Frame")
	self.IOSdragHitbox.Parent = self.ImageLabel
	self.IOSdragHitbox.BackgroundTransparency = 1
	self.IOSdragHitbox.BorderSizePixel = 0

	self.IOSdragHitbox.Size = UDim2.new(0, 300, 0, 40)
	self.IOSdragHitbox.Position = UDim2.new(0.3, -25, 0.95, 0)
	self.IOSdragHitbox.ZIndex = 1

	self.IOSdragHitbox.Active = true
	self.IOSdragHitbox.Selectable = true

	local dragging = false
	local dragInput
	local startInputPos
	local startGuiPos
	local moveConnection

	self.IOSdragHitbox.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		for _, v in pairs(self.Frame_7:GetChildren()) do
			if v:IsA("GuiObject") then
				v.Interactable = false
			end
		end

		dragging = true
		dragInput = input
		startInputPos = input.Position
		startGuiPos = self.ImageLabel.Position

		self:Tween(self.IOSdragline, { BackgroundTransparency = 0 }, 0.2)

		moveConnection = input.Changed:Connect(function()
			if not dragging then return end
			if input.UserInputState ~= Enum.UserInputState.Change then return end

			local delta = input.Position - startInputPos

			self.ImageLabel.Position = UDim2.new(
				startGuiPos.X.Scale,
				startGuiPos.X.Offset + delta.X,
				startGuiPos.Y.Scale,
				startGuiPos.Y.Offset + delta.Y
			)
		end)
	end)

	self.IOSdragHitbox.InputEnded:Connect(function(input)
		if input ~= dragInput then return end

		for _, v in pairs(self.Frame_7:GetChildren()) do
			if v:IsA("GuiObject") then
				v.Interactable = true
			end
		end

		dragging = false
		dragInput = nil

		if moveConnection then
			moveConnection:Disconnect()
			moveConnection = nil
		end

		self:Tween(self.IOSdragline, { BackgroundTransparency = 0.4 }, 0.2)
	end)

	self.Destroy_gui = Instance.new("Frame")
	self.dFrame_2 = Instance.new("Frame")
	self.dTextLabel = Instance.new("TextLabel")
	local dUICorner = Instance.new("UICorner")
	self.dTextLabel_2 = Instance.new("TextLabel")
	self.dTextButton = Instance.new("TextButton")
	local dUICorner_2 = Instance.new("UICorner")
	self.dTextButton_2 = Instance.new("TextButton")
	local dUICorner_3 = Instance.new("UICorner")
	local dUICorner_4 = Instance.new("UICorner")

	self.Destroy_gui.Parent = self.ImageLabel
	self.Destroy_gui.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	self.Destroy_gui.BackgroundTransparency = 0.4
	self.Destroy_gui.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.Destroy_gui.BorderSizePixel = 0
	self.Destroy_gui.Position = UDim2.new(0.017231673, 0, 0.0208332706, 0)
	self.Destroy_gui.Size = UDim2.new(0, 560, 0, 460)
	self.Destroy_gui.Visible = false
	self.Destroy_gui.ZIndex = 10

	dUICorner_4.CornerRadius = UDim.new(0, 24)
	dUICorner_4.Parent = self.Destroy_gui

	self.dFrame_2.Parent = self.Destroy_gui
	self.dFrame_2.BackgroundColor3 = self.Theme.DestroyGFrame
	self.dFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.dFrame_2.BorderSizePixel = 0
	self.dFrame_2.Position = UDim2.new(0.306779772, 0, 0.328608334, 0)
	self.dFrame_2.Size = UDim2.new(0, 240, 0, 140)
	self.dFrame_2.Transparency = 1
	self.dFrame_2.BackgroundTransparency = self.Theme.DestroyGFrameTransparency
	self.dFrame_2.ZIndex = 10

	self.dTextLabel.Parent = self.dFrame_2
	self.dTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.dTextLabel.BackgroundTransparency = 1.000
	self.dTextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.dTextLabel.BorderSizePixel = 2
	self.dTextLabel.Position = UDim2.new(0.0291666668, 0, 0.0349650346, 0)
	self.dTextLabel.Size = UDim2.new(0, 200, 0, 36)
	self.dTextLabel.Font = Enum.Font.FredokaOne
	self.dTextLabel.Text = "Destroy Interface?"
	self.dTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	self.dTextLabel.TextSize = 23.000
	self.dTextLabel.TextWrapped = true
	self.dTextLabel.Visible = false
	self.dTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	dUICorner.CornerRadius = UDim.new(0, 12)
	dUICorner.Parent = self.dFrame_2

	self.dTextLabel_2.Parent = self.dFrame_2
	self.dTextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.dTextLabel_2.BackgroundTransparency = 1.000
	self.dTextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.dTextLabel_2.BorderSizePixel = 0
	self.dTextLabel_2.Position = UDim2.new(0.03, 0, 0.25, 0)
	self.dTextLabel_2.Size = UDim2.new(0, 219, 0, 40)
	self.dTextLabel_2.Font = Enum.Font.FredokaOne
	self.dTextLabel_2.TextWrapped = true
	self.dTextLabel_2.Text = "This action will permamently close the GUI."
	self.dTextLabel_2.TextColor3 = Color3.fromRGB(184, 184, 184)
	self.dTextLabel_2.TextSize = 15
	self.dTextLabel_2.Visible = false
	self.dTextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

	self.dTextButton.Parent = self.dFrame_2
	self.dTextButton.BackgroundColor3 = Color3.fromRGB(207, 0, 0)
	self.dTextButton.BackgroundTransparency = 0.4
	self.dTextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.dTextButton.BorderSizePixel = 0
	self.dTextButton.Position = UDim2.new(0.0170000009, 0, 0.721000016, 0)
	self.dTextButton.Size = UDim2.new(0, 112, 0, 36)
	self.dTextButton.ZIndex = 10
	self.dTextButton.Font = Enum.Font.FredokaOne
	self.dTextButton.Text = "Destroy"
	self.dTextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	self.dTextButton.Visible = false
	self.dTextButton.TextSize = 14.000

	self.dTextButton.MouseButton1Click:Connect(function()
		self:Destroy()
	end)

	dUICorner_2.CornerRadius = UDim.new(0, 5)
	dUICorner_2.Parent = self.dTextButton

	self.dTextButton_2.Parent = self.dFrame_2
	self.dTextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.dTextButton_2.BackgroundTransparency = 0.950
	self.dTextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.dTextButton_2.BorderSizePixel = 0
	self.dTextButton_2.Position = UDim2.new(0.51700002, 0, 0.721000016, 0)
	self.dTextButton_2.Size = UDim2.new(0, 112, 0, 36)
	self.dTextButton_2.ZIndex = 10
	self.dTextButton_2.Font = Enum.Font.FredokaOne
	self.dTextButton_2.Text = "Close"
	self.dTextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	self.dTextButton_2.Visible = false
	self.dTextButton_2.TextSize = 14.000

	self.dTextButton_2.MouseButton1Click:Connect(function()
		self:ShowDestroyQ()
	end)

	dUICorner_3.CornerRadius = UDim.new(0, 5)
	dUICorner_3.Parent = self.dTextButton_2

	function self:Blur()

	end
	function self:BlurOff()

	end
	self.Header = Instance.new("Frame")
	self.Header.Name = "Header"
	self.Header.Parent = self.ImageLabel
	self.Header.BackgroundColor3 = self.Theme.HeaderColor
	self.Header.BackgroundTransparency = 1
	self.Header.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.Header.BorderSizePixel = 0
	self.Header.Position = UDim2.new(0.0203390867, 0, 0.0250000004, 0)
	self.Header.Size = UDim2.new(0, size - 24, 0, 40)
	local HeaderUICorner = Instance.new("UICorner")
	HeaderUICorner.CornerRadius = UDim.new(0, 12)
	HeaderUICorner.Parent = self.Header

	self.Search = Instance.new("Frame")
	local SearchUICorner = Instance.new("UICorner")
	self.SearchImageLabel = Instance.new("ImageLabel")
	self.SearchTextBox2 = Instance.new("TextBox")

	self.SearchTextBox = self.SearchTextBox2

	self.SearchTextBox.Focused:Connect(function()
		if not self.OriginallyHidden then
			self.OriginallyHidden = {}
			for i, v in pairs(self.CurrentTab["Elements"]) do
				if not v.Visible then
					self.OriginallyHidden[i] = true
				end
			end
		end

		if self.SearchTextBox.Text == "Search..." then
			self.SearchTextBox.Text = ""
		end

		for i, v in pairs(self.CurrentTab["Elements"]) do
			if v.Visible then
				v.Visible = false
			end
		end
		self.SearchTextBox2.TextSize = 15.000
	end)

	self.SearchTextBox.FocusLost:Connect(function()
		if self.SearchTextBox.Text == "" then
			self.SearchTextBox2.TextSize = 14.000
			self.SearchTextBox.Text = "Search..."

			for i, v in pairs(self.CurrentTab["Elements"]) do
				if not self.OriginallyHidden or not self.OriginallyHidden[i] then
					v.Visible = true
				end
			end

			self.OriginallyHidden = nil
		end
	end)

	self.SearchTextBox:GetPropertyChangedSignal("Text"):Connect(function()
		self:SearchAllTabs()
	end)

	self.Search.Parent = self.Header
	self.Search.BackgroundColor3 =  self.Theme.dbtncolor
	self.Search.BackgroundTransparency =  self.Theme.dbtntran
	self.Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.Search.BorderSizePixel = 0
	self.Search.Position = UDim2.new(0.570, 0, 0.19, 0)
	self.Search.Size = UDim2.new(0, 140, 0, 26)

	SearchUICorner.Parent = self.Search
	SearchUICorner.CornerRadius = UDim.new(0.22, 0)

	self.SearchImageLabel.Parent = self.Search
	self.SearchImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.SearchImageLabel.BackgroundTransparency = 1.000
	self.SearchImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.SearchImageLabel.BorderSizePixel = 0
	self.SearchImageLabel.Position = UDim2.new(0.81, 0, 0.1, 0)
	self.SearchImageLabel.Size = UDim2.new(0, 20, 0, 20)
	self.SearchImageLabel.Image = "rbxassetid://136089190882362"

	self.SearchTextBox2.Parent = self.Search
	self.SearchTextBox2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.SearchTextBox2.BackgroundTransparency = 1.000
	self.SearchTextBox2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.SearchTextBox2.BorderSizePixel = 0
	self.SearchTextBox2.Position = UDim2.new(0.04, 0, 0.115000002, -0.9)
	self.SearchTextBox2.Size = UDim2.new(0, 90, 0, 20)
	self.SearchTextBox2.Font = Enum.Font.SourceSans
	self.SearchTextBox2.Text = "Search..."
	self.SearchTextBox2.Font = Enum.Font.FredokaOne
	self.SearchTextBox2.TextColor3 = self.Theme.TextColor
	self.SearchTextBox2.TextSize = 14.000
	self.SearchTextBox2.TextXAlignment = Enum.TextXAlignment.Left

	local function substr(str)
		local strlen = string.len(str)
		if(strlen > 50) then
			return string.sub(str,1,20)
		else
			return str
		end
	end

	local function labelsize(str)
		return string.len(str) * 7
	end

	local title = substr(title)
	local titlesize = labelsize(title)

	local subtitle = substr(subtitle)
	local subtitlesize = labelsize(subtitle)

	self.TextLabel = Instance.new("TextLabel")
	self.TextLabel.Parent = self.Header
	self.TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.TextLabel.BackgroundTransparency = 1.000
	self.TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.TextLabel.BorderSizePixel = 0
	self.TextLabel.Position = UDim2.new(0.02, 0, 0, -1)
	self.TextLabel.Size = UDim2.new(0, titlesize, 0, 40)
	self.TextLabel.Font = Enum.Font.FredokaOne
	self.TextLabel.Text = title
	self.TextLabel.TextColor3 = self.Theme.TextColor
	self.TextLabel.TextSize = 16.000
	self.TextLabel.TextWrapped = true
	self.TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	local positionsubt = self.TextLabel.Position.X.Scale
	local sizetitle = self.TextLabel.Size.X.Offset

	local trueposition = sizetitle + 10 + 5

	self.TextLabel_2 = Instance.new("TextLabel")
	self.TextLabel_2.Parent = self.Header
	self.TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.TextLabel_2.BackgroundTransparency = 1.000
	self.TextLabel_2.BorderColor3 = Color3.fromRGB(59, 59, 59)
	self.TextLabel_2.BorderSizePixel = 0
	self.TextLabel_2.Position = UDim2.new(0, trueposition, 0.05, -1)
	self.TextLabel_2.Size = UDim2.new(0, subtitlesize, 0, 40)
	self.TextLabel_2.Font = Enum.Font.FredokaOne
	self.TextLabel_2.Text = subtitle
	self.TextLabel_2.TextColor3 = self.Theme.SubTtitleTextColor
	self.TextLabel_2.TextSize = 12.000
	self.TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

	if version then
		self.version = Instance.new("Frame")
		self.versionUICorner = Instance.new("UICorner")
		self.versionTextLabel = Instance.new("TextLabel")

		self.version.Parent = self.Header
		self.version.BackgroundColor3 = self.Theme.versionBackgroundColor3
		self.version.BackgroundTransparency = self.Theme.versionBackgroundTransparency
		self.version.BorderColor3 = Color3.fromRGB(0, 0, 0)
		self.version.BorderSizePixel = 0
		self.version.Position = UDim2.new(0, trueposition + subtitlesize - 2, 0.20, 0)
		self.version.Size = UDim2.new(0, 55, 0, 24)

		self.versionUICorner.Parent = self.version
		self.versionUICorner.CornerRadius = UDim.new(0, 11)

		self.versionTextLabel.Parent = self.version
		self.versionTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		self.versionTextLabel.BackgroundTransparency = 1.000
		self.versionTextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		self.versionTextLabel.BorderSizePixel = 0
		self.versionTextLabel.Position = UDim2.new(0.08, 0, 0.11, 0)
		self.versionTextLabel.Size = UDim2.new(0, 45, 0, 18)
		self.versionTextLabel.Font = Enum.Font.FredokaOne
		self.versionTextLabel.Text = version
		self.versionTextLabel.TextColor3 = self.Theme.versionTextColor
		self.versionTextLabel.TextSize = 14.000
	end

	self.Frame = Instance.new("Frame")
	self.Frame.Parent = self.Header
	self.Frame.BackgroundColor3 = self.Theme.headerlinecolor
	self.Frame.BackgroundTransparency = 0.95
	self.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.Frame.BorderSizePixel = 0
	self.Frame.Position = UDim2.new(0, -1, 1, 0)
	self.Frame.Size = UDim2.new(0, 197, 0, 2)

	self.close = Instance.new("ImageButton")
	self.close.Parent = self.Header
	self.close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.close.BackgroundTransparency = 1.000
	self.close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.close.BorderSizePixel = 0
	self.close.Position = UDim2.new(0.935, 0, 0.2, 0)
	self.close.Size = UDim2.new(0, 24, 0, 24)
	self.close.Image = "rbxassetid://115483385285173"

	local btnclose = Instance.new("TextButton")
	btnclose.Parent = self.close
	btnclose.Size = UDim2.new(0, 24, 0, 24)
	btnclose.Text = ""
	btnclose.Transparency = 1
	btnclose.Position = UDim2.new(0, 0 , 0, 0)

	local btnclose3 = Instance.new("TextButton")

	btnclose.MouseButton1Click:Connect(function()
		self:ShowDestroyQ()
	end)

	self.ImageButton = Instance.new("ImageButton")
	self.ImageButton.Parent = self.Header
	self.ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.ImageButton.BackgroundTransparency = 1.000
	self.ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.ImageButton.BorderSizePixel = 0
	self.ImageButton.Position = UDim2.new(0.887, 0, 0.35, 0)
	self.ImageButton.Size = UDim2.new(0, 16, 0, 12)
	self.ImageButton.Image = "rbxassetid://89738650787294"

	local btnclose2 = Instance.new("TextButton")
	btnclose2.Parent = self.ImageButton
	btnclose2.Size = UDim2.new(0, 20, 0, 20)
	btnclose2.Text = ""
	btnclose2.Transparency = 1
	btnclose2.Position = UDim2.new(0, -2.9 , 0, -4)

	btnclose2.MouseButton1Click:Connect(function()
		self:ColumnWindow()
	end)

	self.ImageButton_2 = Instance.new("ImageButton")
	self.ImageButton_2.Parent = self.Header
	self.ImageButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.ImageButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.ImageButton_2.BorderSizePixel = 0
	self.ImageButton_2.Position = UDim2.new(0.825, 0, 0.29, 0)
	self.ImageButton_2.Size = UDim2.new(0, 18, 0, 18)
	self.ImageButton_2.Image = "rbxassetid://122178947900744"
	self.ImageButton_2.BackgroundTransparency = 1.000

	local btnclose3 = Instance.new("TextButton")
	btnclose3.Parent = self.ImageButton_2
	btnclose3.Size = UDim2.new(0, 22, 0, 20)
	btnclose3.Text = ""
	btnclose3.Transparency = 1
	btnclose3.Position = UDim2.new(0, -2 , 0, -9)

	btnclose3.MouseButton1Click:Connect(function()
		self:Minimaze()
	end)

	self.Tabs = Instance.new("Frame")
	self.Frame_2 = Instance.new("Frame")
	local ImageButton_3 = Instance.new("ImageButton")
	local ImageButton_4 = Instance.new("ImageButton")
	local ImageButton_5 = Instance.new("ImageButton")
	self.ScrollingFrame = Instance.new("ScrollingFrame")
	self.Tabs.Name = "Tabs"
	self.Tabs.Parent = self.ImageLabel
	self.Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.Tabs.BackgroundTransparency = 1
	self.Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.Tabs.BorderSizePixel = 0
	self.Tabs.Position = UDim2.new(0.035, 0, 0.116, 0)
	self.Tabs.Size = UDim2.new(0, 185, 0, 372)

	self.WindowUser = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")
	local UICorner = Instance.new("UICorner")
	local UICorner_User = Instance.new("UICorner")
	self.wTextLabel = Instance.new("TextLabel")
	self.wTextLabel_2 = Instance.new("TextLabel")

	self.WindowUser.Parent = self.Tabs
	self.WindowUser.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.WindowUser.BackgroundTransparency = 0.95
	self.WindowUser.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.WindowUser.BorderSizePixel = 0
	self.WindowUser.Position = UDim2.new(0, 0, 0.97, 0)
	self.WindowUser.Size = UDim2.new(0, 175, 0, 45)

	UICorner_User.CornerRadius = UDim.new(0.3, 0)
	UICorner_User.Parent = self.WindowUser

	ImageLabel.Parent = self.WindowUser
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
	ImageLabel.Size = UDim2.new(0, 30, 0, 30)
	ImageLabel.Image = "rbxasset://textures/ui/LuaChat/graphic/gr-profile-placeholder-70x70.png"

	local userimg = "rbxasset://textures/ui/LuaChat/graphic/gr-profile-placeholder-70x70.png"

	task.spawn(function()
		local userId = Players.LocalPlayer.UserId
		local thumbnailType = Enum.ThumbnailType.HeadShot
		local thumbnailSize = Enum.ThumbnailSize.Size150x150

		local success, thumbnailUrl = pcall(function()
			return Players:GetUserThumbnailAsync(userId, thumbnailType, thumbnailSize)
		end)

		if success and thumbnailUrl then
			task.defer(function()
				ImageLabel.Image = thumbnailUrl
				userimg = thumbnailUrl
			end)
		end
	end)

	UICorner.CornerRadius = UDim.new(0, 100)
	UICorner.Parent = ImageLabel

	local function limit(str)
		if #str > 14 then
			return string.sub(str, 1, 14) .. "..."
		else
			return str
		end
	end

	local realDisplay = limit(Players.LocalPlayer.DisplayName)
	local realName = limit(Players.LocalPlayer.Name)

	local ImageLabelRef = ImageLabel
	local toggled = false

	self.WindowUser.InputBegan:Connect(function(input)

		if input.UserInputType == Enum.UserInputType.MouseButton1 then

			toggled = not toggled

			if toggled then
				ImageLabelRef.Image = ""
				self.wTextLabel.Text = "Roblox"
				self.wTextLabel_2.Text = "@Roblox"
			else
				ImageLabelRef.Image = userimg
				self.wTextLabel.Text = realDisplay
				self.wTextLabel_2.Text = "@" .. realName
			end

		end

		if input.UserInputType == Enum.UserInputType.Touch then

			toggled = not toggled

			if toggled then
				ImageLabelRef.Image = ""
				self.wTextLabel.Text = "Roblox"
				self.wTextLabel_2.Text = "@Roblox"
			else
				ImageLabelRef.Image = userimg
				self.wTextLabel.Text = realDisplay
				self.wTextLabel_2.Text = "@" .. realName
			end

		end
	end)

	self.wTextLabel.Parent = self.WindowUser
	self.wTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.wTextLabel.BackgroundTransparency = 1.000
	self.wTextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.wTextLabel.BorderSizePixel = 0
	self.wTextLabel.Position = UDim2.new(0.27, 0, 0, 7)
	self.wTextLabel.Size = UDim2.new(0, 131, 0, 15)
	self.wTextLabel.Font = Enum.Font.FredokaOne
	self.wTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	self.wTextLabel.TextSize = 14.000
	self.wTextLabel.Text = realDisplay
	self.wTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	self.wTextLabel_2.Parent = self.WindowUser
	self.wTextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.wTextLabel_2.BackgroundTransparency = 1.000
	self.wTextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.wTextLabel_2.BorderSizePixel = 0
	self.wTextLabel_2.Position = UDim2.new(0.27, 0, 0, 21)
	self.wTextLabel_2.Size = UDim2.new(0, 131, 0, 15)
	self.wTextLabel_2.Font = Enum.Font.FredokaOne
	self.wTextLabel_2.TextColor3 = Color3.fromRGB(171, 171, 171)
	self.wTextLabel_2.TextSize = 14.000
	self.wTextLabel_2.Text = "@" .. realName
	self.wTextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

	self.Frame_2.Parent = self.Tabs
	self.Frame_2.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
	self.Frame_2.BackgroundTransparency = 0.95
	self.Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.Frame_2.BorderSizePixel = 0
	self.Frame_2.Position = UDim2.new(1, 0, 0, 0)
	self.Frame_2.Size = UDim2.new(0, 2, 0, 413)

	self.ScrollingFrame.Parent = self.Tabs
	self.ScrollingFrame.Active = true
	self.ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.ScrollingFrame.BackgroundTransparency = 1.000
	self.ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.ScrollingFrame.BorderSizePixel = 0
	self.ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
	self.ScrollingFrame.Size = UDim2.new(0, 187, 0, 358)
	self.ScrollingFrame.ScrollBarThickness = 2
	self.ScrollingFrame.ScrollBarImageColor3 = self.Theme.TabsScrollingBarFrameColor

	self.Sections = Instance.new("Frame")
	self.Sections.Name = "Sections"
	self.Sections.Parent = self.ImageLabel
	self.Sections.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.Sections.BackgroundTransparency = 1
	self.Sections.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.Sections.BorderSizePixel = 0
	self.Sections.Position = UDim2.new(0.35, 0, 0.11, 0)
	self.Sections.Size = UDim2.new(0, 380, 0, 414)

	self.TextLabel_5 = Instance.new("TextLabel")
	self.TextLabel_5.Parent = self.Sections
	self.TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.TextLabel_5.BackgroundTransparency = 1.000
	self.TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.TextLabel_5.BorderSizePixel = 0
	self.TextLabel_5.Position = UDim2.new(0.0191, 0, 0.0144, 0)
	self.TextLabel_5.Size = UDim2.new(0, 192, 0, 29)
	self.TextLabel_5.Font = Enum.Font.FredokaOne
	self.TextLabel_5.Text = ''
	self.TextLabel_5.TextColor3 = self.Theme.TextColor
	self.TextLabel_5.TextSize = 24.000
	self.TextLabel_5.TextWrapped = true
	self.TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left

	self.Frame_7 = Instance.new("Frame")
	self.Frame_7.Parent = self.Sections
	self.Frame_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	self.Frame_7.BackgroundTransparency = 1.000
	self.Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
	self.Frame_7.BorderSizePixel = 0
	self.Frame_7.Position = UDim2.new(0, 0, 0.08454106, 0)
	self.Frame_7.Size = UDim2.new(0, 366, 0, 379)

	local TypeIcons = {
		Notification = "rbxassetid://75930996983661",
		Warn = "rbxassetid://85045950898455",
		Error = "rbxassetid://71852580046993"
	}

	function Library:Notification(config)
		self.NotificationCounter = (self.NotificationCounter or 0) + 1
		local notificationId = self.NotificationCounter
		self.ActiveNotifications = self.ActiveNotifications or {}

		local title = config.Name or "Notification"
		local description = config.Description or ""
		local duration = config.Duration or 5
		local notiType = config.Type or "Notification"

		local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled
		local targetX = isMobile and 0.55 or 0.8
		local startY = isMobile and 0.75 or 0.9
		local offsetMulti = isMobile and 0.2 or 0.08
		local width = isMobile and 280 or 360

		if not self.NotificationTemplate then
			self:CreateNotificationTemplate()
		end

		local Notification = self.NotificationTemplate:Clone()

		local img = TypeIcons[notiType]
		if notiType == 'Notification' then
			Notification.Icon.ImageColor3 = self.Theme.TabsIconColor
		end

		if not img then return end

		Notification.Name = notiType
		Notification.Parent = self.UI
		Notification.Size = UDim2.new(0, width, 0, 75)
		Notification.Position = UDim2.new(1.2, 0, startY, 0)
		Notification.Visible = true
		Notification.Image = self.Theme.NotiImg

		Notification.Icon.Image = img
		Notification.Title.Text = title
		Notification.Description.Text = description
		Notification.Title.TextColor3 = self.Theme.TextColor
		Notification.Description.TextColor3 = self.Theme.Notisubtitlecolor
		Notification.CloseButton.ImageColor3 = self.Theme.TabsIconColor

		Notification.CloseButton.MouseButton1Click:Connect(function()
			self:CloseNotification(notificationId)
		end)

		self.ActiveNotifications[notificationId] = {
			notification = Notification,
			targetX = targetX,
			targetY = startY,
			multi = offsetMulti
		}

		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		TweenService:Create(Notification, tweenInfo, {Position = UDim2.new(targetX, 0, startY, 0)}):Play()

		for id, notifData in pairs(self.ActiveNotifications) do
			if id ~= notificationId then
				local newY = notifData.notification.Position.Y.Scale - offsetMulti
				notifData.targetY = newY
				TweenService:Create(notifData.notification, tweenInfo, {Position = UDim2.new(targetX, 0, newY, 0)}):Play()
			end
		end

		task.delay(duration, function()
			self:CloseNotification(notificationId)
		end)
	end

	function Library:CreateNotificationTemplate()
		local template = Instance.new("ImageLabel")
		template.Name = "NotificationTemplate"
		template.BackgroundTransparency = 1.000
		template.BorderSizePixel = 0
		template.Size = UDim2.new(0, 360, 0, 75)
		template.Visible = false
		template.ZIndex = 50

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0, 6)
		UICorner.Parent = template

		local Icon = Instance.new("ImageLabel")
		Icon.Name = "Icon"
		Icon.Parent = template
		Icon.BackgroundTransparency = 1.000
		Icon.Position = UDim2.new(0.04, 0, 0.24, 0)
		Icon.Size = UDim2.new(0, 18, 0, 18)
		Icon.ZIndex = 51

		local Description = Instance.new("TextLabel")
		Description.Name = "Description"
		Description.Parent = template
		Description.BackgroundTransparency = 1.000
		Description.Position = UDim2.new(0.04, 0, 0.47, 0)
		Description.Size = UDim2.new(0, 321, 0, 23)
		Description.Font = Enum.Font.FredokaOne
		Description.TextSize = 14.000
		Description.TextXAlignment = Enum.TextXAlignment.Left
		Description.ZIndex = 51

		local Title = Instance.new("TextLabel")
		Title.Name = "Title"
		Title.Parent = template
		Title.BackgroundTransparency = 1.000
		Title.Position = UDim2.new(0.11, 0, 0.19, 0)
		Title.Size = UDim2.new(0, 200, 0, 24)
		Title.Font = Enum.Font.FredokaOne
		Title.TextSize = 18.000
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.ZIndex = 51

		local CloseButton = Instance.new("ImageButton")
		CloseButton.Name = "CloseButton"
		CloseButton.Parent = template
		CloseButton.BackgroundTransparency = 1.000
		CloseButton.Position = UDim2.new(0.91, 0, 0.21, 0)
		CloseButton.Size = UDim2.new(0, 14, 0, 14)
		CloseButton.ZIndex = 51
		CloseButton.Image = "rbxassetid://134899599114088"

		self.NotificationTemplate = template
	end

	function Library:CloseNotification(notificationId)
		local data = self.ActiveNotifications[notificationId]
		if not data then return end

		local notification = data.notification
		self.ActiveNotifications[notificationId] = nil

		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local tweenOut = TweenService:Create(notification, tweenInfo, {Position = UDim2.new(1.2, 0, notification.Position.Y.Scale, 0)})
		tweenOut:Play()

		tweenOut.Completed:Connect(function()
			notification:Destroy()
		end)

		local activeList = {}
		for id, notifData in pairs(self.ActiveNotifications) do
			table.insert(activeList, {id = id, data = notifData})
		end

		table.sort(activeList, function(a, b) return a.id < b.id end)

		local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled
		local startY = isMobile and 0.75 or 0.9

		local currentY = startY
		for i = #activeList, 1, -1 do
			local item = activeList[i]
			TweenService:Create(item.data.notification, tweenInfo, {Position = UDim2.new(item.data.targetX, 0, currentY, 0)}):Play()
			currentY = currentY - item.data.multi
		end
	end

	self.Tabs.Visible = false
	self.Sections.Visible = false

	self.Search.Visible = false
	self.TextLabel.Visible = false
	self.TextLabel_2.Visible = false
	self.version.Visible = false
	self.close.Visible = false
	self.ImageButton.Visible = false
	self.ImageButton_2.Visible = false
	self.IOSdragline.Visible = false
	self.IOSdragHitbox.Visible = false
	self.Frame.Visible = false

	self:Tween(self.ImageLabel,{Size = UDim2.new(0,size,0,480)},0.9)
	wait(0.9)

	self.Tabs.Visible = true
	self.Sections.Visible = true
	self.Frame.Visible = true
	self.Search.Visible = true
	self.TextLabel.Visible = true
	self.TextLabel_2.Visible = true
	self.version.Visible = true
	self.close.Visible = true
	self.ImageButton.Visible = true
	self.ImageButton_2.Visible = true
	self.IOSdragline.Visible = true
	self.IOSdragHitbox.Visible = true

	return self
end

local TAB_ICONS = {
	["Settings"]  = "rbxassetid://121074539743502",
	["Visual"]    = "rbxassetid://92250291747112",
	["Player"]    = "rbxassetid://92793433656183", 
	["Combat"]    = "rbxassetid://73787033062338", 
	["Generator"] = "rbxassetid://88963434013027", 
	["AutoFarm"]  = "rbxassetid://78576858777870", 
	["Animation"] = "rbxassetid://126672101469278", 
	["Items"]     = "rbxassetid://100873317961037", 
	["Teleport"]  = "rbxassetid://93236186125909", 
	["Badge"]     = "rbxassetid://119734718512317",
	["Quests"]    = "rbxassetid://88588775334975",
	["Main"]      = "rbxassetid://103472623123751",
	["Halloween"] = "rbxassetid://115053236948532",
	["Misc"]      = "rbxassetid://137583062645541", 
	["Block"]     = "rbxassetid://94027029642332",
	["Aim"]       = "rbxassetid://130183131122604", 
	["Fun"]       = "rbxassetid://137362629704355", 
	["Fish"]      = "rbxassetid://105045060721724",
	["WebHook"]   = "rbxassetid://120375090333993",
	["Heart"]     = "rbxassetid://111088001331743",
	["Shop"]      = "rbxassetid://82363507426406",
	["Boat"]      = "rbxassetid://103950075513303",
	["Trade"]     = "rbxassetid://128997687956087",
	["Text"]   = "rbxassetid://140272486271785", 
}

function Library:AddTab(name : string,icon : string)
	local tab = {
		Name = name,
		Elements = {},
		Container = nil,
		Button = nil,
		Frame = nil,
		pos = 0,
		Icon = icon,
		Tab = {},
		ElemBtn = {},
		Texttitle = {},
		Textsubtitle = {},
		actionBakcColor = {},
		BtnImg = {},
		ArrowImg = {},
		ListFrames = {},
		DropImg = {},
		DropDownArrowImg = {},
		DropDownFrameColor = {},
		ActiveToggleColor = {},
		InputTextColor = {},
		SliderUnderLineColor = {},
		Togglebtn = {},
		Sliderball = {},
		Connections = {},
		KeybindConnections = {},
		ColorPickerColor = {},
		SearchData = {}
	}

	setmetatable(tab, { __index = self })

	local Frame_3 = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")
	local TextLabel_3 = Instance.new("TextLabel")
	local Frame_4 = Instance.new("Frame")

	Frame_3.Parent = self.ScrollingFrame
	Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_3.BackgroundTransparency = 1.000
	Frame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_3.BorderSizePixel = 0
	Frame_3.Position = UDim2.new(0, 0, 0, 8 + self.tabpos)
	Frame_3.Size = UDim2.new(0, 173, 0, 35)
	Frame_3.Text = ''
	table.insert(tab.Tab, Frame_3)

	self.tabpos += 40

	Frame_3.MouseEnter:Connect(function()
		self:Tween(Frame_3,{BackgroundTransparency = self.Theme.TabTransparancy},0.3)
		self:Tween(Frame_4,{Size = UDim2.new(0, 2, 0, 23)},0.3)
		self:Tween(Frame_4,{BackgroundTransparency = 0},0.3)
	end)

	Frame_3.MouseLeave:Connect(function()
		if self.CurrentTab ~= tab then
			self:Tween(Frame_3,{BackgroundTransparency = 1},0.3)
			self:Tween(Frame_4,{BackgroundTransparency = 1},0.3)
			self:Tween(Frame_4,{Size = UDim2.new(0, 2, 0, 0)},0.3)
		end
	end)

	Frame_3.MouseButton1Click:Connect(function()
		self:SelectTab(tab,Frame_3)
	end)

	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = Frame_3

	local textpos2 = 0.05

	if (icon ~= nil and icon ~= '') then
		textpos2 = 0.21
	else
		textpos2 = 0.05
		icon = 1
	end

	icon = TAB_ICONS[icon] or icon

	TextLabel_3.Parent = Frame_3
	TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel_3.BackgroundTransparency = 1.000
	TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel_3.BorderSizePixel = 0
	TextLabel_3.Position = UDim2.new(textpos2, 0, 0, -1)
	TextLabel_3.Size = UDim2.new(0, 52, 0, 35)
	TextLabel_3.Font = Enum.Font.FredokaOne
	TextLabel_3.Text = name
	TextLabel_3.TextColor3 = self.Theme.TabTextColor
	table.insert(tab.Tab, TextLabel_3)
	TextLabel_3.TextSize = 14.000
	TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

	Frame_4.Parent = Frame_3
	Frame_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame_4.BackgroundTransparency = 1.000
	Frame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_4.BorderSizePixel = 0
	Frame_4.Position = UDim2.new(0, 1, 0.171428576, 0)
	Frame_4.Size = UDim2.new(0, 2, 0, 0)
	table.insert(tab.Tab, 3,Frame_4)

	local ScrollingFrame_2 = Instance.new("ScrollingFrame")
	ScrollingFrame_2.Name = "ScrollingFrame"
	ScrollingFrame_2.Parent = self.Frame_7
	ScrollingFrame_2.Active = true
	ScrollingFrame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame_2.BackgroundTransparency = 1.000
	ScrollingFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame_2.BorderSizePixel = 0
	ScrollingFrame_2.Position = UDim2.new(0, 0, 0.023, 0)
	ScrollingFrame_2.Size = UDim2.new(0, 381, 0, 370)
	ScrollingFrame_2.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame_2.ScrollBarThickness = 2
	ScrollingFrame_2.Visible = false
	table.insert(tab.Tab, 5,ScrollingFrame_2)

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Parent = Frame_3
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0, 8, 0, 6.5)
	ImageLabel.Size = UDim2.new(0, 22, 0, 22)
	ImageLabel.Image = icon
	table.insert(tab.Tab,4,ImageLabel)

	tab.Container = ScrollingFrame_2
	tab.Button = Frame_3
	tab.Frame = Frame_4

	table.insert(self.mainTabs, tab)

	if #self.mainTabs == 1 then
		self:SelectTab(tab, Frame_3)
	end

	function tab:CalcScroll()
		self.pos = 0
		for i,v in pairs(tab.Elements) do
			if v.Visible == true and v.ClassName ~= "Frame" or v.Name == "Paragraph" then
				self.pos += v.Size.Y.Offset + 5
			end
		end
		self.Tab[5].CanvasSize = UDim2.new(0, 0, 0, self.pos)
	end

	function tab:Reposelem()
		local startpos = 0
		for i,v in pairs(tab.Elements) do
			if v.Visible == true and v.Parent:IsA("ScrollingFrame") then
				v.Position = UDim2.new(v.Position.X.Scale, v.Position.X.Offset, v.Position.Y.Scale, startpos)
				if v.Name == "List" and v:FindFirstChildOfClass("Frame").Visible == true then
					local Frame = v:FindFirstChildOfClass("Frame")
					if Frame then
						startpos += Frame.Size.Y.Offset + 5
					end
				elseif v.ClassName == "Frame" then
					startpos += v.Size.Y.Offset + 5
				else
					startpos += v.Size.Y.Offset + 5
				end

			end
		end
		self:CalcScroll()
	end

	function tab:AddList(config)
		local Config = {
			Name = config.Name,
			Elems = config.Elems,
		}

		local List = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local name = Instance.new("TextLabel")
		local ImageLabel = Instance.new("ImageLabel")
		local Frame = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")

		List.Name = "List"
		List.Parent = self.Container
		List.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		List.BackgroundTransparency = self.Theme.BackGroundElemTran
		List.BorderColor3 = Color3.fromRGB(0, 0, 0)
		List.BorderSizePixel = 0
		List.Position = UDim2.new(0, 7, 0, self.pos)
		List.Size = UDim2.new(0, 360, 0, 30)
		List.Text = ""
		table.insert(tab.ElemBtn, List)

		UICorner.CornerRadius = UDim.new(0, 12)
		UICorner.Parent = List

		name.Parent = List
		name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		name.BackgroundTransparency = 1.000
		name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		name.BorderSizePixel = 0
		name.Position = UDim2.new(0.0290000141, 0, 0, 4)
		name.Size = UDim2.new(0, 77, 0, 20)
		name.Font = Enum.Font.FredokaOne
		name.Text = tostring(Config.Name) or "Test"
		name.TextColor3 = Color3.fromRGB(255, 255, 255)
		name.TextSize = 16.000
		name.TextXAlignment = Enum.TextXAlignment.Left
		table.insert(tab.Texttitle, name)

		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.87, 0, 0.1, 0)
		ImageLabel.Rotation = -90
		ImageLabel.Size = UDim2.new(0, 24, 0, 24)
		ImageLabel.Image = "rbxassetid://126982255108418"
		ImageLabel.ImageColor3 = self.Theme.DropDownArrowImg
		ImageLabel.Parent = List
		table.insert(tab.ArrowImg, ImageLabel)

		Frame.Parent = List
		Frame.BackgroundColor3 = self.Theme.ListFrameColor
		Frame.BackgroundTransparency = 0.65
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.new(0, 360, 0, 144)
		Frame.Visible = false
		table.insert(self.Elements, Frame)
		table.insert(tab.ListFrames, Frame)

		UICorner_2.CornerRadius = UDim.new(0, 12)
		UICorner_2.Parent = Frame

		local size = 31

		for i,v in pairs(Config.Elems) do
			if v.Elem then
				v.Elem.Visible = false
				v.Elem.Parent = Frame
				v.Elem.Position = UDim2.new(0, 0, 0, size)
				size += v.Elem.Size.Y.Offset + 5
			end
		end

		local ListClose = true
		local FrameSize = UDim2.new(0, 360, 0, size)
		local ListPos = List.Position

		List.MouseButton1Click:Connect(function()
			if ListClose then
				Frame.Visible = true
				Library:Tween(ImageLabel,{Rotation = 0},0.5)
				Frame.Size = FrameSize
				ListClose = false
				for i,v in pairs(Config.Elems) do
					if v.Elem then
						v.Elem.Visible = true
					end
				end

				self:Reposelem()

				Frame.Parent = self.Container
				Frame.Position = List.Position
				List.Parent = Frame
				List.Position = UDim2.new(0, 0, 0, 0)

				local size = 35

				for i,v in pairs(Config.Elems) do
					if v.Elem then
						v.Elem.Position = UDim2.new(0, 0, 0, size)
						size += v.Elem.Size.Y.Offset + 5
					end
				end
			else
				List.Parent = self.Container
				List.Position = ListPos
				Frame.Parent = List

				Library:Tween(ImageLabel,{Rotation = -90},0.5)
				Frame.Size = UDim2.new(0, 360, 0, 0)

				Frame.Visible = false
				ListClose = true

				for i,v in pairs(Config.Elems) do
					if v.Elem then
						v.Elem.Visible = false
					end
				end

				self:Reposelem()
			end
		end)

		table.insert(self.Elements, List)

		self.pos = self.pos + List.Size.Y.Offset + 5
		tab:CalcScroll()

		tab.SearchData[List] = (config.Name or "") .. " " .. ("")
	end

	function tab:AddParagraph(title, subtitle)
		local TextService = game:GetService("TextService")

		local Paragraph = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local TitleLabel = Instance.new("TextLabel")
		local ContentLabel = Instance.new("TextLabel")

		Paragraph.Name = "Paragraph"
		Paragraph.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		Paragraph.BackgroundTransparency = self.Theme.BackGroundElemTran
		Paragraph.BorderSizePixel = 0
		Paragraph.Position = UDim2.new(0, 7, 0, self.pos)

		UICorner.CornerRadius = UDim.new(0, 12)
		UICorner.Parent = Paragraph

		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Position = UDim2.new(0.027, 0, 0, 5)
		TitleLabel.Size = UDim2.new(0, 328, 0, 20)
		TitleLabel.Font = Enum.Font.FredokaOne
		TitleLabel.Text = title or ""
		TitleLabel.TextColor3 = self.Theme.TabTextColor
		TitleLabel.TextSize = 16
		TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
		TitleLabel.TextWrapped = false
		TitleLabel.Parent = Paragraph

		ContentLabel.BackgroundTransparency = 1
		ContentLabel.Position = UDim2.new(0.027, 0, 0, 28)
		ContentLabel.Size = UDim2.new(0, 328, 0, 10)
		ContentLabel.Font = Enum.Font.FredokaOne
		ContentLabel.Text = subtitle or ""
		ContentLabel.TextColor3 = self.Theme.TabSubTtitleTextColor
		ContentLabel.TextSize = 14
		ContentLabel.TextWrapped = true
		ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
		ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
		ContentLabel.Parent = Paragraph

		Paragraph.Parent = self.Container

		table.insert(tab.ElemBtn, Paragraph)
		table.insert(tab.Texttitle, TitleLabel)
		table.insert(tab.Textsubtitle, ContentLabel)
		table.insert(self.Elements, Paragraph)

		local function recalcSizes()
			local contentText = ContentLabel.Text
			local textSizeVec = TextService:GetTextSize(contentText, ContentLabel.TextSize, ContentLabel.Font, Vector2.new(328, 10000))
			local contentHeight = math.max(16, math.ceil(textSizeVec.Y))

			ContentLabel.Size = UDim2.new(0, 328, 0, contentHeight + 4)
			Paragraph.Size = UDim2.new(0, 360, 0, 33 + contentHeight)
		end

		recalcSizes()

		local paragraphObj = {
			Element = Paragraph,
			Elem = Paragraph,
			Update = function(objSelf, newTitle, newSubtitle)
				if not objSelf.Element then return end

				if newTitle then TitleLabel.Text = newTitle end
				if newSubtitle then ContentLabel.Text = newSubtitle end

				recalcSizes()

				tab.SearchData[objSelf.Element] = TitleLabel.Text .. " " .. ContentLabel.Text
				tab:CalcScroll()
			end,

			SetVisible = function(objSelf, visible)
				if objSelf.Element then
					objSelf.Element.Visible = visible
				end
			end,

			Destroy = function(objSelf)
				if objSelf.Element then
					objSelf.Element:Destroy()
					objSelf.Element = nil
				end
			end
		}

		self.pos = self.pos + Paragraph.Size.Y.Offset + 5
		tab:CalcScroll()

		tab.SearchData[Paragraph] = (title or "") .. " " .. (subtitle or "")

		return paragraphObj
	end

	function tab:AddImage(config)
		local image = {
			Image = config.Image or "",
			Size = config.Size or UDim2.new(0, 80, 0, 80),
			CornerRadius = config.CornerRadius or UDim.new(0, 12),
		}

		local ImageButton = Instance.new("ImageButton")
		table.insert(tab.ElemBtn, ImageButton)

		ImageButton.Parent = self.Container
		ImageButton.BackgroundTransparency = 1
		ImageButton.BorderSizePixel = 0
		ImageButton.Position = UDim2.new(0, 7, 0, self.pos)
		ImageButton.Size = image.Size
		ImageButton.Image = image.Image

		if image.CornerRadius then
			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = image.CornerRadius
			UICorner.Parent = ImageButton
		end

		table.insert(self.Elements, ImageButton)
		self.pos += ImageButton.Size.Y.Offset + 5
		tab:CalcScroll()
	end

	function tab:AddSection(title)
		local TextLabel = Instance.new("TextLabel")
		table.insert(tab.Texttitle, TextLabel)

		TextLabel.Parent = self.Container
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0.029, 0, 0, self.pos)
		TextLabel.Size = UDim2.new(0, 193, 0, 21)
		TextLabel.Font = Enum.Font.FredokaOne
		TextLabel.Text = title
		TextLabel.TextColor3 = self.Theme.TabTextColor
		TextLabel.TextSize = 18.000
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left

		table.insert(self.Elements, TextLabel)
		self.pos += 26
		tab:CalcScroll()
	end

	function tab:AddButton(config)
		local button = {
			Name = config.Name,
			Description = config.Description or '',
			Callback = config.Callback
		}

		local Button = Instance.new("TextButton")
		table.insert(tab.ElemBtn, Button)
		local UICorner = Instance.new("UICorner")
		local name = Instance.new("TextLabel")
		table.insert(tab.Texttitle, name)
		local subtext = Instance.new("TextLabel")
		table.insert(tab.Textsubtitle, subtext)
		local ImageLabel = Instance.new("ImageLabel")

		Button.Name = "Button"
		Button.Parent = self.Container
		Button.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		Button.BackgroundTransparency = self.Theme.BackGroundElemTran
		Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(0, 7, 0, self.pos)
		Button.Size = UDim2.new(0, 360, 0, 45)
		Button.Text = ''

		Button.MouseButton1Click:Connect(function()
			if button.Callback then
				button.Callback()
			end
		end)

		UICorner.Parent = Button
		UICorner.CornerRadius = UDim.new(0, 12)

		local namepos = config.Description and config.Description ~= '' and 4 or 12.5

		name.Parent = Button
		name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		name.BackgroundTransparency = 1.000
		name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		name.BorderSizePixel = 0
		name.Position = UDim2.new(0.0290000141, 0, 0, namepos)
		name.Size = UDim2.new(0, 77, 0, 20)
		name.Font = Enum.Font.FredokaOne
		name.Text = button.Name
		name.TextColor3 = self.Theme.TabTextColor
		name.TextSize = 16.000
		name.TextXAlignment = Enum.TextXAlignment.Left

		subtext.Parent = Button
		subtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		subtext.BackgroundTransparency = 1.000
		subtext.BorderColor3 = Color3.fromRGB(0, 0, 0)
		subtext.BorderSizePixel = 0
		subtext.Position = UDim2.new(0.0289855078, 0, 0, 25)
		subtext.Size = UDim2.new(0, 193, 0, 14)
		subtext.Font = Enum.Font.FredokaOne
		subtext.Text = button.Description
		subtext.TextColor3 = self.Theme.TabSubTtitleTextColor
		subtext.TextSize = 14.000
		subtext.TextXAlignment = Enum.TextXAlignment.Left

		ImageLabel.Parent = Button
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BackgroundTransparency = 1.000
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Position = UDim2.new(0.841222107, 0, 0.244000241, 0)
		ImageLabel.Size = UDim2.new(0, 25, 0, 23)
		ImageLabel.Image = "rbxassetid://140083176080437"
		ImageLabel.ImageColor3 = self.Theme.DropDownArrowImg
		table.insert(tab.BtnImg, ImageLabel)

		table.insert(self.Elements, Button)
		self.pos += 50
		tab:CalcScroll()

		self.SearchData[Button] = config.Name .. " " .. (config.Description or "")

		local ButtonObj = {
			Elem = Button
		}

		return ButtonObj
	end

	function tab:AddToggle(config)
		local toggle = {
			Name = config.Name,
			Description = config.Description or '',
			Default = config.Default or false,
			Callback = config.Callback
		}

		local Toggle = Instance.new("TextButton")
		table.insert(tab.ElemBtn, Toggle)
		local UICorner = Instance.new("UICorner")
		local name = Instance.new("TextLabel")
		table.insert(tab.Texttitle, name)
		local subtext = Instance.new("TextLabel")
		table.insert(tab.Textsubtitle, subtext)
		local sliderbutton = Instance.new("Frame")
		table.insert(tab.actionBakcColor, sliderbutton)
		local UICorner_2 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local Frame2 = Instance.new("Frame")
		table.insert(tab.Togglebtn, Frame)
		local UICorner2 = Instance.new("UICorner")

		Toggle.Name = "Toggle"
		Toggle.Parent = self.Container
		Toggle.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		Toggle.BackgroundTransparency = self.Theme.BackGroundElemTran
		Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.BorderSizePixel = 0
		Toggle.Position = UDim2.new(0, 7, 0, self.pos)
		Toggle.Size = UDim2.new(0, 360, 0, 45)
		Toggle.Text = ''

		UICorner.Parent = Toggle
		UICorner.CornerRadius = UDim.new(0, 12)

		local namepos = config.Description and config.Description ~= '' and 4 or 12.5

		name.Parent = Toggle
		name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		name.BackgroundTransparency = 1.000
		name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		name.BorderSizePixel = 0
		name.Position = UDim2.new(0.0290000141, 0, 0, namepos)
		name.Size = UDim2.new(0, 77, 0, 20)
		name.Font = Enum.Font.FredokaOne
		name.Text = toggle.Name
		name.TextColor3 = self.Theme.TabTextColor
		name.TextSize = 15.000
		name.TextXAlignment = Enum.TextXAlignment.Left

		subtext.Parent = Toggle
		subtext.BackgroundColor3 = Color3.fromRGB(199, 199, 199)
		subtext.BackgroundTransparency = 1.000
		subtext.BorderColor3 = Color3.fromRGB(0, 0, 0)
		subtext.BorderSizePixel = 0
		subtext.Position = UDim2.new(0.0289855078, 0, 0, 25)
		subtext.Size = UDim2.new(0, 193, 0, 14)
		subtext.Font = Enum.Font.FredokaOne
		subtext.Text = toggle.Description
		subtext.TextColor3 = self.Theme.TabSubTtitleTextColor
		subtext.TextSize = 14.000
		subtext.TextXAlignment = Enum.TextXAlignment.Left

		sliderbutton.Parent = Toggle
		sliderbutton.BackgroundColor3 = self.Theme.ToggleButton
		sliderbutton.BackgroundTransparency = self.Theme.ToggleTran
		sliderbutton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		sliderbutton.BorderSizePixel = 0
		sliderbutton.Position = UDim2.new(0.801999986, 0, 0.206, 0)
		sliderbutton.Size = UDim2.new(0, 54, 0, 25)

		UICorner_2.Parent = sliderbutton

		Frame.Parent = sliderbutton
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0, 3, 0.119999997, 0)
		Frame.Size = UDim2.new(0, 19, 0, 19)

		Frame2.Parent = sliderbutton
		Frame2.BackgroundColor3 = self.Theme.TogleActivColor
		table.insert(tab.ActiveToggleColor, Frame2)
		Frame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame2.BorderSizePixel = 0
		Frame2.Position = UDim2.new(0, 3, 0.119999997, 0)
		Frame2.Size = UDim2.new(0, 0, 0, 19)
		Frame2.ZIndex = -1

		UICorner2.Parent = Frame2
		UICorner_3.Parent = Frame

		local toggleController = {
			Elem = Toggle,
			Value = toggle.Default,
			UpdateVisuals = function(self, state)
				if state then
					Library:Tween(Frame, {Position = UDim2.new(0, 32, 0.12, 0)}, 0.2)
					Library:Tween(Frame2, {Size = UDim2.new(0, 47, 0, 19), BackgroundTransparency = 0}, 0.2)
				else
					Library:Tween(Frame, {Position = UDim2.new(0, 3, 0.12, 0)}, 0.2)
					Library:Tween(Frame2, {Size = UDim2.new(0, 0, 0, 19), BackgroundTransparency = 1}, 0.2)
				end
			end,
			SetState = function(self, state)
				if state == self.Value then return end
				self.Value = state
				self:UpdateVisuals(state)
				if toggle.Callback then
					task.spawn(function()
						toggle.Callback(state)
					end)
				end
			end,
			GetState = function(self)
				return self.Value
			end,
			Toggle = function(self)
				self:SetState(not self.Value)
			end
		}

		toggleController:UpdateVisuals(toggleController.Value)

		Toggle.MouseButton1Click:Connect(function()
			toggleController:Toggle()
		end)

		table.insert(self.Elements, Toggle)
		self.pos += 50
		tab:CalcScroll()

		self.AllElements.Toggles[config.Name] = toggleController

		self.SearchData[Toggle] = config.Name .. " " .. (config.Description or "")

		return toggleController
	end

	function tab:AddKeybind(config)
		local Keybind = {
			Name = config.Name,
			Description = config.Description,
			key = config.Default,
			Callback = config.Callback
		}

		local container = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local name = Instance.new("TextLabel")
		local subtext = Instance.new("TextLabel")
		local bindButton = Instance.new("TextButton")
		local UICorner_2 = Instance.new("UICorner")

		tab.ElemBtn[#tab.ElemBtn + 1] = container
		tab.Texttitle[#tab.Texttitle + 1] = name
		tab.Texttitle[#tab.Texttitle + 1] = bindButton
		tab.Textsubtitle[#tab.Textsubtitle + 1] = subtext
		tab.actionBakcColor[#tab.actionBakcColor + 1] = bindButton

		container.Name = "keybind"
		container.Parent = self.Container
		container.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		container.BackgroundTransparency = self.Theme.BackGroundElemTran
		container.BorderColor3 = Color3.fromRGB(0, 0, 0)
		container.BorderSizePixel = 0
		container.Position = UDim2.new(0, 7, 0, self.pos)
		container.Size = UDim2.new(0, 360, 0, 45)
		container.Text = ''

		UICorner.CornerRadius = UDim.new(0, 12)
		UICorner.Parent = container

		local namepos = (config.Description and config.Description ~= '') and 4 or 12.5

		name.Parent = container
		name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		name.BackgroundTransparency = 1.000
		name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		name.BorderSizePixel = 0
		name.Position = UDim2.new(0.029, 0, 0, namepos)
		name.Size = UDim2.new(0, 77, 0, 20)
		name.Font = Enum.Font.FredokaOne
		name.Text = Keybind.Name
		name.TextColor3 = self.Theme.TabTextColor
		name.TextSize = 16.000
		name.TextXAlignment = Enum.TextXAlignment.Left

		subtext.Parent = container
		subtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		subtext.BackgroundTransparency = 1.000
		subtext.BorderColor3 = Color3.fromRGB(0, 0, 0)
		subtext.BorderSizePixel = 0
		subtext.Position = UDim2.new(0.0289, 0, 0, 25)
		subtext.Size = UDim2.new(0, 193, 0, 14)
		subtext.Font = Enum.Font.FredokaOne
		subtext.Text = Keybind.Description or ""
		subtext.TextColor3 = self.Theme.TabSubTtitleTextColor
		subtext.TextSize = 14.000
		subtext.TextXAlignment = Enum.TextXAlignment.Left

		bindButton.Parent = container
		bindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		bindButton.BackgroundTransparency = self.Theme.BackGroundButtonTran
		bindButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		bindButton.BorderSizePixel = 0
		bindButton.Position = UDim2.new(0.672, 0, 0.221, 0)
		bindButton.Size = UDim2.new(0, 100, 0, 25)
		bindButton.Font = Enum.Font.FredokaOne
		bindButton.TextColor3 = self.Theme.TabTextColor
		bindButton.TextSize = 14.000

		UICorner_2.CornerRadius = UDim.new(0, 5)
		UICorner_2.Parent = bindButton

		local currentKey = Keybind.key

		if typeof(currentKey) == "EnumItem" then
			bindButton.Text = currentKey.Name
		else
			bindButton.Text = "None"
		end

		local function setKey(newKey)
			currentKey = newKey
			bindButton.Text = (typeof(newKey) == "EnumItem" and newKey.Name) or "None"
		end

		local selectConnection = bindButton.MouseButton1Click:Connect(function()
			bindButton.Text = "..."
			local connection

			connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
				task.wait()
				if gameProcessed then return end

				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					setKey(nil)
					connection:Disconnect()
				elseif input.UserInputType == Enum.UserInputType.Keyboard then
					setKey(input.KeyCode)
					connection:Disconnect()
				end
			end)
		end)
		tab.Connections[#tab.Connections + 1] = selectConnection

		local actionConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if not gameProcessed and currentKey and input.KeyCode == currentKey and config.Callback then
				config.Callback()
			end
		end)
		tab.KeybindConnections[#tab.KeybindConnections + 1] = actionConnection

		self.Elements[#self.Elements + 1] = container
		self.pos += 50
		tab:CalcScroll()

		local keybindObj = {
			Name = config.Name,
			Elem = container,
			Key = currentKey,
			SetKey = setKey,
			GetState = function()
				return bindButton.Text
			end,
			Callback = config.Callback
		}

		self.AllElements.Keybinds[config.Name] = keybindObj
		self.SearchData[container] = config.Name .. " " .. (config.Description or "")

		return keybindObj
	end

	function tab:AddInput(config)
		local Input = {
			Name = config.Name,
			Description = config.Description,
			SaveUserText = config.SaveUserText or false,
			SaveConfig = config.SaveConfig or false,
			Default = config.Default or "Default",
			Callback = config.Callback
		}

		local input = Instance.new("TextButton")
		table.insert(tab.ElemBtn, input)
		local UICorner = Instance.new("UICorner")
		local name = Instance.new("TextLabel")
		table.insert(tab.Texttitle, name)
		local subtext = Instance.new("TextLabel")
		table.insert(tab.Textsubtitle, subtext)
		local TextBox = Instance.new("TextBox")
		table.insert(tab.actionBakcColor, TextBox)
		local UICorner_2 = Instance.new("UICorner")

		input.Name = "input"
		input.Parent = self.Container
		input.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		input.BackgroundTransparency = self.Theme.BackGroundElemTran
		input.BorderColor3 = Color3.fromRGB(0, 0, 0)
		input.BorderSizePixel = 0
		input.Position = UDim2.new(0, 7, 0, self.pos)
		input.Size = UDim2.new(0, 360, 0, 45)
		input.Text = ''

		UICorner.Parent = input
		UICorner.CornerRadius = UDim.new(0, 12)

		local namepos = 4

		if config.Description == '' then
			namepos = 12.5
		end

		name.Parent = input
		name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		name.BackgroundTransparency = 1.000
		name.BorderColor3 = Color3.fromRGB(0, 0, 0)
		name.BorderSizePixel = 0
		name.Position = UDim2.new(0.0290000141, 0, 0, namepos)
		name.Size = UDim2.new(0, 77, 0, 20)
		name.Font = Enum.Font.FredokaOne
		name.Text = Input.Name
		name.TextColor3 = self.Theme.TabTextColor
		name.TextSize = 16.000
		name.TextXAlignment = Enum.TextXAlignment.Left

		subtext.Parent = input
		subtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		subtext.BackgroundTransparency = 1.000
		subtext.BorderColor3 = Color3.fromRGB(0, 0, 0)
		subtext.BorderSizePixel = 0
		subtext.Position = UDim2.new(0.0289855078, 0, 0, 25)
		subtext.Size = UDim2.new(0, 193, 0, 14)
		subtext.Font = Enum.Font.FredokaOne
		subtext.Text = Input.Description
		subtext.TextColor3 = self.Theme.TabSubTtitleTextColor
		subtext.TextSize = 14.000
		subtext.TextXAlignment = Enum.TextXAlignment.Left

		TextBox.Parent = input
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = self.Theme.BackGroundButtonTran
		TextBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0.574999988, 0, 0.155555561, 0)
		TextBox.Size = UDim2.new(0, 135, 0, 30)
		TextBox.Font = Enum.Font.FredokaOne
		TextBox.Text = Input.Default
		TextBox.TextColor3 = self.Theme.InputTextColor
		TextBox.TextSize = 14.000
		table.insert(tab.InputTextColor, TextBox)

		UICorner_2.CornerRadius = UDim.new(0, 5)
		UICorner_2.Parent = TextBox

		TextBox.FocusLost:Connect(function(enterPressed)
			if enterPressed and config.Callback then
				config.Callback(TextBox.Text)
			end
		end)

		TextBox.FocusLost:Connect(function()
			wait(0.01)
			if not Input.SaveUserText then
				TextBox.Text = Input.Default
			end
		end)

		local function SetInput(Text2)
			TextBox.Text = Text2
			config.Callback(TextBox.Text)
		end
		table.insert(self.Elements, input)
		self.pos += 50
		tab:CalcScroll()

		local InputObj = {
			Name = config.Name,
			Elem = input,
			SetText = SetInput,
			GetState = function(self)
				return TextBox.Text
			end,
			SaveConfig = Input.SaveConfig,
			Callback = config.Callback
		}
		self.AllElements.Inputs[config.Name] = InputObj

		self.SearchData[input] = config.Name .. " " .. (config.Description or "")

		return InputObj
	end

	local UserInputService = game:GetService("UserInputService")

	function tab:AddSlider(config)
		local Slider = {
			Name = config.Name,
			Description = config.Description or '',
			min = config.Min or 0,
			max = config.Max or 100,
			Callback = config.Callback,
		}
		local value = config.Default or Slider.min

		local slider = Instance.new("TextButton")
		table.insert(tab.ElemBtn, slider)

		local UICorner = Instance.new("UICorner")
		local name = Instance.new("TextLabel")
		table.insert(tab.Texttitle, name)

		local subtext = Instance.new("TextLabel")
		table.insert(tab.Textsubtitle, subtext)

		local sliderbutton = Instance.new("Frame")
		local sliderline = Instance.new("Frame")
		local sliderball = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local slideramount = Instance.new("TextLabel")
		local underline = Instance.new("Frame")

		table.insert(tab.SliderUnderLineColor, underline)
		table.insert(tab.Sliderball, sliderball)

		slider.Name = "slider"
		slider.Parent = self.Container
		slider.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		slider.BackgroundTransparency = self.Theme.BackGroundElemTran
		slider.BorderSizePixel = 0
		slider.Position = UDim2.new(0, 7, 0, self.pos)
		slider.Size = UDim2.new(0, 360, 0, 45)
		slider.Text = ''

		UICorner.Parent = slider
		UICorner.CornerRadius = UDim.new(0, 12)

		local namepos = (Slider.Description == '') and 12.5 or 4

		name.Parent = slider
		name.BackgroundTransparency = 1.000
		name.Position = UDim2.new(0.029, 0, 0, namepos)
		name.Size = UDim2.new(0, 77, 0, 20)
		name.Font = Enum.Font.FredokaOne
		name.Text = Slider.Name
		name.TextColor3 = self.Theme.TabTextColor
		name.TextSize = 16.000
		name.TextXAlignment = Enum.TextXAlignment.Left

		subtext.Parent = slider
		subtext.BackgroundTransparency = 1.000
		subtext.Position = UDim2.new(0.029, 0, 0, 25)
		subtext.Size = UDim2.new(0, 193, 0, 14)
		subtext.Font = Enum.Font.FredokaOne
		subtext.Text = Slider.Description
		subtext.TextColor3 = self.Theme.TabSubTtitleTextColor
		subtext.TextSize = 14.000
		subtext.TextXAlignment = Enum.TextXAlignment.Left

		sliderbutton.Parent = slider
		sliderbutton.BackgroundTransparency = 1.000
		sliderbutton.Position = UDim2.new(0.671, 0, 0.244, 0)
		sliderbutton.Size = UDim2.new(0, 100, 0, 22)

		sliderline.Parent = sliderbutton
		sliderline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		sliderline.BorderSizePixel = 0
		sliderline.Position = UDim2.new(0, 0, 0.32, 0)
		sliderline.Size = UDim2.new(0, 100, 0, 2)

		underline.Parent = sliderbutton
		underline.BackgroundColor3 = self.Theme.SliderUnderLineColor
		underline.BorderSizePixel = 0
		underline.Position = UDim2.new(0, 0, 0.32, 0)
		underline.Size = UDim2.new(0, 0, 0, 2)

		sliderball.Parent = sliderbutton
		sliderball.BackgroundColor3 = self.Theme.Sliderball
		sliderball.BorderSizePixel = 0
		sliderball.Position = UDim2.new(0, 0, 0, 0)
		sliderball.Size = UDim2.new(0, 15, 0, 15)

		UICorner_2.Parent = sliderball
		UICorner_2.CornerRadius = UDim.new(0, 100)

		slideramount.Parent = slider
		slideramount.BackgroundTransparency = 1.000
		slideramount.Position = UDim2.new(0.816, 0, 0.106, 0)
		slideramount.Size = UDim2.new(0, 50, 0, 20)
		slideramount.Font = Enum.Font.FredokaOne
		slideramount.TextColor3 = self.Theme.TabSubTtitleTextColor
		slideramount.TextSize = 15.000
		slideramount.TextXAlignment = Enum.TextXAlignment.Left

		local SliderObj = {
			Elem = slider,
			Value = value,
			Min = Slider.min,
			Max = Slider.max,
			Update = function(self, newValue)
				local clamped = math.clamp(newValue, self.Min, self.Max)
				self.Value = clamped
				local fraction = (clamped - self.Min) / (self.Max - self.Min)
				slideramount.Text = tostring(math.round(clamped))
				underline.Size = UDim2.new(fraction, 0, 0, 2)
				sliderball.Position = UDim2.new(fraction - 0.015, 0, -0.11, 0)
			end,
			SetValue = function(self, newValue)
				local oldValue = self.Value
				self:Update(newValue)
				if oldValue ~= self.Value and Slider.Callback then
					Slider.Callback(self.Value)
				end
			end,
			GetValue = function(self)
				return self.Value
			end
		}

		SliderObj:Update(value)

		local dragging = false
		local connection
		local mouse

		sliderball.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				mouse = game:GetService("Players").LocalPlayer:GetMouse()
			end
		end)

		sliderball.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)

		game:GetService("RunService").RenderStepped:Connect(function()
			if dragging and mouse then
				local frame = sliderbutton
				local relativeX = mouse.X - frame.AbsolutePosition.X
				local fraction = math.clamp(relativeX / frame.AbsoluteSize.X, 0, 1)
				local newValue = fraction * (Slider.max - Slider.min) + Slider.min
				SliderObj:SetValue(newValue)
			end
		end)

		table.insert(self.Elements, slider)
		self.pos += 50
		tab:CalcScroll()

		self.AllElements.Sliders[config.Name] = SliderObj
		self.SearchData[slider] = config.Name .. " " .. (config.Description or "")

		return SliderObj
	end

	function tab:AddDropdown(config)
		local DropdownData = {
			Name = config.Name,
			Description = config.Description or '',
			Options = config.Options or {},
			Default = config.Default or '',
			Callback = config.Callback
		}

		local dropdown = Instance.new("TextButton")
		table.insert(tab.ElemBtn, dropdown)
		local UICorner = Instance.new("UICorner")
		local name = Instance.new("TextLabel")
		table.insert(tab.Texttitle, name)
		local subtext = Instance.new("TextLabel")
		table.insert(tab.Textsubtitle, subtext)
		local DropdownButton = Instance.new("TextButton")
		table.insert(tab.actionBakcColor, DropdownButton)
		local UICorner_2 = Instance.new("UICorner")
		local DropDownArrow = Instance.new("ImageLabel")
		table.insert(tab.DropDownArrowImg, DropDownArrow)
		local DropDownFrame = Instance.new("Frame")
		table.insert(tab.DropDownFrameColor, DropDownFrame)
		local UICorner_3 = Instance.new("UICorner")
		local ScrollingFrame = Instance.new("ScrollingFrame")

		dropdown.Name = "dropdown"
		dropdown.Parent = self.Container
		dropdown.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		dropdown.BackgroundTransparency = self.Theme.BackGroundElemTran
		dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		dropdown.BorderSizePixel = 0
		dropdown.Position = UDim2.new(0, 7, 0, self.pos)
		dropdown.Size = UDim2.new(0, 360, 0, 45)
		dropdown.Text = ''

		UICorner.Parent = dropdown
		UICorner.CornerRadius = UDim.new(0, 12)

		local namepos = (DropdownData.Description == '') and 12.5 or 4

		name.Parent = dropdown
		name.BackgroundTransparency = 1.000
		name.Position = UDim2.new(0.029, 0, 0, namepos)
		name.Size = UDim2.new(0, 77, 0, 20)
		name.Font = Enum.Font.FredokaOne
		name.Text = DropdownData.Name
		name.TextColor3 = self.Theme.TabTextColor
		name.TextSize = 16.000
		name.TextXAlignment = Enum.TextXAlignment.Left

		subtext.Parent = dropdown
		subtext.BackgroundTransparency = 1.000
		subtext.Position = UDim2.new(0.029, 0, 0, 25)
		subtext.Size = UDim2.new(0, 193, 0, 14)
		subtext.Font = Enum.Font.FredokaOne
		subtext.Text = DropdownData.Description
		subtext.TextColor3 = self.Theme.TabSubTtitleTextColor
		subtext.TextSize = 14.000
		subtext.TextXAlignment = Enum.TextXAlignment.Left

		DropdownButton.Parent = dropdown
		DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownButton.BackgroundTransparency = self.Theme.BackGroundButtonTran
		DropdownButton.BorderSizePixel = 0
		DropdownButton.Position = UDim2.new(0.649, 0, 0.174, 0)
		DropdownButton.Size = UDim2.new(0, 110, 0, 30)
		DropdownButton.Font = Enum.Font.FredokaOne
		DropdownButton.Text = DropdownData.Default
		DropdownButton.TextColor3 = self.Theme.TabTextColor
		DropdownButton.TextSize = 14.000

		UICorner_2.CornerRadius = UDim.new(0, 5)
		UICorner_2.Parent = DropdownButton

		DropDownArrow.Parent = dropdown
		DropDownArrow.BackgroundTransparency = 1.000
		DropDownArrow.Position = UDim2.new(0.9, 0, 0.2, 0)
		DropDownArrow.Size = UDim2.new(0, 24, 0, 24)
		DropDownArrow.Image = "rbxassetid://126982255108418"
		DropDownArrow.ImageColor3 = self.Theme.DropDownArrowImg

		DropDownFrame.Parent = dropdown
		DropDownFrame.BackgroundColor3 = self.Theme.DropDownColor
		DropDownFrame.BackgroundTransparency = self.Theme.DropDownTransparency
		DropDownFrame.BorderSizePixel = 0
		DropDownFrame.Position = UDim2.new(0, 0, 1.2, 0)
		DropDownFrame.Size = UDim2.new(0, 360, 0, 0)
		DropDownFrame.ClipsDescendants = true
		DropDownFrame.ZIndex = 2

		UICorner_3.CornerRadius = UDim.new(0, 12)
		UICorner_3.Parent = DropDownFrame

		ScrollingFrame.Parent = DropDownFrame
		ScrollingFrame.BackgroundTransparency = 1.000
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
		ScrollingFrame.Size = UDim2.new(0, 360, 0, 0)
		ScrollingFrame.ScrollBarThickness = 2
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

		local dropdownObj = {
			Elem = dropdown,
			Name = DropdownData.Name,
			Description = DropdownData.Description,
			Options = DropdownData.Options,
			Default = DropdownData.Default,
			Callback = DropdownData.Callback,
			DropdownButton = DropdownButton,
			DropDownFrame = DropDownFrame,
			ScrollingFrame = ScrollingFrame,
			Open = false,
			_tab = self
		}

		local function UpdateDropdownOptions()
			for _, child in pairs(ScrollingFrame:GetChildren()) do
				if child:IsA("TextButton") then
					child:Destroy()
				end
			end

			local yPos = 0
			for _, option in pairs(DropdownData.Options) do
				local optionButton = Instance.new("TextButton")
				optionButton.Parent = ScrollingFrame
				optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				optionButton.BackgroundTransparency = 0.95
				optionButton.BorderSizePixel = 0
				optionButton.Position = UDim2.new(0, 0, 0, yPos)
				optionButton.Size = UDim2.new(0, 360, 0, 30)
				optionButton.Font = Enum.Font.FredokaOne
				optionButton.Text = option
				optionButton.TextColor3 = self.Theme.TabTextColor
				optionButton.TextSize = 14.000
				optionButton.ZIndex = 3

				optionButton.MouseButton1Click:Connect(function()
					DropdownButton.Text = option
					dropdownObj.Value = option
					if DropdownData.Callback then
						DropdownData.Callback(option)
					end
					dropdownObj:ToggleDropdown(false)
				end)

				yPos += 35
			end

			ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, yPos)
			ScrollingFrame.Size = UDim2.new(0, 360, 0, math.min(yPos, 150))
		end

		function dropdownObj:ToggleDropdown(open)
			if open == nil then
				open = not self.Open
			end

			if open then
				self.Open = true
				DropDownFrame.Size = UDim2.new(0, 360, 0, 150)
				Library:Tween(DropDownArrow, {Rotation = 0}, 0.3)
			else
				self.Open = false
				DropDownFrame.Size = UDim2.new(0, 360, 0, 0)
				Library:Tween(DropDownArrow, {Rotation = -90}, 0.3)
			end
		end

		function dropdownObj:SetOptions(newOptions)
			DropdownData.Options = newOptions
			UpdateDropdownOptions()
			if #newOptions > 0 then
				DropdownButton.Text = newOptions[1]
				dropdownObj.Value = newOptions[1]
			else
				DropdownButton.Text = "None"
				dropdownObj.Value = nil
			end
			if DropdownData.Callback and dropdownObj.Value then
				DropdownData.Callback(dropdownObj.Value)
			end
		end

		function dropdownObj:SetValue(value)
			for _, option in pairs(DropdownData.Options) do
				if option == value then
					DropdownButton.Text = value
					dropdownObj.Value = value
					if DropdownData.Callback then
						DropdownData.Callback(value)
					end
					return
				end
			end
		end

		function dropdownObj:GetValue()
			return dropdownObj.Value
		end

		UpdateDropdownOptions()

		DropdownButton.MouseButton1Click:Connect(function()
			dropdownObj:ToggleDropdown()
		end)

		table.insert(self.Elements, dropdown)
		self.pos += 50
		tab:CalcScroll()

		self.AllElements.Dropdowns[config.Name] = dropdownObj
		self.SearchData[dropdown] = config.Name .. " " .. (config.Description or "")

		dropdownObj:SetValue(DropdownData.Default)

		return dropdownObj
	end

	function tab:AddColorPicker(config)
		local ColorPicker = {
			Name = config.Name,
			Description = config.Description or '',
			Default = config.Default or Color3.fromRGB(255, 255, 255),
			Callback = config.Callback
		}

		local picker = Instance.new("TextButton")
		table.insert(tab.ElemBtn, picker)
		local UICorner = Instance.new("UICorner")
		local name = Instance.new("TextLabel")
		table.insert(tab.Texttitle, name)
		local subtext = Instance.new("TextLabel")
		table.insert(tab.Textsubtitle, subtext)
		local ColorDisplay = Instance.new("Frame")
		table.insert(tab.actionBakcColor, ColorDisplay)
		local UICorner_2 = Instance.new("UICorner")
		local ColorPickerFrame = Instance.new("Frame")
		table.insert(tab.ColorPickerColor, ColorPickerFrame)
		local UICorner_3 = Instance.new("UICorner")
		local HueSlider = Instance.new("Frame")
		local HueGradient = Instance.new("UIGradient")
		local SatSlider = Instance.new("Frame")
		local SatGradient = Instance.new("UIGradient")
		local SatSliderKnob = Instance.new("Frame")
		local HueSliderKnob = Instance.new("Frame")
		local ColorPreview = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local HexBox = Instance.new("TextBox")
		local UICorner_5 = Instance.new("UICorner")

		picker.Name = "colorpicker"
		picker.Parent = self.Container
		picker.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
		picker.BackgroundTransparency = self.Theme.BackGroundElemTran
		picker.BorderSizePixel = 0
		picker.Position = UDim2.new(0, 7, 0, self.pos)
		picker.Size = UDim2.new(0, 360, 0, 45)
		picker.Text = ''

		UICorner.Parent = picker
		UICorner.CornerRadius = UDim.new(0, 12)

		local namepos = (ColorPicker.Description == '') and 12.5 or 4

		name.Parent = picker
		name.BackgroundTransparency = 1.000
		name.Position = UDim2.new(0.029, 0, 0, namepos)
		name.Size = UDim2.new(0, 77, 0, 20)
		name.Font = Enum.Font.FredokaOne
		name.Text = ColorPicker.Name
		name.TextColor3 = self.Theme.TabTextColor
		name.TextSize = 16.000
		name.TextXAlignment = Enum.TextXAlignment.Left

		subtext.Parent = picker
		subtext.BackgroundTransparency = 1.000
		subtext.Position = UDim2.new(0.029, 0, 0, 25)
		subtext.Size = UDim2.new(0, 193, 0, 14)
		subtext.Font = Enum.Font.FredokaOne
		subtext.Text = ColorPicker.Description
		subtext.TextColor3 = self.Theme.TabSubTtitleTextColor
		subtext.TextSize = 14.000
		subtext.TextXAlignment = Enum.TextXAlignment.Left

		ColorDisplay.Parent = picker
		ColorDisplay.BackgroundColor3 = ColorPicker.Default
		ColorDisplay.BorderSizePixel = 0
		ColorDisplay.Position = UDim2.new(0.87, 0, 0.2, 0)
		ColorDisplay.Size = UDim2.new(0, 25, 0, 25)

		UICorner_2.CornerRadius = UDim.new(0, 5)
		UICorner_2.Parent = ColorDisplay

		ColorPickerFrame.Parent = picker
		ColorPickerFrame.BackgroundColor3 = self.Theme.ColorPickerColoro
		ColorPickerFrame.BackgroundTransparency = 0.95
		ColorPickerFrame.BorderSizePixel = 0
		ColorPickerFrame.Position = UDim2.new(0, 0, 1.1, 0)
		ColorPickerFrame.Size = UDim2.new(0, 360, 0, 0)
		ColorPickerFrame.ClipsDescendants = true
		ColorPickerFrame.ZIndex = 2

		UICorner_3.CornerRadius = UDim.new(0, 12)
		UICorner_3.Parent = ColorPickerFrame

		HueSlider.Parent = ColorPickerFrame
		HueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		HueSlider.BorderSizePixel = 0
		HueSlider.Position = UDim2.new(0.05, 0, 0.15, 0)
		HueSlider.Size = UDim2.new(0, 320, 0, 15)

		HueGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
		})
		HueGradient.Parent = HueSlider

		HueSliderKnob.Parent = HueSlider
		HueSliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		HueSliderKnob.BorderSizePixel = 0
		HueSliderKnob.Position = UDim2.new(0, 0, -0.33, 0)
		HueSliderKnob.Size = UDim2.new(0, 15, 0, 25)

		SatSlider.Parent = ColorPickerFrame
		SatSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SatSlider.BorderSizePixel = 0
		SatSlider.Position = UDim2.new(0.05, 0, 0.4, 0)
		SatSlider.Size = UDim2.new(0, 320, 0, 15)

		SatGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
		})
		SatGradient.Parent = SatSlider

		SatSliderKnob.Parent = SatSlider
		SatSliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SatSliderKnob.BorderSizePixel = 0
		SatSliderKnob.Position = UDim2.new(0, 0, -0.33, 0)
		SatSliderKnob.Size = UDim2.new(0, 15, 0, 25)

		ColorPreview.Parent = ColorPickerFrame
		ColorPreview.BackgroundColor3 = ColorPicker.Default
		ColorPreview.BorderSizePixel = 0
		ColorPreview.Position = UDim2.new(0.05, 0, 0.65, 0)
		ColorPreview.Size = UDim2.new(0, 40, 0, 40)

		UICorner_4.CornerRadius = UDim.new(0, 5)
		UICorner_4.Parent = ColorPreview

		HexBox.Parent = ColorPickerFrame
		HexBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		HexBox.BackgroundTransparency = 0.9
		HexBox.BorderSizePixel = 0
		HexBox.Position = UDim2.new(0.2, 0, 0.65, 0)
		HexBox.Size = UDim2.new(0, 100, 0, 40)
		HexBox.Font = Enum.Font.FredokaOne
		HexBox.Text = "#FFFFFF"
		HexBox.TextColor3 = self.Theme.TabTextColor
		HexBox.TextSize = 16.000

		UICorner_5.CornerRadius = UDim.new(0, 5)
		UICorner_5.Parent = HexBox

		local colorObj = {
			Elem = picker,
			Open = false,
			Color = ColorPicker.Default,
			Hue = 0,
			Saturation = 1,
			Value = 1,
			Callback = ColorPicker.Callback,
			SetValue = function(self, newColor)
				self.Color = newColor
				ColorDisplay.BackgroundColor3 = newColor
				ColorPreview.BackgroundColor3 = newColor
				if self.Callback then
					self.Callback(newColor)
				end
			end,
			Toggle = function(self)
				self.Open = not self.Open
				if self.Open then
					ColorPickerFrame.Size = UDim2.new(0, 360, 0, 200)
				else
					ColorPickerFrame.Size = UDim2.new(0, 360, 0, 0)
				end
			end
		}

		local function updateFromColor(color)
			local r, g, b = color.R, color.G, color.B
			local max = math.max(r, g, b)
			local min = math.min(r, g, b)
			local delta = max - min

			if delta == 0 then
				colorObj.Hue = 0
			elseif max == r then
				colorObj.Hue = ((g - b) / delta) % 6
			elseif max == g then
				colorObj.Hue = ((b - r) / delta) + 2
			else
				colorObj.Hue = ((r - g) / delta) + 4
			end
			colorObj.Hue = colorObj.Hue / 6

			colorObj.Saturation = delta == 0 and 0 or delta / max
			colorObj.Value = max
		end

		updateFromColor(ColorPicker.Default)

		local function updateColorFromHSV()
			local h = colorObj.Hue * 6
			local s = colorObj.Saturation
			local v = colorObj.Value

			local c = v * s
			local x = c * (1 - math.abs((h % 2) - 1))
			local m = v - c

			local r, g, b
			if h < 1 then
				r, g, b = c, x, 0
			elseif h < 2 then
				r, g, b = x, c, 0
			elseif h < 3 then
				r, g, b = 0, c, x
			elseif h < 4 then
				r, g, b = 0, x, c
			elseif h < 5 then
				r, g, b = x, 0, c
			else
				r, g, b = c, 0, x
			end

			local color = Color3.new(r + m, g + m, b + m)
			colorObj:SetValue(color)
		end

		local function updateSliders()
			local hPos = colorObj.Hue * 320
			HueSliderKnob.Position = UDim2.new(0, hPos, -0.33, 0)

			local sPos = colorObj.Saturation * 320
			SatSliderKnob.Position = UDim2.new(0, sPos, -0.33, 0)

			local hueColor = Color3.fromHSV(colorObj.Hue, 1, 1)
			SatGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, hueColor)
			})
		end

		picker.MouseButton1Click:Connect(function()
			colorObj:Toggle()
		end)

		local function setupSlider(slider, knob, callback)
			local dragging = false
			local connection

			slider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					local pos = input.Position.X - slider.AbsolutePosition.X
					local value = math.clamp(pos / slider.AbsoluteSize.X, 0, 1)
					callback(value)
					updateSliders()
				end
			end)

			slider.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			game:GetService("RunService").RenderStepped:Connect(function()
				if dragging then
					local mouse = game:GetService("Players").LocalPlayer:GetMouse()
					local pos = mouse.X - slider.AbsolutePosition.X
					local value = math.clamp(pos / slider.AbsoluteSize.X, 0, 1)
					callback(value)
					updateSliders()
				end
			end)
		end

		setupSlider(HueSlider, HueSliderKnob, function(value)
			colorObj.Hue = value
			updateColorFromHSV()
		end)

		setupSlider(SatSlider, SatSliderKnob, function(value)
			colorObj.Saturation = value
			updateColorFromHSV()
		end)

		colorObj:SetValue(ColorPicker.Default)
		updateSliders()

		table.insert(self.Elements, picker)
		self.pos += 50
		tab:CalcScroll()

		self.AllElements.ColorPickers[config.Name] = colorObj
		self.SearchData[picker] = config.Name .. " " .. (config.Description or "")

		return colorObj
	end

	function Library:SelectTab(tab,button)
		if self.CurrentTab then
			local oldTab = self.CurrentTab
			if oldTab.Button then
				self:Tween(oldTab.Button,{BackgroundTransparency = 1},0.3)
				self:Tween(oldTab.Frame,{BackgroundTransparency = 1},0.3)
				self:Tween(oldTab.Frame,{Size = UDim2.new(0, 2, 0, 0)},0.3)
			end
			if oldTab.Container then
				oldTab.Container.Visible = false
			end
		end

		self.CurrentTab = tab

		if tab.Button then
			self:Tween(tab.Button,{BackgroundTransparency = self.Theme.TabTransparancy},0.3)
			self:Tween(tab.Frame,{BackgroundTransparency = 0},0.3)
			self:Tween(tab.Frame,{Size = UDim2.new(0, 2, 0, 23)},0.3)
		end

		if tab.Container then
			tab.Container.Visible = true
			self:UpdateTabTitle(tab.Name)
		end
	end

	function Library:UpdateTabTitle(title)
		self.TextLabel_5.Text = title
	end

	function Library:Tween(object,properties,duration)
		local tweenInfo = TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tween = TweenService:Create(object, tweenInfo, properties)
		tween:Play()
		return tween
	end

	function Library:Destroy()
		self.UI:Destroy()
	end

	function Library:ShowDestroyQ()
		if self.Windowscd == false then
			self.Windowscd = true
			self.dFrame_2.Transparency = 0
			self.dTextButton.Visible = true
			self.dTextButton_2.Visible = true
			self.dTextLabel.Visible = true
			self.dTextLabel_2.Visible = true
			self.dTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			self.dTextLabel_2.TextColor3 = Color3.fromRGB(184, 184, 184)
			self.Destroy_gui.Visible = true
			self:Tween(self.Destroy_gui,{BackgroundTransparency = 0.4},0.3)
			self:Tween(self.dFrame_2,{Transparency = 0},0.3)
		else
			self.Windowscd = false
			self.dFrame_2.Transparency = 1
			self.dTextButton.Visible = false
			self.dTextButton_2.Visible = false
			self.dTextLabel.Visible = false
			self.dTextLabel_2.Visible = false
			self.Destroy_gui.Visible = false
			self:Tween(self.Destroy_gui,{BackgroundTransparency = 1},0.3)
			self:Tween(self.dFrame_2,{Transparency = 1},0.3)
		end
	end

	function Library:Minimaze()
		self:Tween(self.ImageLabel,{Size = UDim2.new(0, 10, 0, 10)},0.5)
		for _, v in pairs(self.ImageLabel:GetChildren()) do
			if v ~= self.ImageLabel and v ~= self.UI then
				v.Visible = false
			end
		end
	end

	function Library:ColumnWindow()
		local currentSize = self.ImageLabel.Size
		if currentSize.X.Offset > 10 then
			self:Tween(self.ImageLabel,{Size = UDim2.new(0, 300, 0, 480)},0.5)
			for _, v in pairs(self.ImageLabel:GetChildren()) do
				if v:IsA("Frame") or v:IsA("ScrollingFrame") or v:IsA("ImageLabel") or v:IsA("ImageButton") or v:IsA("TextButton") or v:IsA("TextBox") then
					if v ~= self.ImageLabel and v ~= self.UI and v ~= self.IOSdragline and v ~= self.IOSdragHitbox and v ~= self.Destroy_gui then
						v.Visible = false
					end
				end
			end
		else
			self:Tween(self.ImageLabel,{Size = UDim2.new(0, 590, 0, 480)},0.5)
			for _, v in pairs(self.ImageLabel:GetChildren()) do
				if v:IsA("Frame") or v:IsA("ScrollingFrame") or v:IsA("ImageLabel") or v:IsA("ImageButton") or v:IsA("TextButton") or v:IsA("TextBox") then
					if v ~= self.ImageLabel and v ~= self.UI and v ~= self.IOSdragline and v ~= self.IOSdragHitbox and v ~= self.Destroy_gui then
						v.Visible = true
					end
				end
			end
		end
	end

	function Library:SearchAllTabs()
		local query = self.SearchTextBox.Text:lower()
		if query == "" or query == "search..." then
			for _, tab in pairs(self.mainTabs) do
				for _, element in pairs(tab.Elements) do
					element.Visible = true
				end
			end
			return
		end

		for _, tab in pairs(self.mainTabs) do
			for _, element in pairs(tab.Elements) do
				local searchData = tab.SearchData[element] or ""
				if searchData:lower():find(query) then
					element.Visible = true
				else
					element.Visible = false
				end
			end
		end
	end

	return Library