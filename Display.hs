module Display where

import Graphics.UI.GLUT
import Debug.Trace
import Data.IORef
import Cube

data PointColor = PointColor (Vertex3 GLfloat) (Color3 GLfloat)
data Camera = Camera {
    position :: Vertex3 GLdouble,
    lookAtPoint :: Vertex3 GLdouble,
    upVector :: Vector3 GLdouble
}

cameraLookAt :: Camera -> IO()
cameraLookAt (Camera pos look up) = do
    perspective 50 1.8 0.1 200
    lookAt pos look up

plot :: PointColor -> IO ()
plot (PointColor vert col) = do
    vertex $ vert
    color  $ col

display :: (IORef GLfloat, IORef Camera) -> DisplayCallback
display (angle, camera) = do
    let strip rows cols  = if rows <= 0
        then []
        else [ PointColor (Vertex3 x y 0) (Color3 (0.2 * x) (0.2 * y) 1) | x <- [0..cols], y <- [rows-1,rows] ] ++ (strip (rows-1) cols)
    let temp :: (GLfloat,GLfloat,GLfloat) ; temp = (0,-1,0)
    let (x,y,z) = temp

    get camera >>= cameraLookAt
    clear [ColorBuffer]
    loadIdentity
    a <- get angle
    rotate a $ Vector3 0 0 1
    preservingMatrix $ do
        translate $ Vector3 x y z
        renderPrimitive QuadStrip $ do
            (mapM_ plot (strip 3 10))
    swapBuffers
