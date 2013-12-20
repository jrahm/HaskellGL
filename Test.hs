import Graphics.UI.GLUT
import Bindings

import Data.IORef
import Display
 
main :: IO ()
main = do
    (_progName, _args) <- getArgsAndInitialize
    initialDisplayMode $= [WithDepthBuffer,DoubleBuffered]
    
    angle <- newIORef (Args (0.0,0.0) (Perspective 50 1.8 0.1 1000))

    _window <- createWindow "Hello World"
    displayCallback $= display angle
    reshapeCallback $= (Just $ reshape angle);
    keyboardMouseCallback $= (Just $ keyboardMouse angle)
    idleCallback $= (Just $ idle angle)
    mainLoop
