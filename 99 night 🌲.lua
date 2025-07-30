--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]

--// Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

--// Player Variables
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

--// Embedded Library (Late's UI Library)
local Library = {}

--// Connections
local GetService = game.GetService
local Connect = game.Changed.Connect
local Wait = game.Loaded.Wait
local Clone = game.Clone
local Destroy = game.Destroy

if not game:IsLoaded() then
	local Loaded = game.Loaded
	Loaded.Wait(Loaded)
end

--// Important
local Setup = {
	Keybind = Enum.KeyCode.LeftControl,
	Transparency = 0.2,
	ThemeMode = "Dark",
	Size = nil,
}

local Theme = {
	--// Frames:
	Primary = Color3.fromRGB(30, 30, 30),
	Secondary = Color3.fromRGB(35, 35, 35),
	Component = Color3.fromRGB(40, 40, 40),
	Interactables = Color3.fromRGB(45, 45, 45),
	--// Text:
	Tab = Color3.fromRGB(200, 200, 200),
	Title = Color3.fromRGB(240, 240, 240),
	Description = Color3.fromRGB(200, 200, 200),
	--// Outlines:
	Shadow = Color3.fromRGB(0, 0, 0),
	Outline = Color3.fromRGB(40, 40, 40),
	--// Image:
	Icon = Color3.fromRGB(220, 220, 220),
}

--// Services & Functions
local Type, Blur = nil
local LocalPlayer = GetService(game, "Players").LocalPlayer
local Services = {
	Insert = GetService(game, "InsertService"),
	Tween = GetService(game, "TweenService"),
	Run = GetService(game, "RunService"),
	Input = GetService(game, "UserInputService"),
}

local Player = {
	Mouse = LocalPlayer:GetMouse(),
	GUI = LocalPlayer.PlayerGui,
}

local Tween = function(Object, Speed, Properties, Info)
	local Style, Direction
	if Info then
		Style, Direction = Info.EasingStyle or Enum.EasingStyle.Sine, Info.EasingDirection or Enum.EasingDirection.Out
	else
		Style, Direction = Enum.EasingStyle.Sine, Enum.EasingDirection.Out
	end
	return Services.Tween:Create(Object, TweenInfo.new(Speed, Style, Direction), Properties):Play()
end

local SetProperty = function(Object, Properties)
	for Index, Property in next, Properties do
		Object[Index] = Property
	end
	return Object
end

local Multiply = function(Value, Amount)
	local New = {
		Value.X.Scale * Amount,
		Value.X.Offset * Amount,
		Value.Y.Scale * Amount,
		Value.Y.Offset * Amount,
	}
	return UDim2.new(unpack(New))
end

local Color = function(Color, Factor, Mode)
	Mode = Mode or Setup.ThemeMode
	if Mode == "Light" then
		return Color3.fromRGB((Color.R * 255) - Factor, (Color.G * 255) - Factor, (Color.B * 255) - Factor)
	else
		return Color3.fromRGB((Color.R * 255) + Factor, (Color.G * 255) + Factor, (Color.B * 255) + Factor)
	end
end

local Drag = function(Canvas)
	if Canvas then
		local Dragging, DragInput, Start, StartPosition
		local function Update(input)
			local delta = input.Position - Start
			Canvas.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y)
		end
		Connect(Canvas.InputBegan, function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and not Type then
				Dragging = true
				Start = Input.Position
				StartPosition = Canvas.Position
				Connect(Input.Changed, function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		Connect(Canvas.InputChanged, function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and not Type then
				DragInput = Input
			end
		end)
		Connect(Services.Input.InputChanged, function(Input)
			if Input == DragInput and Dragging and not Type then
				Update(Input)
			end
		end)
	end
end

local Resizing = {
	TopLeft = { X = Vector2.new(-1, 0), Y = Vector2.new(0, -1) },
	TopRight = { X = Vector2.new(1, 0), Y = Vector2.new(0, -1) },
	BottomLeft = { X = Vector2.new(-1, 0), Y = Vector2.new(0, 1) },
	BottomRight = { X = Vector2.new(1, 0), Y = Vector2.new(0, 1) },
}

local Resizeable = function(Tab, Minimum, Maximum)
	task.spawn(function()
		local MousePos, Size, UIPos = nil, nil, nil
		if Tab and Tab:FindFirstChild("Resize") then
			local Positions = Tab:FindFirstChild("Resize")
			for Index, Types in next, Positions:GetChildren() do
				Connect(Types.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Type = Types
						MousePos = Vector2.new(Player.Mouse.X, Player.Mouse.Y)
						Size = Tab.AbsoluteSize
						UIPos = Tab.Position
					end
				end)
				Connect(Types.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Type = nil
					end
				end)
			end
			local Resize = function(Delta)
				if Type and MousePos and Size and UIPos and Tab:FindFirstChild("Resize")[Type.Name] == Type then
					local Mode = Resizing[Type.Name]
					local NewSize = Vector2.new(Size.X + Delta.X * Mode.X.X, Size.Y + Delta.Y * Mode.Y.Y)
					NewSize = Vector2.new(math.clamp(NewSize.X, Minimum.X, Maximum.X), math.clamp(NewSize.Y, Minimum.Y, Maximum.Y))
					local AnchorOffset = Vector2.new(Tab.AnchorPoint.X * Size.X, Tab.AnchorPoint.Y * Size.Y)
					local NewAnchorOffset = Vector2.new(Tab.AnchorPoint.X * NewSize.X, Tab.AnchorPoint.Y * NewSize.Y)
					local DeltaAnchorOffset = NewAnchorOffset - AnchorOffset
					Tab.Size = UDim2.new(0, NewSize.X, 0, NewSize.Y)
					local NewPosition = UDim2.new(
						UIPos.X.Scale,
						UIPos.X.Offset + DeltaAnchorOffset.X * Mode.X.X,
						UIPos.Y.Scale,
						UIPos.Y.Offset + DeltaAnchorOffset.Y * Mode.Y.Y
					)
					Tab.Position = NewPosition
				end
			end
			Connect(Player.Mouse.Move, function()
				if Type then
					Resize(Vector2.new(Player.Mouse.X, Player.Mouse.Y) - MousePos)
				end
			end)
		end
	end)
end

--// Setup [UI]
local Screen = Instance.new("ScreenGui")
Screen.Name = "UI_Library"
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = Screen
MainFrame.Visible = false

xpcall(function()
	Screen.Parent = game.CoreGui
end, function()
	Screen.Parent = PlayerGui
end)

local Animations = {}
local Blurs = {}
local Components = Instance.new("Folder")
Components.Name = "Components"
Components.Parent = Screen
local NotificationTemplate = Instance.new("CanvasGroup")
NotificationTemplate.Name = "Notification"
NotificationTemplate.Parent = Components
local Labels = Instance.new("Folder")
Labels.Name = "Labels"
Labels.Parent = NotificationTemplate
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Parent = Labels
local DescriptionLabel = Instance.new("TextLabel")
DescriptionLabel.Name = "Description"
DescriptionLabel.Parent = Labels
local Timer = Instance.new("Frame")
Timer.Name = "Timer"
Timer.Parent = NotificationTemplate

local StoredInfo = {
	["Sections"] = {},
	["Tabs"] = {}
}

--// Animations [Window]
function Animations:Open(Window, Transparency, UseCurrentSize)
	local Original = (UseCurrentSize and Window.Size) or Setup.Size
	local Multiplied = Multiply(Original, 1.1)
	local Shadow = Window:FindFirstChildOfClass("UIStroke")
	if Shadow then
		SetProperty(Shadow, { Transparency = 1 })
	end
	SetProperty(Window, {
		Size = Multiplied,
		GroupTransparency = 1,
		Visible = true,
	})
	if Shadow then
		Tween(Shadow, 0.25, { Transparency = 0.5 })
	end
	Tween(Window, 0.25, {
		Size = Original,
		GroupTransparency = Transparency or 0,
	})
end

function Animations:Close(Window)
	local Original = Window.Size
	local Multiplied = Multiply(Original, 1.1)
	local Shadow = Window:FindFirstChildOfClass("UIStroke")
	if Shadow then
		SetProperty(Shadow, { Transparency = 1 })
	end
	SetProperty(Window, {
		Size = Original,
	})
	if Shadow then
		Tween(Shadow, 0.25, { Transparency = 1 })
	end
	Tween(Window, 0.25, {
		Size = Multiplied,
		GroupTransparency = 1,
	})
	task.wait(0.25)
	Window.Size = Original
	Window.Visible = false
end

function Animations:Component(Component, Custom)
	Connect(Component.InputBegan, function()
		if Custom then
			Tween(Component, 0.25, { Transparency = 0.85 })
		else
			Tween(Component, 0.25, { BackgroundColor3 = Color(Theme.Component, 5, Setup.ThemeMode) })
		end
	end)
	Connect(Component.InputEnded, function()
		if Custom then
			Tween(Component, 0.25, { Transparency = 1 })
		else
			Tween(Component, 0.25, { BackgroundColor3 = Theme.Component })
		end
	end)
end

--// Library [Window]
function Library:CreateWindow(Settings)
	local Window = Clone(MainFrame)
	local Sidebar = Window:FindFirstChild("Sidebar")
	local Holder = Window:FindFirstChild("Main")
	local BG = Window:FindFirstChild("BackgroundShadow")
	local Tab = Sidebar:FindFirstChild("Tab")

	local Options = {}
	local Examples = {}
	local Opened = true
	local Maximized = false
	local BlurEnabled = false

	for _, Example in next, Window:GetDescendants() do
		if Example.Name:find("Example") and not Examples[Example.Name] then
			Examples[Example.Name] = Example
		end
	end

	Drag(Window)
	Resizeable(Window, Vector2.new(411, 271), Vector2.new(9e9, 9e9))
	Setup.Transparency = Settings.Transparency or 0
	Setup.Size = Settings.Size
	Setup.ThemeMode = Settings.Theme or "Dark"

	if Settings.Blurring then
		Blurs[Settings.Title] = { root = Instance.new("BlurEffect", Workspace.CurrentCamera) }
		Blurs[Settings.Title].root.Size = 5
		BlurEnabled = true
	end

	if Settings.MinimizeKeybind then
		Setup.Keybind = Settings.MinimizeKeybind
	end

	local Close = function()
		if Opened then
			if BlurEnabled and Blurs[Settings.Title] then
				Blurs[Settings.Title].root.Parent = nil
			end
			Opened = false
			Animations:Close(Window)
			Window.Visible = false
		else
			Animations:Open(Window, Setup.Transparency)
			Opened = true
			if BlurEnabled and Blurs[Settings.Title] then
				Blurs[Settings.Title].root.Parent = Workspace.CurrentCamera
			end
		end
	end

	for _, Button in next, Sidebar:FindFirstChild("Top"):FindFirstChild("Buttons"):GetChildren() do
		if Button:IsA("TextButton") then
			local Name = Button.Name
			Animations:Component(Button, true)
			Connect(Button.MouseButton1Click, function()
				if Name == "Close" then
					Close()
				elseif Name == "Maximize" then
					if Maximized then
						Maximized = false
						Tween(Window, 0.15, { Size = Setup.Size })
					else
						Maximized = true
						Tween(Window, 0.15, { Size = UDim2.fromScale(1, 1), Position = UDim2.fromScale(0.5, 0.5) })
					end
				elseif Name == "Minimize" then
					Opened = false
					Window.Visible = false
					if BlurEnabled and Blurs[Settings.Title] then
						Blurs[Settings.Title].root.Parent = nil
					end
				end
			end)
		end
	end

	Services.Input.InputBegan:Connect(function(Input, Focused)
		if (Input.KeyCode == Setup.Keybind or Input == Setup.Keybind) and not Focused then
			Close()
		end
	end)

	function Options:SetTab(Name)
		for _, Button in next, Tab:GetChildren() do
			if Button:IsA("TextButton") then
				local Opened, SameName = Button:FindFirstChild("Value"), (Button.Name == Name)
				local Padding = Button:FindFirstChildOfClass("UIPadding")
				if SameName and not Opened.Value then
					Tween(Padding, 0.25, { PaddingLeft = UDim.new(0, 25) })
					Tween(Button, 0.25, { BackgroundTransparency = 0.9, Size = UDim2.new(1, -15, 0, 30) })
					Opened.Value = true
				elseif not SameName and Opened.Value then
					Tween(Padding, 0.25, { PaddingLeft = UDim.new(0, 20) })
					Tween(Button, 0.25, { BackgroundTransparency = 1, Size = UDim2.new(1, -44, 0, 30) })
					Opened.Value = false
				end
			end
		end
		for _, Main in next, Holder:GetChildren() do
			if Main:IsA("CanvasGroup") then
				local Opened, SameName = Main:FindFirstChild("Value"), (Main.Name == Name)
				local Scroll = Main:FindFirstChild("ScrollingFrame")
				if SameName and not Opened.Value then
					Opened.Value = true
					Main.Visible = true
					Tween(Main, 0.3, { GroupTransparency = 0 })
					Tween(Scroll:FindFirstChild("UIPadding"), 0.3, { PaddingTop = UDim.new(0, 5) })
				elseif not SameName and Opened.Value then
					Opened.Value = false
					Tween(Main, 0.15, { GroupTransparency = 1 })
					Tween(Scroll:FindFirstChild("UIPadding"), 0.15, { PaddingTop = UDim.new(0, 15) })
					task.delay(0.2, function()
						Main.Visible = false
					end)
				end
			end
		end
	end

	function Options:AddTabSection(Settings)
		local Example = Examples["SectionExample"]
		local Section = Clone(Example)
		StoredInfo["Sections"][Settings.Name] = Settings.Order
		SetProperty(Section, {
			Parent = Example.Parent,
			Text = Settings.Name,
			Name = Settings.Name,
			LayoutOrder = Settings.Order,
			Visible = true
		})
	end

	function Options:AddTab(Settings)
		if StoredInfo["Tabs"][Settings.Title] then
			error("[UI LIB]: A tab with the same name has already been created")
		end
		local Example, MainExample = Examples["TabButtonExample"], Examples["MainExample"]
		local Section = StoredInfo["Sections"][Settings.Section]
		local Main = Clone(MainExample)
		local Tab = Clone(Example)
		if not Settings.Icon then
			if Tab:FindFirstChild("ICO") then
				Tab:FindFirstChild("ICO"):Destroy()
			end
		else
			SetProperty(Tab:FindFirstChild("ICO"), { Image = Settings.Icon })
		end
		StoredInfo["Tabs"][Settings.Title] = { Tab }
		SetProperty(Tab:FindFirstChild("TextLabel"), { Text = Settings.Title })
		SetProperty(Main, {
			Parent = MainExample.Parent,
			Name = Settings.Title,
		})
		SetProperty(Tab, {
			Parent = Example.Parent,
			LayoutOrder = Section or #StoredInfo["Sections"] + 1,
			Name = Settings.Title,
			Visible = true,
		})
		Connect(Tab.MouseButton1Click, function()
			Options:SetTab(Tab.Name)
		end)
		return Main:FindFirstChild("ScrollingFrame")
	end

	function Options:Notify(Settings)
		local Notification = Clone(NotificationTemplate)
		local Title, Description = Notification:FindFirstChild("Labels").Title, Notification:FindFirstChild("Labels").Description
		local Timer = Notification:FindFirstChild("Timer")
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Notification, {
			Parent = Screen:FindFirstChild("Frame") or Screen,
		})
		task.spawn(function()
			local Duration = Settings.Duration or 2
			Animations:Open(Notification, Setup.Transparency, true)
			Tween(Timer, Duration, { Size = UDim2.new(0, 0, 0, 4) })
			task.wait(Duration)
			Animations:Close(Notification)
			task.wait(1)
			Notification:Destroy()
		end)
	end

	function Options:GetLabels(Component)
		local Labels = Component:FindFirstChild("Labels")
		return Labels.Title, Labels.Description
	end

	function Options:AddSection(Settings)
		local Section = Clone(Components:FindFirstChild("Section") or Instance.new("TextLabel"))
		Section.Name = "Section"
		SetProperty(Section, {
			Text = Settings.Name,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddButton(Settings)
		local Button = Clone(Components:FindFirstChild("Button") or Instance.new("TextButton"))
		Button.Name = "Button"
		local Title, Description = Options:GetLabels(Button)
		Connect(Button.MouseButton1Click, Settings.Callback)
		Animations:Component(Button)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Button, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddInput(Settings)
		local Input = Clone(Components:FindFirstChild("Input") or Instance.new("TextButton"))
		Input.Name = "Input"
		local Title, Description = Options:GetLabels(Input)
		local TextBox = Input:FindFirstChild("Main"):FindFirstChild("Input")
		Connect(Input.MouseButton1Click, function()
			TextBox:CaptureFocus()
		end)
		Connect(TextBox.FocusLost, function()
			Settings.Callback(TextBox.Text)
		end)
		Animations:Component(Input)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Input, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddToggle(Settings)
		local Toggle = Clone(Components:FindFirstChild("Toggle") or Instance.new("TextButton"))
		Toggle.Name = "Toggle"
		local Title, Description = Options:GetLabels(Toggle)
		local On = Toggle:FindFirstChild("Value")
		local Main = Toggle:FindFirstChild("Main")
		local Circle = Main:FindFirstChild("Circle")
		local Set = function(Value)
			if Value then
				Tween(Main, 0.2, { BackgroundColor3 = Color3.fromRGB(153, 155, 255) })
				Tween(Circle, 0.2, { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, -16, 0.5, 0) })
			else
				Tween(Main, 0.2, { BackgroundColor3 = Theme.Interactables })
				Tween(Circle, 0.2, { BackgroundColor3 = Theme.Primary, Position = UDim2.new(0, 3, 0.5, 0) })
			end
			On.Value = Value
		end
		Connect(Toggle.MouseButton1Click, function()
			local Value = not On.Value
			Set(Value)
			Settings.Callback(Value)
		end)
		Animations:Component(Toggle)
		Set(Settings.Default)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Toggle, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddKeybind(Settings)
		local Dropdown = Clone(Components:FindFirstChild("Keybind") or Instance.new("TextButton"))
		Dropdown.Name = "Keybind"
		local Title, Description = Options:GetLabels(Dropdown)
		local Bind = Dropdown:FindFirstChild("Main"):FindFirstChild("Options")
		Connect(Dropdown.MouseButton1Click, function()
			local Time = tick()
			local Detect, Finished
			SetProperty(Bind, { Text = "..." })
			Detect = Connect(game.UserInputService.InputBegan, function(Key, Focused)
				if not Finished and not Focused then
					Finished = true
					if table.find({Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3}, Key.UserInputType) then
						Settings.Callback(Key)
						SetProperty(Bind, { Text = tostring(Key.UserInputType):gsub("Enum.UserInputType.MouseButton", "MB") })
					elseif Key.UserInputType == Enum.UserInputType.Keyboard then
						Settings.Callback(Key)
						SetProperty(Bind, { Text = tostring(Key.KeyCode):gsub("Enum.KeyCode.", "") })
					end
				end
			end)
		end)
		Animations:Component(Dropdown)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Dropdown, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddDropdown(Settings)
		local Dropdown = Clone(Components:FindFirstChild("Dropdown") or Instance.new("TextButton"))
		Dropdown.Name = "Dropdown"
		local Title, Description = Options:GetLabels(Dropdown)
		local Text = Dropdown:FindFirstChild("Main"):FindFirstChild("Options")
		Connect(Dropdown.MouseButton1Click, function()
			local Example = Clone(Examples["DropdownExample"])
			local Buttons = Example:FindFirstChild("Top"):FindFirstChild("Buttons")
			Tween(BG, 0.25, { BackgroundTransparency = 0.6 })
			SetProperty(Example, { Parent = Window })
			Animations:Open(Example, 0, true)
			for _, Button in next, Buttons:GetChildren() do
				if Button:IsA("TextButton") then
					Animations:Component(Button, true)
					Connect(Button.MouseButton1Click, function()
						Tween(BG, 0.25, { BackgroundTransparency = 1 })
						Animations:Close(Example)
						task.wait(0.2)
						Destroy(Example)
					end)
				end
			end
			for Index, Option in next, Settings.Options do
				local Button = Clone(Examples["DropdownButtonExample"])
				local Title, Description = Options:GetLabels(Button)
				local Selected = Button:FindFirstChild("Value")
				Animations:Component(Button)
				SetProperty(Title, { Text = Index })
				SetProperty(Button, { Parent = Example:FindFirstChild("ScrollingFrame"), Visible = true })
				Destroy(Description)
				Connect(Button.MouseButton1Click, function()
					local NewValue = not Selected.Value
					if NewValue then
						Tween(Button, 0.25, { BackgroundColor3 = Theme.Interactables })
						Settings.Callback(Option)
						Text.Text = Index
						for _, Others in next, Example:GetChildren() do
							if Others:IsA("TextButton") and Others ~= Button then
								Others.BackgroundColor3 = Theme.Component
							end
						end
					else
						Tween(Button, 0.25, { BackgroundColor3 = Theme.Component })
					end
					Selected.Value = NewValue
					Tween(BG, 0.25, { BackgroundTransparency = 1 })
					Animations:Close(Example)
					task.wait(0.2)
					Destroy(Example)
				end)
			end
		end)
		Animations:Component(Dropdown)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Dropdown, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddSlider(Settings)
		local Slider = Clone(Components:FindFirstChild("Slider") or Instance.new("TextButton"))
		Slider.Name = "Slider"
		local Title, Description = Options:GetLabels(Slider)
		local Main = Slider:FindFirstChild("Slider")
		local Amount = Main:FindFirstChild("Main"):FindFirstChild("Input")
		local Slide = Main:FindFirstChild("Slide")
		local Fire = Slide:FindFirstChild("Fire")
		local Fill = Slide:FindFirstChild("Highlight")
		local Circle = Fill:FindFirstChild("Circle")
		local Active = false
		local Value = 0
		local SetNumber = function(Number)
			if Settings.AllowDecimals then
				local Power = 10 ^ (Settings.DecimalAmount or 2)
				Number = math.floor(Number * Power + 0.5) / Power
			else
				Number = math.round(Number)
			end
			return Number
		end
		local Update = function(Number)
			local Scale = (Player.Mouse.X - Slide.AbsolutePosition.X) / Slide.AbsoluteSize.X
			Scale = math.clamp(Scale, 0, 1)
			if Number then
				Number = math.clamp(Number, 0, Settings.MaxValue)
			end
			Value = SetNumber(Number or (Scale * Settings.MaxValue))
			Amount.Text = tostring(Value)
			Fill.Size = UDim2.fromScale((Number and Number / Settings.MaxValue) or Scale, 1)
			Settings.Callback(Value)
		end
		local Activate = function()
			Active = true
			repeat task.wait() Update() until not Active
		end
		Connect(Amount.FocusLost, function()
			Update(tonumber(Amount.Text) or 0)
		end)
		Connect(Fire.MouseButton1Down, Activate)
		Connect(Services.Input.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Active = false
			end
		end)
		Fill.Size = UDim2.fromScale(0, 1)
		Animations:Component(Slider)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Slider, {
			Name = Settings.Title,
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	function Options:AddParagraph(Settings)
		local Paragraph = Clone(Components:FindFirstChild("Paragraph") or Instance.new("TextLabel"))
		Paragraph.Name = "Paragraph"
		local Title, Description = Options:GetLabels(Paragraph)
		SetProperty(Title, { Text = Settings.Title })
		SetProperty(Description, { Text = Settings.Description })
		SetProperty(Paragraph, {
			Parent = Settings.Tab,
			Visible = true,
		})
	end

	local Themes = {
		Names = {
			["Paragraph"] = function(Label) if Label:IsA("TextButton") then Label.BackgroundColor3 = Color(Theme.Component, 5, "Dark") end end,
			["Title"] = function(Label) if Label:IsA("TextLabel") then Label.TextColor3 = Theme.Title end end,
			["Description"] = function(Label) if Label:IsA("TextLabel") then Label.TextColor3 = Theme.Description end end,
			["Section"] = function(Label) if Label:IsA("TextLabel") then Label.TextColor3 = Theme.Title end end,
			["Options"] = function(Label) if Label:IsA("TextLabel") and Label.Parent.Name == "Main" then Label.TextColor3 = Theme.Title end end,
			["Notification"] = function(Label) if Label:IsA("CanvasGroup") then Label.BackgroundColor3 = Theme.Primary; Label.UIStroke.Color = Theme.Outline end end,
			["TextLabel"] = function(Label) if Label:IsA("TextLabel") and Label.Parent:FindFirstChild("List") then Label.TextColor3 = Theme.Tab end end,
			["Main"] = function(Label) if Label:IsA("Frame") then if Label.Parent == Window then Label.BackgroundColor3 = Theme.Secondary elseif Label.Parent:FindFirstChild("Value") then local Toggle = Label.Parent.Value; local Circle = Label:FindFirstChild("Circle"); if not Toggle.Value then Label.BackgroundColor3 = Theme.Interactables; Circle.BackgroundColor3 = Theme.Primary end else Label.BackgroundColor3 = Theme.Interactables end elseif Label:FindFirstChild("Padding") then Label.TextColor3 = Theme.Title end end,
			["Amount"] = function(Label) if Label:IsA("Frame") then Label.BackgroundColor3 = Theme.Interactables end end,
			["Slide"] = function(Label) if Label:IsA("Frame") then Label.BackgroundColor3 = Theme.Interactables end end,
			["Input"] = function(Label) if Label:IsA("TextLabel") then Label.TextColor3 = Theme.Title elseif Label:FindFirstChild("Labels") then Label.BackgroundColor3 = Theme.Component elseif Label:IsA("TextBox") and Label.Parent.Name == "Main" then Label.TextColor3 = Theme.Title end end,
			["Outline"] = function(Stroke) if Stroke:IsA("UIStroke") then Stroke.Color = Theme.Outline end end,
			["DropdownExample"] = function(Label) Label.BackgroundColor3 = Theme.Secondary end,
			["Underline"] = function(Label) if Label:IsA("Frame") then Label.BackgroundColor3 = Theme.Outline end end,
		},
		Classes = {
			["ImageLabel"] = function(Label) if Label.Image ~= "rbxassetid://6644618143" then Label.ImageColor3 = Theme.Icon end end,
			["TextLabel"] = function(Label) if Label:FindFirstChild("Padding") then Label.TextColor3 = Theme.Title end end,
			["TextButton"] = function(Label) if Label:FindFirstChild("Labels") then Label.BackgroundColor3 = Theme.Component end end,
			["ScrollingFrame"] = function(Label) Label.ScrollBarImageColor3 = Theme.Component end,
		},
	}

	function Options:SetTheme(Info)
		Theme = Info or Theme
		Window.BackgroundColor3 = Theme.Primary
		Holder.BackgroundColor3 = Theme.Secondary
		if Window:FindFirstChild("UIStroke") then
			Window.UIStroke.Color = Theme.Shadow
		end
		for _, Descendant in next, Screen:GetDescendants() do
			local Name = Themes.Names[Descendant.Name]
			local Class = Themes.Classes[Descendant.ClassName]
			if Name then Name(Descendant) elseif Class then Class(Descendant) end
		end
	end

	function Options:SetSetting(Setting, Value)
		if Setting == "Size" then
			Window.Size = Value
			Setup.Size = Value
		elseif Setting == "Transparency" then
			Window.GroupTransparency = Value
			Setup.Transparency = Value
			for _, Notification in next, Screen:GetDescendants() do
				if Notification:IsA("CanvasGroup") and Notification.Name == "Notification" then
					Notification.GroupTransparency = Value
				end
			end
		elseif Setting == "Blur" then
			local AlreadyBlurred, Root = Blurs[Settings.Title], nil
			if AlreadyBlurred then Root = Blurs[Settings.Title].root end
			if Value and not (AlreadyBlurred and Root and Root.Parent) then
				BlurEnabled = true
				Blurs[Settings.Title] = { root = Instance.new("BlurEffect", Workspace.CurrentCamera) }
				Blurs[Settings.Title].root.Size = 5
			elseif not Value and AlreadyBlurred and Root and Root.Parent then
				Root.Parent = nil
				BlurEnabled = false
			end
		elseif Setting == "Theme" and typeof(Value) == "table" then
			Options:SetTheme(Value)
		elseif Setting == "Keybind" then
			Setup.Keybind = Value
		else
			warn("Tried to change a setting that doesn't exist or isn't available.")
		end
	end

	SetProperty(Window, { Size = Settings.Size, Visible = true, Parent = Screen })
	Animations:Open(Window, Settings.Transparency or 0)

	return Options
end

--// Key System
local correctKey = "al50"
local keyGui = nil

local function createKeyGui()
	keyGui = Instance.new("ScreenGui")
	local keyFrame = Instance.new("Frame")
	local keyTitle = Instance.new("TextLabel")
	local keyInput = Instance.new("TextBox")
	local keyMessage = Instance.new("TextLabel")

	keyGui.Parent = PlayerGui
	keyFrame.Size = UDim2.new(0, 220, 0, 110)
	keyFrame.Position = UDim2.new(0.5, -110, 0.5, -55)
	keyFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 30)
	keyFrame.BorderSizePixel = 0
	keyFrame.Active = true
	keyFrame.Draggable = true
	keyFrame.Parent = keyGui

	keyTitle.Size = UDim2.new(1, 0, 0, 25)
	keyTitle.BackgroundColor3 = Color3.fromRGB(40, 20, 45)
	keyTitle.Text = "Access Code"
	keyTitle.TextColor3 = Color3.fromRGB(200, 180, 220)
	keyTitle.TextSize = 16
	keyTitle.Font = Enum.Font.GothamBold
	keyTitle.Parent = keyFrame

	keyInput.Size = UDim2.new(0.75, 0, 0.3, 0)
	keyInput.Position = UDim2.new(0.125, 0, 0.35, 0)
	keyInput.BackgroundColor3 = Color3.fromRGB(35, 20, 40)
	keyInput.TextColor3 = Color3.fromRGB(220, 200, 240)
	keyInput.PlaceholderText = "Enter code here"
	keyInput.Parent = keyFrame

	keyMessage.Size = UDim2.new(1, 0, 0, 20)
	keyMessage.Position = UDim2.new(0, 0, 0.7, 0)
	keyMessage.BackgroundTransparency = 1
	keyMessage.TextColor3 = Color3.fromRGB(180, 160, 200)
	keyMessage.TextSize = 12
	keyMessage.Parent = keyFrame

	keyInput.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local key = keyInput.Text
			if key == correctKey then
				keyMessage.Text = "Access Granted!"
				keyGui:Destroy()
				createMainWindow()
			else
				keyMessage.Text = "Error: Incorrect Code! Try again."
				task.wait(2)
				keyMessage.Text = "Enter the code to proceed..."
			end
			keyInput.Text = ""
		end
	end)

	keyMessage.Text = "Enter the code to proceed..."
end

--// Main Window
local Window = nil
local Themes = {
	Light = {
		Primary = Color3.fromRGB(232, 232, 232),
		Secondary = Color3.fromRGB(255, 255, 255),
		Component = Color3.fromRGB(245, 245, 245),
		Interactables = Color3.fromRGB(235, 235, 235),
		Tab = Color3.fromRGB(50, 50, 50),
		Title = Color3.fromRGB(0, 0, 0),
		Description = Color3.fromRGB(100, 100, 100),
		Shadow = Color3.fromRGB(255, 255, 255),
		Outline = Color3.fromRGB(210, 210, 210),
		Icon = Color3.fromRGB(100, 100, 100),
	},
	Dark = {
		Primary = Color3.fromRGB(30, 30, 30),
		Secondary = Color3.fromRGB(35, 35, 35),
		Component = Color3.fromRGB(40, 40, 40),
		Interactables = Color3.fromRGB(45, 45, 45),
		Tab = Color3.fromRGB(200, 200, 200),
		Title = Color3.fromRGB(240, 240, 240),
		Description = Color3.fromRGB(200, 200, 200),
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(40, 40, 40),
		Icon = Color3.fromRGB(220, 220, 220),
	},
	Void = {
		Primary = Color3.fromRGB(15, 15, 15),
		Secondary = Color3.fromRGB(20, 20, 20),
		Component = Color3.fromRGB(25, 25, 25),
		Interactables = Color3.fromRGB(30, 30, 30),
		Tab = Color3.fromRGB(200, 200, 200),
		Title = Color3.fromRGB(240, 240, 240),
		Description = Color3.fromRGB(200, 200, 200),
		Shadow = Color3.fromRGB(0, 0, 0),
		Outline = Color3.fromRGB(40, 40, 40),
		Icon = Color3.fromRGB(220, 220, 220),
	},
}

local function createMainWindow()
	Window = Library:CreateWindow({
		Title = "99 Nights Script",
		Theme = "Dark",
		Size = UDim2.fromOffset(570, 370),
		Transparency = 0.2,
		Blurring = true,
		MinimizeKeybind = Enum.KeyCode.LeftAlt,
	})

	Window:SetTheme(Themes.Dark)

	Window:AddTabSection({ Name = "Main", Order = 1 })
	Window:AddTabSection({ Name = "Settings", Order = 2 })

	local Main = Window:AddTab({ Title = "Components", Section = "Main", Icon = "rbxassetid://11963373994" })

	Window:AddSection({ Name = "Non Interactable", Tab = Main })
	Window:AddParagraph({ Title = "Paragraph", Description = "Welcome to 99 Nights Script! Enable features below.", Tab = Main })
	Window:AddSection({ Name = "Interactable", Tab = Main })

	local ESPEnabled = false
	local KillAuraEnabled = false
	local SpeedEnabled = false
	local AutoFarmEnabled = false

	Window:AddToggle({
		Title = "ESP",
		Description = "Highlights animals and enemies",
		Tab = Main,
		Callback = function(Boolean)
			ESPEnabled = Boolean
			if ESPEnabled then
				local function updateESP()
					for _, obj in pairs(Workspace:GetChildren()) do
						if obj:IsA("Model") and obj.PrimaryPart and (obj.Name:lower():find("animal") or obj.Name:lower():find("bear") or obj.Name:lower():find("wolf")) then
							if not obj.PrimaryPart:FindFirstChild("ESP") then
								local billboard = Instance.new("BillboardGui")
								billboard.Name = "ESP"
								billboard.Size = UDim2.new(0, 80, 0, 40)
								billboard.StudsOffset = Vector3.new(0, 3, 0)
								billboard.Parent = obj.PrimaryPart
								local label = Instance.new("TextLabel")
								label.Size = UDim2.new(1, 0, 1, 0)
								label.BackgroundTransparency = 1
								label.Text = obj.Name
								label.TextColor3 = Color3.fromRGB(255, 0, 0)
								label.TextSize = 14
								label.Parent = billboard
							end
						end
					end
				end
				RunService.RenderStepped:Connect(updateESP)
			else
				for _, obj in pairs(Workspace:GetDescendants()) do
					if obj.Name == "ESP" then
						obj:Destroy()
					end
				end
			end
		end,
	})

	Window:AddToggle({
		Title = "Kill Aura",
		Description = "Automatically attacks nearby enemies",
		Tab = Main,
		Callback = function(Boolean)
			KillAuraEnabled = Boolean
			if KillAuraEnabled then
				local function killAura()
					if Character and RootPart then
						for _, obj in pairs(Workspace:GetChildren()) do
							if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
								local name = obj.Name:lower()
								if name:find("animal") or name:find("bear") or name:find("wolf") then
									local distance = (RootPart.Position - obj.HumanoidRootPart.Position).Magnitude
									if distance <= 20 then
										obj.Humanoid.Health = 0
									end
								end
							end
						end
					end
				end
				RunService.RenderStepped:Connect(killAura)
			end
		end,
	})

	Window:AddToggle({
		Title = "Speed Hack",
		Description = "Increases movement speed",
		Tab = Main,
		Callback = function(Boolean)
			SpeedEnabled = Boolean
			if Character and Humanoid then
				Humanoid.WalkSpeed = SpeedEnabled and 50 or 16
			end
		end,
	})

	Window:AddToggle({
		Title = "Auto Farm",
		Description = "Automatically collects resources like wood and berries",
		Tab = Main,
		Callback = function(Boolean)
			AutoFarmEnabled = Boolean
			if AutoFarmEnabled then
				local function autoFarm()
					if Character and RootPart then
						for _, obj in pairs(Workspace:GetDescendants()) do
							if obj:IsA("Part") then
								local name = obj.Name:lower()
								if name:find("wood") or name:find("stone") or name:find("berry") then
									obj.CFrame = RootPart.CFrame + Vector3.new(math.random(-3, 3), 2, math.random(-3, 3))
								end
							end
						end
					end
				end
				RunService.RenderStepped:Connect(autoFarm)
			end
		end,
	})

	Window:AddButton({
		Title = "Button",
		Description = "I wonder what this does",
		Tab = Main,
		Callback = function()
			Window:Notify({ Title = "hi", Description = "i'm a notification", Duration = 5 })
		end,
	})

	Window:AddSlider({
		Title = "Slider",
		Description = "Sliding",
		Tab = Main,
		MaxValue = 100,
		Callback = function(Amount)
			warn(Amount)
		end,
	})

	Window:AddToggle({
		Title = "Toggle",
		Description = "Switching",
		Tab = Main,
		Callback = function(Boolean)
			warn(Boolean)
		end,
	})

	Window:AddInput({
		Title = "Input",
		Description = "Typing",
		Tab = Main,
		Callback = function(Text)
			warn(Text)
		end,
	})

	Window:AddDropdown({
		Title = "Dropdown",
		Description = "Selecting",
		Tab = Main,
		Options = { ["An Option"] = "hi", ["And another"] = "hi", ["Another"] = "hi" },
		Callback = function(Number)
			warn(Number)
		end,
	})

	Window:AddKeybind({
		Title = "Keybind",
		Description = "Binding",
		Tab = Main,
		Callback = function(Key)
			warn("Key Set")
		end,
	})

	local Settings = Window:AddTab({ Title = "Settings", Section = "Settings", Icon = "rbxassetid://11293977610" })

	Window:AddKeybind({
		Title = "Minimize Keybind",
		Description = "Set the keybind for Minimizing",
		Tab = Settings,
		Callback = function(Key)
			Window:SetSetting("Keybind", Key)
		end,
	})

	Window:AddDropdown({
		Title = "Set Theme",
		Description = "Set the theme of the library!",
		Tab = Settings,
		Options = { ["Light Mode"] = "Light", ["Dark Mode"] = "Dark", ["Extra Dark"] = "Void" },
		Callback = function(Theme)
			Window:SetTheme(Themes[Theme])
		end,
	})

	Window:AddToggle({
		Title = "UI Blur",
		Description = "If enabled, must have your Roblox graphics set to 8+ for it to work",
		Default = true,
		Tab = Settings,
		Callback = function(Boolean)
			Window:SetSetting("Blur", Boolean)
		end,
	})

	Window:AddSlider({
		Title = "UI Transparency",
		Description = "Set the transparency of the UI",
		Tab = Settings,
		AllowDecimals = true,
		MaxValue = 1,
		Callback = function(Amount)
			Window:SetSetting("Transparency", Amount)
		end,
	})

	Window:Notify({ Title = "Hello World!", Description = "Press Left Alt to Minimize and Open the tab!", Duration = 10 })

	LocalPlayer.CharacterAdded:Connect(function(newChar)
		Character = newChar
		Humanoid = Character:WaitForChild("Humanoid")
		RootPart = Character:WaitForChild("HumanoidRootPart")
		if SpeedEnabled then
			Humanoid.WalkSpeed = 50
		end
	end)
end

--// Initialize
wait(2)
createKeyGui()
