--// MG Modz - Roof TP Seguro (com Part)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Criando ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MGModzUI"
ScreenGui.Parent = PlayerGui

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Fade-in
TweenService:Create(MainFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()

-- Título
local Title = Instance.new("TextLabel")
Title.Text = "MG Modz"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Botão minimizar/maximizar
local MinButton = Instance.new("TextButton")
MinButton.Text = "-"
MinButton.Size = UDim2.new(0, 35, 0, 35)
MinButton.Position = UDim2.new(1, -40, 0, 0)
MinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinButton.TextScaled = true
MinButton.Font = Enum.Font.GothamBold
MinButton.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = MinButton

-- Container do conteúdo
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -10, 1, -45)
ContentFrame.Position = UDim2.new(0, 5, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Botão Roof TP
local RoofButton = Instance.new("TextButton")
RoofButton.Text = "Roof TP"
RoofButton.Size = UDim2.new(1, 0, 0, 40)
RoofButton.Position = UDim2.new(0, 0, 0, 10)
RoofButton.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
RoofButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RoofButton.TextScaled = true
RoofButton.Font = Enum.Font.GothamBold
RoofButton.Parent = ContentFrame

local RoofCorner = Instance.new("UICorner")
RoofCorner.CornerRadius = UDim.new(0, 10)
RoofCorner.Parent = RoofButton

-- Função Roof TP (com Part segura)
RoofButton.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local highestY = hrp.Position.Y

        -- Procura o objeto mais alto do mapa
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.CanCollide then
                if obj.Position.Y > highestY then
                    highestY = obj.Position.Y
                end
            end
        end

        -- Cria uma Part com colisão lá em cima
        local roofPart = workspace:FindFirstChild("MG_RoofPart")
        if not roofPart then
            roofPart = Instance.new("Part")
            roofPart.Name = "MG_RoofPart"
            roofPart.Size = Vector3.new(100, 5, 100) -- tamanho da plataforma
            roofPart.Anchored = true
            roofPart.CanCollide = true
            roofPart.Transparency = 0.3
            roofPart.Color = Color3.fromRGB(0, 150, 255)
            roofPart.Position = Vector3.new(hrp.Position.X, highestY + 10, hrp.Position.Z)
            roofPart.Parent = workspace
        else
            -- Atualiza posição caso já exista
            roofPart.Position = Vector3.new(hrp.Position.X, highestY + 10, hrp.Position.Z)
        end

        -- Teleporta o player em cima da Part
        hrp.CFrame = roofPart.CFrame + Vector3.new(0, 5, 0)
    end
end)

-- Minimizar/Maximizar
local minimized = false
MinButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        ContentFrame.Visible = false
        MinButton.Text = "+"
        MainFrame:TweenSize(UDim2.new(0,220,0,35), "Out", "Quad", 0.3, true)
    else
        ContentFrame.Visible = true
        MinButton.Text = "-"
        MainFrame:TweenSize(UDim2.new(0,220,0,140), "Out", "Quad", 0.3, true)
    end
end)
