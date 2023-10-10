script_name("autopiar")
script_version("2")
--==libs==--
local imgui = require 'mimgui' -- подключаем библиотеку мимгуи
local encoding = require 'encoding' -- подключаем библиотеку для работы с разными кодировками
encoding.default = 'CP1251' -- задаём кодировку по умолчанию
local u8 = encoding.UTF8
local ffi = require 'ffi'
local sampev = require 'lib.samp.events'
local new = imgui.new
local faicons = require('fAwesome6')
local inicfg = require("inicfg")
local colorList = {u8'Красная', u8'Зелёная',u8'Синяя', u8'Фиолетовая'}
local colorListNumber = new.int()
local colorListBuffer = new['const char*'][#colorList](colorList)
--==locals==--
local ininame = ("autopiaar.ini")
local ini = inicfg.load(inicfg.load({
    themes = {
        number = 3
    },
}, ininame))
inicfg.save(ini, ininame)

--==ints==--
local delayvr1 = new.int(10)
local delayvr2 = new.int(1)
local delayvr3 = new.int(1)
local delayfb1 = new.int(10)
local delayfb2 = new.int(10)
local delayfb3 = new.int(10)
local delaytwovr = new.int(10)
local delaytwofb = new.int(10)
local tab = 1
local delayfam1 = new.int(10)
local delayfam2 = new.int(10)
local delayfam3 = new.int(10)
--==chars==--
local textvr2 = new.char[236]()
local textvr3 = new.char[256]()
local inputField = new.char[256]()
local textfam1 = new.char[256]()
local textfam2 = new.char[256]()
local textfam3 = new.char[256]()
local textfb1 = new.char[256]()
local textfb2 = new.char[256]()
local textfb3 = new.char[256]()
local idDialog = new.char[256]()
local textfam1 = new.char[256]()
local textfam2 = new.char[256]()
local textfam3 = new.char[256]()
local textad = new.char[256]()
--==bool==--
local vrpiar = false
local vrpiar2 = false
local vrpiar3 = false
local fbpiar1 = false
local fbpiar2 = false
local fbpiar3 = false
local fampiar1 = false
local fampiar2 = false
local fampiar3 = false
local WinState = new.bool()
local vrdialog = new.bool()
local showid = new.bool()
local sfradio = new.bool()
local lvradio = new.bool()
local lsradio = new.bool()
local sfpiar = false
local lvpiar = false
local lspiar = false
local enable_autoupdate = true
local autoupdate_loaded = false
local Update = nil
--==theme==--
theme = {
    {
        change = function()
            local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(1.00, 1.00, 1.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
            imgui.GetStyle().Colors[imgui.Col.Tab]                    = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.TabHovered]             = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabActive]              = ImVec4(0.98, 0.06, 0.06, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
        end
    },
    {
        change = function()
            local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(0.10, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.70, 0.70, 0.70, 0.40)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.15, 0.15, 0.15, 1.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.19, 0.19, 0.19, 0.71)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.34, 0.34, 0.34, 0.79)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.00, 0.69, 0.33, 0.80)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.00, 0.74, 0.36, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.69, 0.33, 0.50)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.00, 0.80, 0.38, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.16, 0.16, 0.16, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.00, 1.00, 0.48, 1.00)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.00, 0.77, 0.37, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.00, 0.82, 0.39, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.00, 0.87, 0.42, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.00, 0.76, 0.37, 0.57)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.00, 0.88, 0.42, 0.89)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.60)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 0.80)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.00, 0.76, 0.37, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.00, 0.86, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(0.00, 0.74, 0.36, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.00, 0.69, 0.33, 0.72)
        end
    },
    {
        change = function()
            local ImVec4 = imgui.ImVec4
            
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.06, 0.53, 0.98, 0.70)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(0.10, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.06, 0.53, 0.98, 0.70)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
        end
    },
    {
        change = function()
            imgui.SwitchContext()
            local style = imgui.GetStyle()
            local colors = style.Colors
            local clr = imgui.Col
            local ImVec4 = imgui.ImVec4
            colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)

            colors[clr.WindowBg]               = ImVec4(0.15, 0.16, 0.37, 1.00)
            colors[clr.ChildBg]                = ImVec4(0.17, 0.18, 0.43, 1.00)
            colors[clr.PopupBg]                = colors[clr.WindowBg]

            colors[clr.Border]                 = ImVec4(0.33, 0.34, 0.62, 1.00)
            colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)

            colors[clr.TitleBg]                = ImVec4(0.18, 0.20, 0.46, 1.00)
            colors[clr.TitleBgActive]          = ImVec4(0.18, 0.20, 0.46, 1.00)
            colors[clr.TitleBgCollapsed]       = ImVec4(0.18, 0.20, 0.46, 1.00)
            colors[clr.MenuBarBg]              = colors[clr.ChildBg]

            colors[clr.ScrollbarBg]            = ImVec4(0.14, 0.14, 0.36, 1.00)
            colors[clr.ScrollbarGrab]          = ImVec4(0.22, 0.22, 0.53, 1.00)
            colors[clr.ScrollbarGrabHovered]   = ImVec4(0.20, 0.21, 0.53, 1.00)
            colors[clr.ScrollbarGrabActive]    = ImVec4(0.25, 0.25, 0.58, 1.00)

            colors[clr.Button]                 = ImVec4(0.25, 0.25, 0.58, 1.00)
            colors[clr.ButtonHovered]          = ImVec4(0.23, 0.23, 0.55, 1.00)
            colors[clr.ButtonActive]           = ImVec4(0.27, 0.27, 0.62, 1.00)

            colors[clr.CheckMark]              = ImVec4(0.39, 0.39, 0.83, 1.00)
            colors[clr.SliderGrab]             = ImVec4(0.39, 0.39, 0.83, 1.00)
            colors[clr.SliderGrabActive]       = ImVec4(0.48, 0.48, 0.96, 1.00)

            colors[clr.FrameBg]                = colors[clr.Button]
            colors[clr.FrameBgHovered]         = colors[clr.ButtonHovered]
            colors[clr.FrameBgActive]          = colors[clr.ButtonActive]

            colors[clr.Header]                 = colors[clr.Button]
            colors[clr.HeaderHovered]          = colors[clr.ButtonHovered]
            colors[clr.HeaderActive]           = colors[clr.ButtonActive]

            colors[clr.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            colors[clr.SeparatorHovered]       = colors[clr.SliderGrabActive]
            colors[clr.SeparatorActive]        = colors[clr.SliderGrabActive]

            colors[clr.ResizeGrip]             = colors[clr.Button]
            colors[clr.ResizeGripHovered]      = colors[clr.ButtonHovered]
            colors[clr.ResizeGripActive]       = colors[clr.ButtonActive]

            colors[clr.Tab]                    = colors[clr.Button]
            colors[clr.TabHovered]             = colors[clr.ButtonHovered]
            colors[clr.TabActive]              = colors[clr.ButtonActive]
            colors[clr.TabUnfocused]           = colors[clr.Button]
            colors[clr.TabUnfocusedActive]     = colors[clr.Button]

            colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)

            colors[clr.TextSelectedBg]         = ImVec4(0.33, 0.33, 0.57, 1.00)
            colors[clr.DragDropTarget]         = ImVec4(1.00, 1.00, 0.00, 0.90)

            colors[clr.NavHighlight]           = ImVec4(0.26, 0.59, 0.98, 1.00)
            colors[clr.NavWindowingHighlight]  = ImVec4(1.00, 1.00, 1.00, 0.70)
            colors[clr.NavWindowingDimBg]      = ImVec4(0.80, 0.80, 0.80, 0.20)

            colors[clr.ModalWindowDimBg]       = ImVec4(0.00, 0.00, 0.00, 0.90)
        end
    },
}

--==main==--
function sampev.onServerMessage(color, textik)
    if textik:find("Используйте /fb") or textik:find("Используйте /rb") then
        return false
    end
end
function sampev.onShowDialog(dialogId, style, title, button1, button2, textxxxx)
    if vrpiar or vrpiar2 or vrpiar3 then
        if textxxxx:find("Ваше сообщение является рекламой") and button1 == "Да" then
            sampSendDialogResponse(dialogId, 1, -1, -1)
            return false
        end
    end
    if lspiar or lvpiar or sfpiar then
        if lspiar then
            sampSendDialogResponse(25476, 1, 0, -1)
            sampSendDialogResponse(15346, 1, 0, -1)
            sampSendDialogResponse(15347, 1, -1, -1)
        end
        if lvpiar then
            sampSendDialogResponse(25476, 1, 1, -1)
            sampSendDialogResponse(15346, 1, 0, -1)
            sampSendDialogResponse(15347, 1, -1, -1)
        end
        if sfpiar then
            sampSendDialogResponse(25476, 1, 2, -1)
            sampSendDialogResponse(15346, 1, 0, -1)
            sampSendDialogResponse(15347, 1, -1, -1)
        end
        return false
    end
    return true
end
imgui.OnFrame(function() return WinState[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(500,500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) -- отвечает за положение окна на экране
        imgui.SetNextWindowSize(imgui.ImVec2(840, 545), imgui.Cond.Always) -- отвечает за размер окна
        imgui.Begin(u8'Основное', WinState, imgui.WindowFlags.NoResize) -- отвечает за отображение окна, его заголовок и флаги
        if imgui.Button(u8' Пиар в /vr', imgui.ImVec2(200, 125)) then tab = 1 end
        if imgui.Button(faicons("gun")..u8' Пиар в /fb|/rb', imgui.ImVec2(200, 125)) then tab = 2 end
        if imgui.Button(faicons("person")..u8' Пиар в /fam|/al', imgui.ImVec2(200, 125)) then tab = 3 end
        if imgui.Button(faicons('gear')..u8' Настройки', imgui.ImVec2(200, 125)) then tab = 4 end

        imgui.SetCursorPos(imgui.ImVec2(220, 30))
        if imgui.BeginChild('Name##'..tab, imgui.ImVec2(600, 490), true) then
            --==vrpiar==--
            if tab == 1 then
                imgui.Text(u8"/vr 1 сообощение")
                if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then vrpiar = not vrpiar end
                imgui.SameLine()
                imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /vr', inputField, 256)
                imgui.PushItemWidth(585)
                imgui.SliderInt(u8'##Первый', delayvr1, 1, 600)
                imgui.SameLine()
                imgui.SetCursorPos(imgui.ImVec2(5, 70))
                if imgui.BeginChild('Name##'..tab, imgui.ImVec2(600, 400), true) then
                    imgui.Text(u8"/vr 2 сообощение")
                    if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then vrpiar2 = not vrpiar2 end
                    imgui.SameLine()
                    imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /vr', textvr2, 236)
                    imgui.PushItemWidth(585)
                    imgui.SliderInt(u8'##Первый', delayvr2, 1, 650)
                    imgui.SetCursorPos(imgui.ImVec2(1, 110))
                    if imgui.BeginChild('Name##'..tab, imgui.ImVec2(585, 100), true) then
                        imgui.Text(u8"/vr 3 сообощение")
                        if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then vrpiar3 = not vrpiar3 end
                        imgui.SameLine()
                        imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /vr', textvr3, 256)
                        imgui.PushItemWidth(585)
                        imgui.SliderInt(u8'##Первый', delayvr3, 1, 650)
                        imgui.EndChild()
                    end
                    imgui.EndChild()
                end
            --==FB or RB piar
            elseif tab == 2 then
                if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then fbpiar1 = not fbpiar1 end
                imgui.SameLine()
                imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /fb', textfb1, 256)
                imgui.PushItemWidth(585)
                imgui.SliderInt(u8'##Первый', delayfb1, 1, 600)
                imgui.SameLine()
                imgui.SetCursorPos(imgui.ImVec2(5, 70))
                if imgui.BeginChild('Name##'..tab, imgui.ImVec2(600, 400), true) then
                    if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then fbpiar2 = not fbpiar2 end
                    imgui.SameLine()
                    imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /fb', textfb2, 236)
                    imgui.PushItemWidth(585)
                    imgui.SliderInt(u8'##Первый', delayfb2, 1, 650)
                    imgui.SetCursorPos(imgui.ImVec2(1, 110))
                    if imgui.BeginChild('Name##'..tab, imgui.ImVec2(585, 100), true) then
                        if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then fbpiar3 = not fbpiar3 end
                        imgui.SameLine()
                        imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /fb', textfb3, 256)
                        imgui.PushItemWidth(585)
                        imgui.SliderInt(u8'##Первый', delayfb3, 1, 650)
                        imgui.EndChild()
                    end
                    imgui.EndChild()
                end
            --==fam and al piar==--
            elseif tab == 3 then
                if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then fampiar1 = not fampiar1 end
                imgui.SameLine()
                imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /fam', textfam1, 256)
                imgui.PushItemWidth(585)
                imgui.SliderInt(u8'##Первый', delayfam1, 1, 600)
                imgui.SameLine()
                imgui.SetCursorPos(imgui.ImVec2(5, 70))
                if imgui.BeginChild('Name##'..tab, imgui.ImVec2(600, 400), true) then
                    if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then fampiar2 = not fampiar2 end
                    imgui.SameLine()
                    imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /fam', textfam2, 236)
                    imgui.PushItemWidth(585)
                    imgui.SliderInt(u8'##Первый', delayfam2, 1, 650)
                    imgui.SetCursorPos(imgui.ImVec2(1, 110))
                    if imgui.BeginChild('Name##'..tab, imgui.ImVec2(585, 100), true) then
                        if imgui.Button(u8'On|of piar', imgui.ImVec2(185, 20)) then fampiar3 = not fampiar3 end
                        imgui.SameLine()
                        imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /fam', textfam3, 256)
                        imgui.PushItemWidth(585)
                        imgui.SliderInt(u8'##Первый', delayfam3, 1, 650)
                        imgui.EndChild()
                    end
                    imgui.EndChild()
                end
            elseif tab == 4 then
                if imgui.Combo(u8'Темы',colorListNumber,colorListBuffer, #colorList) then
                    theme[colorListNumber[0]+1].change()
                    ini.themes.number = colorListNumber[0]
                    inicfg.save(ini, ininame)
                end
                if imgui.CollapsingHeader(u8'Основные настройки') then
                    imgui.Text(u8"Задержка между первым и вторым сообщением")
                    imgui.SliderInt(u8'##Первый', delaytwofb, 1, 650)
                    imgui.Separator()
                end
                if imgui.CollapsingHeader(u8'Настройки пиара в ад') then
                    imgui.Text(u8"Важно!!!! задержка перед каждой отправкой 60 секунд")
                    imgui.InputTextWithHint(u8'##Ещё пример', u8'Текст пиара в /ad', textad, 256)
                    imgui.SameLine()
                    if imgui.Checkbox("Sf", sfradio) then
                        if lvradio[0] or lsradio[0] then
                            sfradio[0] = false
                            sfpiar = false
                        else
                            sfpiar = true
                        end
                    end
                    imgui.SameLine()
                    if imgui.Checkbox("lv", lvradio) then
                        lvpiar = not lvpiar
                        if sfradio[0] or lsradio[0] then
                            lvradio[0] = false
                            lvpiar = false
                        else
                            lvpiar = true
                        end
                    end
                    imgui.SameLine()
                    if imgui.Checkbox("ls", lsradio) then
                        if lvradio[0] or sfradio[0] then
                            lsradio[0] = false
                            lspiar = false
                        else
                            lspiar = true
                        end
                    end
                    imgui.Separator()
                end
            end
            imgui.EndChild()
        end
        imgui.End()
    end)


function main()
    sampRegisterChatCommand('piar', function() WinState[0] = not WinState[0] end) -- команда по которой будет вызываться наше окно
    if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
    --==VR PIAR==--
    lua_thread.create(function()
        while true do
            wait(0)
            if vrpiar and inputField[0] ~= 0 then
                textPPP = u8:decode(ffi.string(inputField))
                wait(3000)
                sampSendChat("/vr "..textPPP)
                if vrpiar2 or vrpiar3 then
                    wait(delaytwofb[0]*1000)
                else
                    wait(delayvr1[0]*1000)
                end
            elseif vrpiar then
                vrpiar = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
            if vrpiar3 and textvr3[0] ~= 0 then
                textx = u8:decode(ffi.string(textvr3))
                sampSendChat("/vr "..textx)
                wait(delayvr3[0]*1000)
            elseif vrpiar3 then
                vrpiar3 = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
            if vrpiar2 and textvr2[0] ~= 0 then
                texts = u8:decode(ffi.string(textvr2))
                sampSendChat("/vr "..texts)
                wait(delayvr2[0]*1000)
            elseif vrpiar2 then
                vrpiar2 = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
        end
    end)
    --==FBPIAR==--
    lua_thread.create(function()
        while true do
            wait(0)
            if fbpiar1 and textfb1[0] ~= 0 then
                textF = u8:decode(ffi.string(textfb1))
                wait(3000)
                sampSendChat("/fb "..textF)
                wait(1000)
                sampSendChat("/rb "..textF)
                if fbpiar2 or fbpiar3 then
                    wait(delaytwofb[0]*1000)
                else
                    wait(delayfb1[0]*1000)
                end
            elseif fbpiar1 then
                fbpiar1 = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
            if fbpiar2 and textfb2[0] ~= 0 then
                textP = u8:decode(ffi.string(textfb2))
                sampSendChat("/fb "..textP)
                wait(1000)
                sampSendChat("/rb "..textP)
                wait(delayfb2[0]*1000)
            elseif fbpiar2 then
                fbpiar2 = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
            if fbpiar3 and textfb3[0] ~= 0 then
                textXX = u8:decode(ffi.string(textfb3))
                sampSendChat("/fb "..textXX)
                wait(1000)
                sampSendChat("/rb "..textXX)
                wait(delayfb3[0]*1000)
            elseif fbpiar3 then
                fbpiar3 = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
        end
    end)
    --==fampiar==--
    lua_thread.create(function()
        while true do
            wait(0)
            if fampiar1 and textfam1[0] ~= 0 then
                textFF = u8:decode(ffi.string(textfam1))
                wait(3000)
                sampSendChat("/fam "..textFF)
                wait(1000)
                sampSendChat("/al "..textFF)
                if fampiar2 or fampiar3 then
                    wait(delaytwofb[0]*1000)
                else
                    wait(delayfam1[0]*1000)
                end
            elseif fampiar1 then
                fampiar1 = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
            if fampiar2 and textfam2[0] ~= 0 then
                textPP = u8:decode(ffi.string(textfam2))
                sampSendChat("/al "..textPP)
                wait(1000)
                sampSendChat("/fam "..textPP)
                wait(delayfam2[0]*1000)
            elseif fampiar2 then
                fampiar2 = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
            if fampiar3 and textfam3[0] ~= 0 then
                textXXX = u8:decode(ffi.string(textfam3))
                sampSendChat("/fam "..textXXX)
                wait(1000)
                sampSendChat("/al "..textXXX)
                wait(delayfam3[0]*1000)
            elseif fampiar3 then
                fampiar3 = false
                sampAddChatMessage("Введите текст в инпут", -1)
            end
        end
    end)
    --==adpiar==--
    lua_thread.create(function()
        while true do
            wait(0)
            if sfpiar or lspiar or lvpiar then
                textXXXX = u8:decode(ffi.string(textad))
                sampSendChat("/ad "..textXXXX)
                wait(60000)
            end
        end
    end)
    wait(-1)
end

  
imgui.OnInitialize(function()
    decor()
    if ini.themes.number == 0 then
        theme[1].change()
    elseif ini.themes.number == 1 then
        theme[2].change()
    elseif ini.themes.number == 2 then
        theme[3].change()
    elseif ini.themes.number == 3 then
        theme[4].change()
    end
    imgui.GetIO().IniFilename = nil
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('solid'), 14, config, iconRanges)
  end)
  
  function decor()
      imgui.SwitchContext()
      local style = imgui.GetStyle()
      local colors = style.Colors
      local clr = imgui.Col
      local ImVec4 = imgui.ImVec4
  
      -->> Sizez
      imgui.GetStyle().WindowPadding = imgui.ImVec2(4, 4)
      imgui.GetStyle().FramePadding = imgui.ImVec2(4, 3)
      imgui.GetStyle().ItemSpacing = imgui.ImVec2(8, 4)
      imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(4, 4)
      imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
  
      imgui.GetStyle().IndentSpacing = 21
      imgui.GetStyle().ScrollbarSize = 14
      imgui.GetStyle().GrabMinSize = 10
  
      imgui.GetStyle().WindowBorderSize = 0
      imgui.GetStyle().ChildBorderSize = 1
      imgui.GetStyle().PopupBorderSize = 1
      imgui.GetStyle().FrameBorderSize = 1
      imgui.GetStyle().TabBorderSize = 0
  
      imgui.GetStyle().WindowRounding = 5
      imgui.GetStyle().ChildRounding = 5
      imgui.GetStyle().PopupRounding = 5
      imgui.GetStyle().FrameRounding = 5
      imgui.GetStyle().ScrollbarRounding = 2.5
      imgui.GetStyle().GrabRounding = 5
      imgui.GetStyle().TabRounding = 5
      imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.50, 0.50)
  

  end
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/qrlk/moonloader-script-updater/master/minified-example.json?" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/qrlk/moonloader-script-updater/"
        end
    end
end
