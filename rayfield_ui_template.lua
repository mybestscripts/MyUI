-- Canvas Document: Full Rayfield-Style UI Library with Everything

local MyUI = {}

function MyUI:CreateWindow(options)
    local window = {}

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
    title.Size = UDim2.new(1, 0, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = options.Name or "My UI"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 26
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

        -- UI Elements functions
        function tab:CreateButton(opts)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, 200, 0, 45)
            btn.Position = UDim2.new(0, 20, 0, (#contentFrame:GetChildren()-1)*55)
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
            frame.Position = UDim2.new(0, 20, 0, (#contentFrame:GetChildren()-1)*55)
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
            btn.Position = UDim2.new(0, 20, 0, (#contentFrame:GetChildren()-1)*55)
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
            box.Position = UDim2.new(0, 20, 0, (#contentFrame:GetChildren()-1)*55)
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

        table.insert(tabs, tab)
        tab.Button = tabButton
        tab.Content = contentFrame
        return tab
    end

    return window
end

return MyUI
