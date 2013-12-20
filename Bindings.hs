module Bindings (idle, display, reshape, keyboardMouse) where
 
import Graphics.UI.GLUT
import Display
import Data.IORef
import System.Exit

increaseAz :: GLfloat -> Args -> Args
increaseAz amt (Args (ang, az) per) = (Args (ang, az+amt) per)

reshape :: IORef Args -> ReshapeCallback
reshape args size@(Size w h) = do 
    let update (Args ang (Perspective a _ b c)) = (Args ang (Perspective a ((fromIntegral w)/(fromIntegral h)) b c))

    viewport $= (Position 0 0, size)
    modifyIORef args update
 
keyboardMouse :: IORef Args -> KeyboardMouseCallback
keyboardMouse args key _state _modifiers _position =
    case key of
        (SpecialKey KeyUp) -> modifyIORef args $ increaseAz 4
        (SpecialKey KeyDown) -> modifyIORef args $ increaseAz (-4)
        (Char '\x1B') -> exitSuccess
        _ -> return()

idle :: IORef Args -> IdleCallback
idle args = do
    let update (Args (ang,az) p) = Args ((ang + 3), az) p
    modifyIORef args update
    postRedisplay Nothing
