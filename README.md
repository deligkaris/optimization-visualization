# Geometry Optimization Visualization with VTK

VTK script that can visualize the results of a geometry optimization of a bimolecular complex (geometry, forces, and hessian). 

The extractDATA.pl script is use to transform the geometry optimization results to a format VTK can read.

To do:

- Relaxed atoms do not show up (missing actors?)
- Movie file shows the initial frame only
- Saving an image will always use the initial frame (even though the rendering window shows a different optimization cycle)
