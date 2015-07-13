-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)
import Data.Maybe (maybe)

import XMonad
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Config.Kde
import XMonad.Config.Xfce
import Graphics.X11.ExtraTypes.XF86 

import XMonad.Hooks.UrgencyHook
import XMonad.Util.NamedWindows
import XMonad.Util.Run

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- a hook that sends a notification if a window requires attention and we're not currently focusing the workspace
data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset
        safeSpawn "notify-send" [show name, "workspace " ++ idx]

myKeys = \c -> M.fromList $
    [("<XF86MonBrightnessUp>", spawn "xbacklight +20")
    -- ,("<XF86MonBrightnessDown>", spawn "xbacklight -20")
    -- ,("<XF86AudioRaiseVolume>", spawn "amixer set Master 1+ unmute")
    -- ,("<XF86AudioLowerVolume>", spawn "amixer set Master 1- unmute")
    ]

main = do
     session <- getEnv "DESKTOP_SESSION"
     let config = maybe desktopConfig desktop session
     xmonad
        $ withUrgencyHook LibNotifyUrgencyHook
        $ config{ terminal = "konsole"
                  -- ,keys = myKeys
        }

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "xmonad-mate" = gnomeConfig
desktop _ = desktopConfig
