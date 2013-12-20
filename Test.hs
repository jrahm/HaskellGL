module Main where

import Graphics.UI.GLUT
import Bindings
import Data.IORef
import Display

main :: IO ()
main = do
    (_progName, _args) <- getArgsAndInitialize
    initialDisplayMode $= [WithDepthBuffer, DoubleBuffered]
    _window <- createWindow "Hello, World"
    reshapeCallback $= Just reshape
    depthFunc $= Just Less

    angle <- newIORef 0.0
    camera <- newIORef (Camera (Vertex3 0 0 1) (Vertex3 0 0 0) (Vector3 0 1 0))

    displayCallback $= display (angle, camera)
    keyboardMouseCallback $= Just keyboardMouse
    idleCallback $= (Just $ idle angle)
    mainLoop
