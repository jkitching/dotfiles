--
-- xmonad config file
--

import XMonad
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Contribs
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.BoringWindows
import XMonad.Layout.Tabbed
import XMonad.Layout.Minimize
import XMonad.Actions.DeManage
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS(toggleWS)
import XMonad.Actions.TopicSpace
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Prompt
import XMonad.Prompt.Workspace
import XMonad.Util.Run(spawnPipe)
import IO(hPutStrLn)
kill8 ss | Just w <- W.peek ss = (W.insertUp w) $ W.delete w ss | otherwise = ss

myTerminal      = "urxvt"

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = [ "1|org"
                  , "2|web"
                  , "3|cs317"
                  , "4|cs448b"
                  , "5|film"
                  , "6|micd"
                  , "7|android"
                  , "8|chin"
                  , "9|extra"
                  , "0|music"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#303030"
myFocusedBorderColor = "#a8cc90"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- launch a terminal
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu -fn '-*-profont-*-r-*-*-*-220-*-*-*-*-*-*' -nb '#7088ac' -nf '#FFFFFF' -sb '#303030'` && eval \"exec $exe\"")

    -- launch gmrun
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window 
    , ((modMask .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modMask,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modMask,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modMask,               xK_Tab   ), focusDown)

    -- Move focus to the next window
    , ((modMask,               xK_j     ), focusDown)

    -- Move focus to the previous window
    , ((modMask,               xK_k     ), focusUp  )

    -- Move focus to the master window
    , ((modMask,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modMask,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modMask,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modMask,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- toggle the status bar gap
    -- TODO, update this binding with avoidStruts , ((modMask              , xK_b     ),

    -- Quit xmonad
     , ((modMask .|. shiftMask, xK_BackSpace ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modMask              , xK_q     ), restart "xmonad" True)

    -- Invert colours in X
    , ((modMask              , xK_i     ), spawn "xcalib -i -a")

    -- Contrib
    , ((modMask              , xK_a     ), sequence_ $ [windows $ copy i | i <- XMonad.workspaces conf])
    , ((modMask .|. shiftMask, xK_a     ), windows $ kill8 )
    , ((modMask              , xK_b     ), markBoring )
    , ((modMask .|. shiftMask, xK_b     ), clearBoring )
    , ((modMask              , xK_semicolon ), toggleWS)

    -- Contrib :: XMonad.Layout.Minimize
    , ((modMask,               xK_m     ), withFocused (\f -> sendMessage (MinimizeWin f)))
    , ((modMask .|. shiftMask, xK_m     ), sendMessage RestoreNextMinimizedWin)
    ]
    ++

    -- Contrib :: XMonad.Actions.TopicSpace
--    [ ((modMask              , xK_a     ), currentTopicAction myTopicConfig)
--    , ((modMask              , xK_g     ), promptedGoto)
--    , ((modMask .|. shiftMask, xK_g     ), promptedShift)
--    ]
--    ++
--    [ ((modMask, k), switchNthLastFocused myTopicConfig i)
--      | (i, k) <- zip [1..] [xK_1 .. xK_9] ]
--    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    -- | (i, k) <- zip (XMonad.workspaces conf) ([xK_grave] ++ [xK_1 .. xK_9])
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
-- myLayout = avoidStruts(smartBorders(boringWindows(tiled ||| Mirror tiled ||| Grid ||| noBorders (Full))))
myLayout = minimize(avoidStruts(smartBorders(boringWindows(tiled ||| Mirror tiled ||| Grid ||| noBorders (simpleTabbed)))))
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"           --> doFloat
    , className =? "Gimp"              --> doFloat
    , className =? "Dialog"            --> doFloat
--    , resource  =? "Gnome-panel"       --> doIgnore
    , resource  =? "gnome-panel"       --> doFloat
--    , className =? "Gnome-panel"       --> doIgnore
    , resource  =? "desktop_window"    --> doIgnore
    , resource  =? "kdesktop"          --> doIgnore
    ]

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
-- myLogHook = dynamicLogWithPP $ xmobarPP
--	{ ppOutput = hPutStrLn xmproc
--	, ppTitle = xmobarColor "green" "" . shorten 50
--	}

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    --checkTopicConfig myTopics myTopicConfig
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaults
    	{ logHook = dynamicLogWithPP $ xmobarPP
		{ ppOutput = hPutStrLn xmproc
		, ppTitle = xmobarColor "green" "" . shorten 50
		},
        startupHook = setWMName "LG3D"
	-- fix java app menus
	-- see http://www.haskell.org/haskellwiki/Xmonad/Frequently_asked_questions
	}

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        --workspaces         = myTopics,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = manageDocks <+> myManageHook <+> manageHook defaultConfig,
        --logHook            = myLogHook,
        startupHook        = myStartupHook
    }
