-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModernUI"
screenGui.Parent = playerGui

-- Main Window Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Rounded corners for main window
local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 12)
uicorner.Parent = mainFrame

-- Header Bar
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Title Label
local title = Instance.new("TextLabel")
title.Text = "Modern UI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Minimize Button
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -40, 0, 5)
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 20
minimizeBtn.Parent = header

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimizeBtn

-- Content Area (with ScrollingFrame)
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -40)
scrollFrame.Position = UDim2.new(0, 0, 0, 40)
scrollFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
scrollFrame.ScrollBarThickness = 8
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 10)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = scrollFrame

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 10)
contentPadding.PaddingLeft = UDim.new(0, 10)
contentPadding.PaddingRight = UDim.new(0, 10)
contentPadding.Parent = scrollFrame

-- Function to update CanvasSize for scrolling
local function updateCanvas()
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
end
contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

-- Toggle Switch Example
local function createToggle(parent, text)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -20, 0, 30)
	frame.BackgroundTransparency = 1
	frame.Parent = parent

	local label = Instance.new("TextLabel")
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.SourceSans
	label.TextSize = 16
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(0, 150, 1, 0)
	label.Parent = frame

	local toggleFrame = Instance.new("TextButton")
	toggleFrame.Size = UDim2.new(0, 50, 0, 25)
	toggleFrame.Position = UDim2.new(0, 180, 0, 2)
	toggleFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	toggleFrame.AutoButtonColor = false
	toggleFrame.Parent = frame

	local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 12)
toggleCorner.Parent = toggleFrame

	local toggleKnob = Instance.new("Frame")
toggleKnob.Size = UDim2.new(0, 20, 0, 20)
toggleKnob.Position = UDim2.new(0, 2, 0, 2)
toggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleKnob.Parent = toggleFrame

	local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(0, 10)
knobCorner.Parent = toggleKnob

	local toggled = false

toggleFrame.MouseButton1Click:Connect(function()
	toggled = not toggled
	local goal = {}
	if toggled then
		goal.Position = UDim2.new(1, -22, 0, 2)
		toggleFrame.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	else
		goal.Position = UDim2.new(0, 2, 0, 2)
		toggleFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	end
	TweenService:Create(toggleKnob, TweenInfo.new(0.2), goal):Play()
end)

	return frame
end

-- Example toggle
createToggle(scrollFrame, "Enable Feature")

-- Regular Button Example
local function createButton(parent, text)
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 200)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.AutoButtonColor = false
	btn.Parent = parent

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 10)
	btnCorner.Parent = btn

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 90, 220)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 200)}):Play()
	end)
	btn.MouseButton1Click:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 180)}):Play()
		print(text .. " clicked!")
		wait(0.1)
		btn.BackgroundColor3 = Color3.fromRGB(70, 70, 200)
	end)

	return btn
end

createButton(scrollFrame, "Click Me")

-- Text Input Example
local function createTextInput(parent, placeholder)
	local tb = Instance.new("TextBox")
	tb.PlaceholderText = placeholder
	tb.Size = UDim2.new(1, -20, 0, 30)
	tb.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	tb.TextColor3 = Color3.fromRGB(255, 255, 255)
	tb.Font = Enum.Font.SourceSans
	tb.TextSize = 16
	tb.ClearTextOnFocus = false
	tb.Parent = parent

	local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 8)
tbCorner.Parent = tb

	tb.Focused:Connect(function()
		TweenService:Create(tb, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}):Play()
	end)
	tb.FocusLost:Connect(function()
		TweenService:Create(tb, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
	end)

	return tb
end

createTextInput(scrollFrame, "Enter text...")

-- Minimize Functionality
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	local goal = {Size = minimized and UDim2.new(1,0,0,40) or UDim2.new(1,0,1,-40)}
	TweenService:Create(mainFrame, TweenInfo.new(0.3), goal):Play()
	minimizeBtn.Text = minimized and "+" or "–"
end)

-- Resume feature
GuiService.MenuClosed:Connect(function()
	if minimized then
		minimized = false
		local goal = {Size = UDim2.new(1,0,1,-40)}
		TweenService:Create(mainFrame, TweenInfo.new(0.3), goal):Play()
		minimizeBtn.Text = "–"
	end
end)

-- Dragging Functionality
local dragging = false
local dragInput, mousePos, framePos

header.InputBegan:Connect(function(input)
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

header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
	end
end)
			end
		end)
	end
end)

header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - mousePos
		mainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
	end
end)
    

    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.Name or "MyUI_Window"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.CoreGui

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Active = true
    mainFrame.Draggable = true

    -- Rounded Corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    -- Top Bar
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = options.Name or "My UI"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 26
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Position = UDim2.new(0, 15, 0, 0)
    title.Parent = topBar

    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 40, 0, 40)
    closeBtn.Position = UDim2.new(1, -45, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.Parent = topBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0,6)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Minimize Button
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 40, 0, 40)
    minBtn.Position = UDim2.new(1, -90, 0, 5)
    minBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
    minBtn.Text = "-"
    minBtn.TextColor3 = Color3.fromRGB(255,255,255)
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 24
    minBtn.Parent = topBar

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0,6)
    minCorner.Parent = minBtn

    local isMinimized = false
    minBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        mainFrame.Size = isMinimized and UDim2.new(0, 500, 0, 50) or UDim2.new(0, 500, 0, 600)
    end)

    -- Tabs Container
    local tabsContainer = Instance.new("Frame")
    tabsContainer.Size = UDim2.new(1, 0, 0, 50)
    tabsContainer.Position = UDim2.new(0, 0, 0, 50)
    tabsContainer.BackgroundTransparency = 1
    tabsContainer.Parent = mainFrame

    local tabs = {}

    function window:CreateTab(tabName)
        local tab = {}
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0, 100, 1, 0)
        tabButton.Position = UDim2.new(#tabs*0.2, 0, 0, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(255,255,255)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 18
        tabButton.Parent = tabsContainer

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0,6)
        corner.Parent = tabButton

        local contentFrame = Instance.new("ScrollingFrame")
        contentFrame.Size = UDim2.new(1, -20, 1, -110)
        contentFrame.Position = UDim2.new(0, 10, 0, 110)
        contentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        contentFrame.BorderSizePixel = 0
        contentFrame.CanvasSize = UDim2.new(0,0,0,0)
        contentFrame.ScrollBarThickness = 6
        contentFrame.Visible = false
        contentFrame.Parent = mainFrame

        local contentCorner = Instance.new("UICorner")
        contentCorner.CornerRadius = UDim.new(0,10)
        contentCorner.Parent = contentFrame

        tabButton.MouseButton1Click:Connect(function()
            for _, t in ipairs(tabs) do
                t.Button.BackgroundColor3 = Color3.fromRGB(55,55,60)
                t.Content.Visible = false
            end
            tabButton.BackgroundColor3 = Color3.fromRGB(100,100,120)
            contentFrame.Visible = true
        end)

        -- Automatic content layout
        local layout = Instance.new("UIListLayout")
        layout.Parent = contentFrame
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0,10)

        -- UI Elements functions (Button, Toggle, ColorPicker, TextBox)
        function tab:CreateButton(opts)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 200, 0, 45)
            btn.BackgroundColor3 = Color3.fromRGB(75,75,85)
            btn.BorderSizePixel = 0
            btn.Text = opts.Name or "Button"
            btn.TextColor3 = Color3.fromRGB(255,255,255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 18
            btn.Parent = contentFrame

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = btn

            btn.MouseButton1Click:Connect(function()
                if opts.Callback then opts.Callback() end
            end)
        end

        function tab:CreateToggle(opts)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(0, 200, 0, 45)
            frame.BackgroundColor3 = Color3.fromRGB(75,75,85)
            frame.Parent = contentFrame

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = frame

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.7,0,1,0)
            label.BackgroundTransparency = 1
            label.Text = opts.Name or "Toggle"
            label.TextColor3 = Color3.fromRGB(255,255,255)
            label.Font = Enum.Font.Gotham
            label.TextSize = 18
            label.Parent = frame

            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(0.25,0,0.7,0)
            toggleBtn.Position = UDim2.new(0.75,0,0.15,0)
            toggleBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
            toggleBtn.Text = ""
            toggleBtn.Parent = frame

            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0,6)
            toggleCorner.Parent = toggleBtn

            local state = false
            toggleBtn.MouseButton1Click:Connect(function()
                state = not state
                toggleBtn.BackgroundColor3 = state and Color3.fromRGB(50,200,50) or Color3.fromRGB(100,100,100)
                if opts.Callback then opts.Callback(state) end
            end)
        end

        function tab:CreateColorPicker(opts)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 200, 0, 45)
            btn.BackgroundColor3 = opts.Default or Color3.fromRGB(255,255,255)
            btn.Text = opts.Name or "Color"
            btn.TextColor3 = Color3.fromRGB(0,0,0)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 18
            btn.Parent = contentFrame

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = btn

            btn.MouseButton1Click:Connect(function()
                if opts.Callback then opts.Callback(btn.BackgroundColor3) end
            end)
        end

        function tab:CreateTextbox(opts)
            local box = Instance.new("TextBox")
            box.Size = UDim2.new(0, 200, 0, 45)
            box.BackgroundColor3 = Color3.fromRGB(75,75,85)
            box.TextColor3 = Color3.fromRGB(255,255,255)
            box.PlaceholderText = opts.Placeholder or "Enter Text"
            box.Font = Enum.Font.Gotham
            box.TextSize = 18
            box.Parent = contentFrame

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0,6)
            corner.Parent = box

            box.FocusLost:Connect(function(enter)
                if enter and opts.Callback then opts.Callback(box.Text) end
            end)
        end

        tab.Button = tabButton
        tab.Content = contentFrame
        table.insert(tabs, tab)
        return tab
    end

    return window
end

return MyUI
