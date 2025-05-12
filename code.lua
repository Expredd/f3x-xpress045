local player = game.Players.LocalPlayer

local function createGUI()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.Name = "MyCustomGui"

	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui");
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	ScreenGui.ResetOnSpawn = false;

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 672, 0.1, 350)
	mainFrame.Position = UDim2.new(0, 0, 0, 0) 
	mainFrame.Active = true 
	mainFrame.Draggable = true
	mainFrame.Parent = ScreenGui
	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 0)), 
		ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))     
	})
	gradient.Rotation = 0 
	gradient.Parent = mainFrame

	local TweenService = game:GetService("TweenService")
	local UserInputService = game:GetService("UserInputService")

	local frame = mainFrame
	local dragging = false
	local dragInput, dragStart, startPos

	local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function update(input)
		local delta = input.Position - dragStart
		local newPos = UDim2.new(
			0,
			startPos.X.Offset + delta.X,
			0,
			startPos.Y.Offset + delta.Y
		)

		TweenService:Create(frame, tweenInfo, {Position = newPos}):Play()
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	frame.Active = true
	frame.Draggable = false

	local image = Instance.new("ImageLabel")
	image.Size = UDim2.new(0, 635, 0, 178)  
	image.Position = UDim2.new(0, 17, 0.8, -93) 
	image.BackgroundTransparency = 1 
	image.Image = "rbxassetid://89550792990783" 
	image.Parent = mainFrame

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, 0, 0, 40)
	titleLabel.Position = UDim2.new(0, 0, 0, 0)
	titleLabel.Text = "Xpress045 GUI by Xpress045"
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	titleLabel.TextSize = 20
	titleLabel.TextScaled = true
	titleLabel.TextWrapped = true
	titleLabel.Font = Enum.Font.SourceSansBold
	titleLabel.ZIndex = 2 
	titleLabel.Parent = mainFrame
	titleLabel.BorderSizePixel = 3
	titleLabel.BorderColor3 = Color3.fromRGB(255, 0, 0)

	local function createButton(text, row, col, callback)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(0, 150, 0, 50)
		button.Position = UDim2.new(0, 10 + (col - 1) * 160, 0, 55 + (row - 1) * 60)
		button.Text = text
		button.Parent = mainFrame
		button.BorderSizePixel = 2
		button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		button.BorderColor3 = Color3.fromRGB(255, 0, 0)
		button.BorderSizePixel = 3
		button.TextScaled = true
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.MouseButton1Click:Connect(callback)
	end
	
	createButton("Decal Spam", 1, 1, function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end

		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringg
			}

			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)

		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function Color(part,color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color,
						["UnionColoring"] = false
					}
				}
			}
			_(args)
		end
		function SpawnDecal(part,side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}

			_(args)
		end
		function AddDecal(part,asset,side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			_(args)
		end

		function spam(id)
			for i,v in game.workspace:GetDescendants() do
				if v:IsA("BasePart") then
					spawn(function()
						SetLocked(v,false)
						SpawnDecal(v,Enum.NormalId.Front)
						AddDecal(v,id,Enum.NormalId.Front)

						SpawnDecal(v,Enum.NormalId.Back)
						AddDecal(v,id,Enum.NormalId.Back)

						SpawnDecal(v,Enum.NormalId.Right)
						AddDecal(v,id,Enum.NormalId.Right)

						SpawnDecal(v,Enum.NormalId.Left)
						AddDecal(v,id,Enum.NormalId.Left)

						SpawnDecal(v,Enum.NormalId.Bottom)
						AddDecal(v,id,Enum.NormalId.Bottom)

						SpawnDecal(v,Enum.NormalId.Top)
						AddDecal(v,id,Enum.NormalId.Top)
					end)
				end
			end 
		end
		spam("101130257109590")
	end)

	createButton("Set Skybox", 1, 2, function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end

		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringg
			}

			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)

		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function Color(part,color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color,
						["UnionColoring"] = false
					}
				}
			}
			_(args)
		end
		function SpawnDecal(part,side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}

			_(args)
		end
		function AddDecal(part,asset,side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			_(args)
		end

		function Sky(id)
			e = char.HumanoidRootPart.CFrame.x
			f = char.HumanoidRootPart.CFrame.y
			g = char.HumanoidRootPart.CFrame.z
			CreatePart(CFrame.new(math.floor(e),math.floor(f),math.floor(g)) + Vector3.new(0,6,0),workspace)
			for i,v in game.Workspace:GetDescendants() do
				if v:IsA("BasePart") and v.CFrame.x == math.floor(e) and v.CFrame.z == math.floor(g) then
					SetName(v,"Sky")
					AddMesh(v)
					SetMesh(v,"8006679977")
					SetTexture(v,id)
					MeshResize(v,Vector3.new(50,50,50))
					SetLocked(v,true)
				end
			end
		end
		Sky("101130257109590")
	end)
--[[
just set this to make 66 button on the 666th line😈
XPRESS045 is goated ngl
XPRESS045 Fanclub goated ngl
hacker666 is shit ngl
tuboos93 is shit ngl
yall knew tuboos93 is a pedophile?
if not watch ts 🔥 https://www.youtube.com/watch?v=bUN5N6mIj5s
https://discord.gg/7gEksmdKgq 
tuboos93 propaganda game :
https://www.roblox.com/games/120058792047337/TUBOOS93-FANGAEM
Also Try:
https://scriptblox.com/script/Client-Replication-Xpress045-GUI-35134
If you havent like the code pls
https://scriptblox.com/script/Universal-Script-F3X-Xpress045-GUI-39216?notif_id=681eaf29ca58dc6c5ab10dc1
]]--
	createButton("666", 1, 3, function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end

		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringg
			}

			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)

		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function Color(part,color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color,
						["UnionColoring"] = false
					}
				}
			}
			_(args)
		end
		function SpawnDecal(part,side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}

			_(args)
		end
		function AddDecal(part,asset,side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			_(args)
		end

		function Sky(id)
			e = char.HumanoidRootPart.CFrame.x
			f = char.HumanoidRootPart.CFrame.y
			g = char.HumanoidRootPart.CFrame.z
			CreatePart(CFrame.new(math.floor(e),math.floor(f),math.floor(g)) + Vector3.new(0,6,0),workspace)
			for i,v in game.Workspace:GetDescendants() do
				if v:IsA("BasePart") and v.CFrame.x == math.floor(e) and v.CFrame.z == math.floor(g) then
					SetName(v,"Sky")
					AddMesh(v)
					SetMesh(v,"8006679977")
					SetTexture(v,id)
					MeshResize(v,Vector3.new(50,50,50))
					SetLocked(v,true)
				end
			end
		end

		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end

		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = part
				},
				[3] = stringg
			}

			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)

		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function Color(part,color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color,
						["UnionColoring"] = false
					}
				}
			}
			_(args)
		end
		function SpawnDecal(part,side)
			local args = {
				[1] = "CreateTextures",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal"
					}
				}
			}

			_(args)
		end
		function AddDecal(part,asset,side)
			local args = {
				[1] = "SyncTexture",
				[2] = {
					[1] = {
						["Part"] = part,
						["Face"] = side,
						["TextureType"] = "Decal",
						["Texture"] = "rbxassetid://".. asset
					}
				}
			}
			_(args)
		end

		function spam(id)
			for i,v in game.workspace:GetDescendants() do
				if v:IsA("BasePart") then
					spawn(function()
						SetLocked(v,false)
						SpawnDecal(v,Enum.NormalId.Front)
						AddDecal(v,id,Enum.NormalId.Front)

						SpawnDecal(v,Enum.NormalId.Back)
						AddDecal(v,id,Enum.NormalId.Back)

						SpawnDecal(v,Enum.NormalId.Right)
						AddDecal(v,id,Enum.NormalId.Right)

						SpawnDecal(v,Enum.NormalId.Left)
						AddDecal(v,id,Enum.NormalId.Left)

						SpawnDecal(v,Enum.NormalId.Bottom)
						AddDecal(v,id,Enum.NormalId.Bottom)

						SpawnDecal(v,Enum.NormalId.Top)
						AddDecal(v,id,Enum.NormalId.Top)
					end)
				end
			end 
		end

		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end

		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = workspace.Part
				},
				[3] = stringg
			}

			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)

		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function AddFire(part)
			local args = {
				[1] = "CreateDecorations",
				[2] = {
					[1] = {
						["Part"] = part,
						["DecorationType"] = "Fire"
					}
				}
			}
			_(args)
		end
		function FireParts()
			for i,v in game.Workspace:GetDescendants() do
				spawn(function()
					SetLocked(v,false)
					AddFire(v)
				end)
			end
		end
		FireParts()

	end)

	createButton("Kill All", 1, 4, function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
			for i,v in game.ReplicatedStorage:GetDescendants() do
				if v.Name == "SyncAPI" then
					tool = v.Parent
				end
			end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end
		
		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = workspace.Part
				},
				[3] = stringg
			}
		
			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)
		
		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		
		function KillAll()
			for i,v in game.Players:GetPlayers() do
				spawn(function()
					SetLocked(v.Character.Head,false)
					DestroyPart(v.Character.Head)
				end)
			end
		end
		KillAll()
	end)

	createButton("Rainbow World", 2, 2, function()
		local player = game.Players.LocalPlayer
		local char = player.Character
		local tool
		for i,v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
			for i,v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end
		remote = tool.SyncAPI.ServerEndpoint
		function _(args)
			remote:InvokeServer(unpack(args))
		end
		function SetCollision(part,boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end
		function SetAnchor(boolean,part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end
		function CreatePart(cf,parent)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = parent
			}
			_(args)
		end
		function DestroyPart(part)
			local args = {
				[1] = "Remove",
				[2] = {
					[1] = part
				}
			}
			_(args)
		end
		function MovePart(part,cf)
			local args = {
				[1] = "SyncMove",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf
					}
				}
			}
			_(args)
		end
		function Resize(part,size,cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end
		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end
	
		function SetMesh(part,meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://"..meshid
					}
				}
			}
			_(args)
		end
		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://"..texid
					}
				}
			}
			_(args)
		end
		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = workspace.Part
				},
				[3] = stringg
			}
	
			_(args)
		end
		function MeshResize(part,size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end
		function Weld(part1, part2,lead)
			local args = {
				[1] = "CreateWelds",
				[2] = {
					[1] = part1,
					[2] = part2
				},
				[3] = lead
			}
			_(args)
	
		end
		function SetLocked(part,boolean)
			local args = {
				[1] = "SetLocked",
				[2] = {
					[1] = part
				},
				[3] = boolean
			}
			_(args)
		end
		function SetTrans(part,int)
			local args = {
				[1] = "SyncMaterial",
				[2] = {
					[1] = {
						["Part"] = part,
						["Transparency"] = int
					}
				}
			}
			_(args)
		end
		function CreateSpotlight(part)
			local args = {
				[1] = "CreateLights",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight"
					}
				}
			}
			_(args)
		end
		function SyncLighting(part,brightness)
			local args = {
				[1] = "SyncLighting",
				[2] = {
					[1] = {
						["Part"] = part,
						["LightType"] = "SpotLight",
						["Brightness"] = brightness
					}
				}
			}
			_(args)
		end
		function Color(part,color)
			local args = {
				[1] = "SyncColor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Color"] = color,
						["UnionColoring"] = false
					}
				}
			}
			_(args)
		end
		function randomise()
			for i,v in game.Workspace:GetDescendants() do
				if v:IsA("BasePart") then
					spawn(function()
						SetLocked(v,false)
						Color(v,Color3.new(math.random(0,255),math.random(0,255),math.random(0,255)))
					end)
				end
			end
		end
		while wait(0.2) do
			spawn(function()
				randomise()
			end)
		end
	end)

	createButton("Xpress045 Rain", 2, 3, function()
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:Wait()
		local tool

		for i, v in player:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end

		for i, v in game.ReplicatedStorage:GetDescendants() do
			if v.Name == "SyncAPI" then
				tool = v.Parent
			end
		end

		local remote = tool.SyncAPI.ServerEndpoint

		function _(args)
			remote:InvokeServer(unpack(args))
		end

		function SetCollision(part, boolean)
			local args = {
				[1] = "SyncCollision",
				[2] = {
					[1] = {
						["Part"] = part,
						["CanCollide"] = boolean
					}
				}
			}
			_(args)
		end

		function SetAnchor(boolean, part)
			local args = {
				[1] = "SyncAnchor",
				[2] = {
					[1] = {
						["Part"] = part,
						["Anchored"] = boolean
					}
				}
			}
			_(args)
		end

		function CreatePart(cf)
			local args = {
				[1] = "CreatePart",
				[2] = "Normal",
				[3] = cf,
				[4] = workspace
			}
			_(args)
		end

		function Resize(part, size, cf)
			local args = {
				[1] = "SyncResize",
				[2] = {
					[1] = {
						["Part"] = part,
						["CFrame"] = cf,
						["Size"] = size
					}
				}
			}
			_(args)
		end

		function AddMesh(part)
			local args = {
				[1] = "CreateMeshes",
				[2] = {
					[1] = {
						["Part"] = part
					}
				}
			}
			_(args)
		end

		function SetMesh(part, meshid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["MeshId"] = "rbxassetid://" .. meshid
					}
				}
			}
			_(args)
		end

		function SetTexture(part, texid)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["TextureId"] = "rbxassetid://" .. texid
					}
				}
			}
			_(args)
		end

		function MeshResize(part, size)
			local args = {
				[1] = "SyncMesh",
				[2] = {
					[1] = {
						["Part"] = part,
						["Scale"] = size
					}
				}
			}
			_(args)
		end

		function SetName(part, stringg)
			local args = {
				[1] = "SetName",
				[2] = {
					[1] = workspace.Part
				},
				[3] = stringg
			}
			_(args)
		end

		function Sky(id)
			local hrp = char:WaitForChild("HumanoidRootPart")
			local cf = hrp.CFrame
			CreatePart(CFrame.new(cf.Position + Vector3.new(0, 6, 0)))
			for _, v in workspace:GetDescendants() do
				if v:IsA("BasePart") and v.CFrame.Position == cf.Position + Vector3.new(0, 6, 0) then
					SetAnchor(true, v)
					AddMesh(v)
					SetMesh(v, "137458024695143")
					SetTexture(v, id)
					MeshResize(v, Vector3.new(0, 0, 0))
				end
			end
		end

		local function createRainToads()
			while true do
				wait(0.01)
				if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
					local hrpcf = player.Character.HumanoidRootPart.CFrame
					local x = hrpcf.x
					local z = hrpcf.z
					local randint = math.random(-600, 600)
					local randint2 = math.random(-600, 600)
					local xloc = randint + x
					local zloc = randint2 + z
					local cf = player.Character.HumanoidRootPart.CFrame.y + 400

					spawn(function()
						local newToad = CreatePart(CFrame.new(math.floor(xloc), math.random(cf, cf + 400), math.floor(zloc)))
						for i, v in game.Workspace:GetDescendants() do
							if v.Name == "Part" and v.Parent == workspace and v.CFrame.x == math.floor(xloc) and v.CFrame.z == math.floor(zloc) then
								SetName(v, "Get trolled u fagz")
								SetAnchor(false, v)
								AddMesh(v)
								Resize(v, Vector3.new(50, 50, 50), v.CFrame)
								MeshResize(v, Vector3.new(15, 15, 15))
								SetMesh(v, "137458024695143")
								SetTexture(v, "86031221460311")
								SetCollision(v, true)
								v.Orientation = Vector3.new(0, 0, 0)

								v.CFrame = v.CFrame + Vector3.new(0, 0, 0)

								local sound = Instance.new("Sound", v)
								sound.SoundId = "rbxassetid://153752123" 
								sound.Volume = 0
								sound.PlayOnRemove = true
								sound:Destroy()
							end
						end
					end)
				else
					wait(1)
				end
			end
		end

		coroutine.wrap(createRainToads)()

		Sky("101130257109590")
	end)
end

createGUI()
