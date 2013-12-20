module Display where
 
import Graphics.UI.GLUT
import Cube
import Data.IORef
import Data.Angle

data Perspective = Perspective GLdouble GLdouble GLdouble GLdouble
data Args = Args (GLfloat,GLfloat) Perspective

projectPerspective :: Perspective -> IO()
projectPerspective (Perspective fov asp zn zf) = perspective fov asp zn zf

display :: IORef Args -> DisplayCallback
display args = do 
    (Args (angle, az) proj) <- get args

    clear [ColorBuffer]
    loadIdentity

    let ex = 0
    let ey = fromRational.toRational.sine.Degrees $ az
    let ez = fromRational.toRational.cosine.Degrees $ az

    projectPerspective proj
    lookAt (Vertex3 ex ey ez) (Vertex3 0.0 0.0 0.0) (Vector3 0 1 0);
    
    preservingMatrix $ do   
        rotate angle (Vector3 0 1 0)
        cube 0.2

    swapBuffers
