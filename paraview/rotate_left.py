from paraview.simple import GetActiveCamera, Render

cam = GetActiveCamera()
cam.Azimuth(-5)
cam.OrthogonalizeViewUp()
Render()
