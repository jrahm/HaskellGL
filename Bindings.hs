module Bindings (idle, display, reshape, keyboardMouse) where

import Graphics.UI.GLUT
import Display

import Data.IORef

reshape :: ReshapeCallback
reshape size = do
    viewport $= (Position 0 0, size)
    postRedisplay Nothing

idle :: IORef GLfloat -> IdleCallback
idle angle = do
    angle $~! (+ 0.1)
    postRedisplay Nothing

keyboardMouse :: KeyboardMouseCallback
keyboardMouse _key _state _modifiers _position = return ()
