from paraview.simple import GetActiveCamera, Render
from math import sqrt, tan, radians


def pan(dx, dy, factor=0.10):
    """
    Pan the scene in screen-space directions.

    dx:
        -1 = left
         1 = right

    dy:
        -1 = down
         1 = up

    factor:
        fraction of visible height to move per keypress
    """

    cam = GetActiveCamera()
    cam.OrthogonalizeViewUp()

    d = cam.GetDirectionOfProjection()
    up = cam.GetViewUp()

    # Screen-right vector = direction x up
    right = (
        d[1] * up[2] - d[2] * up[1],
        d[2] * up[0] - d[0] * up[2],
        d[0] * up[1] - d[1] * up[0],
    )

    rn = sqrt(sum(x * x for x in right))
    right = tuple(x / rn for x in right)

    un = sqrt(sum(x * x for x in up))
    up = tuple(x / un for x in up)

    if cam.GetParallelProjection():
        step = cam.GetParallelScale() * factor
    else:
        step = (
            cam.GetDistance()
            * tan(radians(cam.GetViewAngle() / 2.0))
            * factor
        )

    # Move camera opposite to desired scene motion.
    shift = tuple(
        -step * (dx * right[i] + dy * up[i])
        for i in range(3)
    )

    p = cam.GetPosition()
    f = cam.GetFocalPoint()

    cam.SetPosition(*(p[i] + shift[i] for i in range(3)))
    cam.SetFocalPoint(*(f[i] + shift[i] for i in range(3)))

    Render()
