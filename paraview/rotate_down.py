from paraview.simple import GetActiveCamera, Render

cam = GetActiveCamera()
cam.Elevation(-5)
cam.OrthogonalizeViewUp()
Render()
