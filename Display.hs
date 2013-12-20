module Display where

import Graphics.UI.GLUT
-- import Debug.Trace
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
    perspective 50 1.8 0.2 200
    lookAt (Vertex3 0 0 1) (Vertex3 0 0 0) (Vector3 0 0 1)

display :: (a,b) -> DisplayCallback
display (_,_) = do 
  clear [ColorBuffer]
  cube 0.2
  flush
