################################################################################################
#
# Author: Christos Deligkaris
#
# Fall 2008
#  
###############################################################################################

package require vtk
package require vtkinteraction
package require vtktesting

###############################################################################################

#specify where all your data are

#set VTK_DATA "../data_water_dimer"
set VTK_DATA "../data_uracil_dimer_stack"

#specify the number of optimization cycles that you want to visualize
#it should not be larger than the number of input files you have

#for uracil
set nofCycles 180
#for water
#set nofCycles 10

############################# FROZEN MOLECULES #######################################

#read the XYZ file with the frozen molecule(s)

vtkXYZMolReader frozen
  	frozen SetFileName "$VTK_DATA/frozen.xyz"
	#force the pipeline to execute
	frozen Update

		############ ATOMS (FROZEN) #################

vtkSphereSource Sphere
	Sphere SetCenter 0 0 0 
	Sphere SetRadius 1
	Sphere SetThetaResolution 8
	Sphere SetStartTheta 0
	Sphere SetEndTheta 360
	Sphere SetPhiResolution 8
	Sphere SetStartPhi 0
	Sphere SetEndPhi 180

vtkGlyph3D GlyphAtomsFrozen
	GlyphAtomsFrozen SetInputConnection [frozen GetOutputPort]
	GlyphAtomsFrozen SetOrient 1
	GlyphAtomsFrozen SetColorMode 1
	#GlyphAtomsFrozen ScalingOn
	GlyphAtomsFrozen SetScaleMode 2
	GlyphAtomsFrozen SetScaleFactor .25
	GlyphAtomsFrozen SetSource [Sphere GetOutput]

vtkPolyDataMapper MapperAtomsFrozen
	MapperAtomsFrozen SetInputConnection [GlyphAtomsFrozen GetOutputPort]
  	MapperAtomsFrozen SetImmediateModeRendering 1
  	MapperAtomsFrozen UseLookupTableScalarRangeOff
  	MapperAtomsFrozen SetScalarVisibility 1
  	MapperAtomsFrozen SetScalarModeToDefault

vtkLODActor ActorAtomsFrozen
  	ActorAtomsFrozen SetMapper MapperAtomsFrozen
  	[ActorAtomsFrozen GetProperty] SetRepresentationToSurface
  	[ActorAtomsFrozen GetProperty] SetInterpolationToGouraud
  	[ActorAtomsFrozen GetProperty] SetAmbient 0.15
  	[ActorAtomsFrozen GetProperty] SetDiffuse 0.85
  	[ActorAtomsFrozen GetProperty] SetSpecular 0.1
  	[ActorAtomsFrozen GetProperty] SetSpecularPower 100
  	[ActorAtomsFrozen GetProperty] SetSpecularColor 1 1 1
  	[ActorAtomsFrozen GetProperty] SetColor 1 1 1
  	ActorAtomsFrozen SetNumberOfCloudPoints 30000

		################## BONDS (FROZEN) #######################

vtkTubeFilter Tube
  	Tube SetInputConnection [frozen GetOutputPort]
  	Tube SetNumberOfSides 8
  	Tube SetCapping 0
  	Tube SetRadius 0.2
  	Tube SetVaryRadius 0
  	Tube SetRadiusFactor 10

vtkPolyDataMapper MapperBondsFrozen
  	MapperBondsFrozen SetInputConnection [Tube GetOutputPort]
  	MapperBondsFrozen SetImmediateModeRendering 1
  	MapperBondsFrozen UseLookupTableScalarRangeOff
  	MapperBondsFrozen SetScalarVisibility 1
  	MapperBondsFrozen SetScalarModeToDefault

vtkLODActor ActorBondsFrozen
  	ActorBondsFrozen SetMapper MapperBondsFrozen
  	[ActorBondsFrozen GetProperty] SetRepresentationToSurface
  	[ActorBondsFrozen GetProperty] SetInterpolationToGouraud
  	[ActorBondsFrozen GetProperty] SetAmbient 0.15
  	[ActorBondsFrozen GetProperty] SetDiffuse 0.85
  	[ActorBondsFrozen GetProperty] SetSpecular 0.1
  	[ActorBondsFrozen GetProperty] SetSpecularPower 100
  	[ActorBondsFrozen GetProperty] SetSpecularColor 1 1 1
  	[ActorBondsFrozen GetProperty] SetColor 1 1 1

############################# END FROZEN MOLECULES ####################################################

############################# RELAX MOLECULES #########################################################

#read the XYZ file with the relax molecule(s)

vtkXYZMolReader relax
        relax SetFileName "$VTK_DATA/relax0.xyz"
        #force the pipeline to execute
        relax Update

set numAtoms [relax GetNumberOfAtoms]

                ############ ATOMS (RELAX) #################

vtkGlyph3D GlyphAtomsRelax
        GlyphAtomsRelax SetInputConnection [relax GetOutputPort]
        GlyphAtomsRelax SetOrient 1
        GlyphAtomsRelax SetColorMode 1
        #GlyphAtomsRelax ScalingOn
        GlyphAtomsRelax SetScaleMode 2
        GlyphAtomsRelax SetScaleFactor .25
        GlyphAtomsRelax SetSource [Sphere GetOutput]

vtkPolyDataMapper MapperAtomsRelax
        MapperAtomsRelax SetInputConnection [GlyphAtomsRelax GetOutputPort]
        MapperAtomsRelax SetImmediateModeRendering 1
        MapperAtomsRelax UseLookupTableScalarRangeOff
        MapperAtomsRelax SetScalarVisibility 1
        MapperAtomsRelax SetScalarModeToDefault

vtkLODActor ActorAtomsRelax
        ActorAtomsRelax SetMapper MapperAtomsRelax
        [ActorAtomsRelax GetProperty] SetRepresentationToSurface
        [ActorAtomsRelax GetProperty] SetInterpolationToGouraud
        [ActorAtomsRelax GetProperty] SetAmbient 0.15
        [ActorAtomsRelax GetProperty] SetDiffuse 0.85
        [ActorAtomsRelax GetProperty] SetSpecular 0.1
        [ActorAtomsRelax GetProperty] SetSpecularPower 100
        [ActorAtomsRelax GetProperty] SetSpecularColor 1 1 1
        [ActorAtomsRelax GetProperty] SetColor 1 1 1
        ActorAtomsRelax SetNumberOfCloudPoints 30000

                ################## BONDS (RELAX) #######################

vtkTubeFilter TubeRelax
        TubeRelax SetInputConnection [relax GetOutputPort]
        TubeRelax SetNumberOfSides 8
        TubeRelax SetCapping 0
        TubeRelax SetRadius 0.2
        TubeRelax SetVaryRadius 0
        TubeRelax SetRadiusFactor 10

vtkPolyDataMapper MapperBondsRelax
        MapperBondsRelax SetInputConnection [TubeRelax GetOutputPort]
        MapperBondsRelax SetImmediateModeRendering 1
        MapperBondsRelax UseLookupTableScalarRangeOff
        MapperBondsRelax SetScalarVisibility 1
        MapperBondsRelax SetScalarModeToDefault

vtkLODActor ActorBondsRelax
        ActorBondsRelax SetMapper MapperBondsRelax
        [ActorBondsRelax GetProperty] SetRepresentationToSurface
        [ActorBondsRelax GetProperty] SetInterpolationToGouraud
        [ActorBondsRelax GetProperty] SetAmbient 0.15
        [ActorBondsRelax GetProperty] SetDiffuse 0.85
        [ActorBondsRelax GetProperty] SetSpecular 0.1
        [ActorBondsRelax GetProperty] SetSpecularPower 100
        [ActorBondsRelax GetProperty] SetSpecularColor 1 1 1
        [ActorBondsRelax GetProperty] SetColor 1 1 1

###################################### END RELAX MOLECULES ###########################################

###################################### FORCES ########################################################

set relaxPoints	[[relax GetOutput] GetPoints]

# Use Tcl to read an ascii file

set file [open "$VTK_DATA/forces0.vtk" r]

# Create the corresponding float array

#vtkFloatArray forcesArray
#	forcesArray SetName FORCES
#	forcesArray SetNumberOfComponents 3
#	forcesArray SetNumberOfTuples $numAtoms

# Read the values
#for {set i 0} {$i < $numAtoms} {incr i} {
#	set line [gets $file]
#	scan $line "%f %f %f " f(0) f(1) f(2) 
#	forcesArray InsertTuple3 $i $f(0) $f(1) $f(2)
#}


# XMT: import tensor information from VTK file as vtkPolyData

vtkPolyDataReader readerForces
        readerForces SetFileName $file
        readerForces Update

# XMT: substitute relaxed position info to placeholders contained in file
#               this is done by creating another vtkPolyData that combines pieces
#               from both imported files.

vtkPolyData forces
	#use the following IF you are using a vtkFloatArray to hold the vectors
	#forces SetPoints $relaxPoints
	#[forces GetPointData] AddArray forcesArray
	#never tried the following. it might work (instead of simply adding an array)
	#[forces GetPointData] SetVectors forcesArray
	#use the following IF you are using the vtkPolyDataReader
        forces SetPoints [[relax GetOutput] GetPoints]
        [forces GetPointData] SetVectors [[[readerForces GetOutput] GetPointData] GetVectors]

vtkArrowSource arrow
        #make sure that the resolution of the arrows is good enough
        arrow SetTipResolution 6
        arrow SetShaftResolution 6

# vtkGlyph3D takes two inputs: the input point set (SetInputConnection)
# which can be any vtkDataSet; and the glyph (SetSourceConnection) which
# must be a vtkPolyData. 

vtkGlyph3D GlyphForces
        #GlyphForces SetInputConnection  [forces GetOutputPort]
	GlyphForces SetInput forces
        GlyphForces SetSourceConnection [arrow GetOutputPort]
        #use the vector field data 
        GlyphForces SetVectorModeToUseVector
        #scale the vectors according to their magnitude (magnitude of the forces)
        #GlyphForces SetScaleModeToScaleByVector
	#do not scale the arrows according to the magnitude of the vectors
	GlyphForces SetScaleModeToDataScalingOff
	#use a color mapping scheme to show the difference in the magnitudes
	GlyphForces SetColorModeToColorByVector
        #set the scale factor 
        GlyphForces SetScaleFactor 1.5

# the color mapping scheme for the forces

vtkLookupTable lutForces
	lutForces SetHueRange 0 0
	lutForces SetSaturationRange 0 0
	lutForces SetValueRange 1. 0.2
	lutForces SetTableRange 0 0.2

#create the appropriate mapper

vtkPolyDataMapper MapperForces
        MapperForces SetInputConnection [GlyphForces GetOutputPort]
	MapperForces SetLookupTable lutForces
        #with this we set the range of the scalars the same as the range 
        eval MapperForces SetScalarRange [[readerForces GetOutput] GetScalarRange]

#create the appropriate actor

vtkActor ActorForces
    ActorForces SetMapper MapperForces

##################################### END FORCES #########################################################

##################################### HESSIAN ###########################################################

# Use Tcl to read an ascii file
# set file [open "$VTK_DATA/hessians" r]
# 
# vtkFloatArray hessiansArray
# 	hessiansArray SetNumberOfComponents 9
# 	hessiansArray SetNumberOfTuples	$numAtoms
# 
# for {set i 0} {$i < $numAtoms} {incr i} {
# 
# 	set line [gets $file]
#         scan $line "%f %f %f %f %f %f %f %f %f" h(0) h(1) h(2) h(3) h(4) h(5) h(6) h(7) h(8) 
#         #hessiansArray SetTuple9 $i h(0) h(1) h(2) h(3) h(4) h(5) h(6) h(7) h(8)
# 	puts [format "%f %f %f %f %f %f %f %f %f" $h(0) $h(1) $h(2) $h(3) $h(4) $h(5) $h(6) $h(7) $h(8)] 
# 	hessiansArray InsertNextTuple9 $h(0) $h(1) $h(2) $h(3) $h(4) $h(5) $h(6) $h(7) $h(8) 
# }

# XMT: import tensor information from VTK file as vtkPolyData

vtkPolyDataReader readerHessians
	readerHessians SetFileName $VTK_DATA/hessians0.vtk
	readerHessians Update

# XMT: substitute relaxed position info to placeholders contained in file
#		this is done by creating another vtkPolyData that combines pieces
# 		from both imported files.

vtkPolyData merge
	merge SetPoints [[relax GetOutput] GetPoints]
	[merge GetPointData] SetTensors [[[readerHessians GetOutput] GetPointData] GetTensors]

# vtkPolyData hessians
# #vtkDataSet hessians
#         hessians SetPoints $relaxPoints
#         [hessians GetPointData] SetTensors hessiansArray

# XMT: we now visualize merge instead and we tame the scaling factor

vtkTensorGlyph GlyphHessians
	#GlyphHessians SetInputConnection [hessians GetOutputPort]
	GlyphHessians SetInput merge
 	# GlyphHessians SetInput hessians
	GlyphHessians SetSourceConnection [Sphere GetOutputPort]
	GlyphHessians ExtractEigenvaluesOn
    	GlyphHessians SetScaleFactor 1
    	#GlyphHessians ClampScalingOn
  
# vtkPolyDataNormals GlyphHessiansNormals
#  	GlyphHessiansNormals SetInputConnection [GlyphHessians GetOutputPort]

vtkPolyDataMapper MapperHessians
	MapperHessians SetInputConnection [GlyphHessians GetOutputPort]

vtkActor ActorHessians
    	ActorHessians SetMapper MapperHessians
	#make the ellipsoids somewhat transparent in order to be able to show the atoms also
	[ActorHessians GetProperty] SetOpacity 0.25

##################################### END HESSIAN #######################################################

##################################### SCALAR BAR ########################################################

#show what color mapping scheme we use for the magnitude of the forces

vtkScalarBarActor ActorScalarBar
	ActorScalarBar SetLookupTable [MapperForces GetLookupTable]
	ActorScalarBar SetTitle "FORCE MAGNITUDE"
	ActorScalarBar SetOrientationToHorizontal
	ActorScalarBar SetWidth 0.8
	ActorScalarBar SetHeight 0.2
	[ActorScalarBar GetPositionCoordinate] SetCoordinateSystemToNormalizedViewport
	[ActorScalarBar GetPositionCoordinate] SetValue 0.1 0.1

##################################### END SCALAR BAR ####################################################

##################################### XY PLOT ###########################################################

#we could use this if we wanted to make an XY plot of the quantity minimized in the geometry optimization
#this is not ready yet....

#vtkXYPlotActor ActorXYPlot
#	ActorXYPlot AddInput 
#	[ActorXYPlot GetPositionCoordinate] SetValue 0. 1. 0.
#	[ActorXYPlot GetPosition2Coordinate] SetValue 0. 1. 0.
#	ActorXYPlot SetTitle "forces"
#	ActorXYPlot SetXTitle ""
#	ActorXYPlot SetYPlot ""
#	[ActorXYPlot GetProperty] SetColor 0 0 0 
#	[ActorXYPlot GetProperty] SetLineWidth 2

##################################### END XY PLOT #######################################################

##################################### SCALE #############################################################

#create the scale

frame .f
label .f.label          -text "Geometry Optimization Visualization\nAuthor: Christos Deligkaris\nPurdue University, December 2008"
label .f.label_cycle  	-text "Set Cycle of Optimization"
scale .f.scale_cycle	-from 0         -to     $nofCycles  	-orient horizontal      -command setCycle     -resolution 1 	-length 300
button .f.b_iforces	-text "Include Forces"			-command iForces
button .f.b_eforces     -text "Exclude Forces"                  -command eForces
label .f.label_forces    -text "Scaling of Forces"
scale .f.scale_forces   -from -3         -to     3      	-orient horizontal      -command scaleForces   -resolution 1     -length 200
button .f.b_ihessians	-text "Include Hessians"		-command iHessians
button .f.b_ehessians   -text "Exclude Hessians"                -command eHessians
label .f.label_hessians -text "Scaling of Hessians"
scale .f.scale_hessians -from -3         -to     3              -orient horizontal      -command scaleHessians   -resolution 1     -length 200
button .f.b_image	-text "Save Image" 	-command saveImage
button .f.b_movie	-text "Make Movie"	-command saveMovie
button .f.b_play	-text "Play Movie"	-command playMovie
button .f.quit          -text "exit"     	-command exit

# "pack"ing them is what actually places them on the screen
#the order is important, the order here determines the order of appearance on the screen 

pack .f.label .f.label_cycle .f.scale_cycle .f.b_iforces .f.b_eforces 
#pack .f.label_forces .f.scale_forces
pack .f.b_ihessians .f.b_ehessians 
#pack .f.label_hessians .f.scale_hessians 
pack .f.b_image .f.b_movie .f.b_play .f.quit
pack .f

##################################### END SCALE ############################################################

##################################### PROCEDURES ###########################################################

#procedure setCycle should change the optimization cycle being visualized

proc setCycle {value} {

	#global variables
	global VTK_DATA
	global numAtoms

	#determine which cycle we want to visualize

	#this is the indication of the scale
	set cycle [.f.scale_cycle get] 

	#if the setCycle function is called with an argument then 
	#use that instead
	if { $value != $cycle } {
		set cycle $value
     	}

	#update the positions of the atoms
	set fileName [format "%s%s%s" "relax" "$cycle" ".xyz"]
        relax SetFileName "$VTK_DATA/$fileName"
        relax Update

	#update the forces on the atoms
	
	set relaxPoints [[relax GetOutput] GetPoints]
	set fileNameForces [format "%s%s%s" "forces" "$cycle" ".vtk"]

	#clear all the field data contained in forcesArray
	#this might not be necessary
	#we are overwriting the old vtkFloatArray anyway

	#forcesArray Initialize

	# Read the values
	#for {set i 0} {$i < $numAtoms} {incr i} {
        # 	set line [gets $file]
        #	scan $line "%f %f %f " f(0) f(1) f(2)
        #	forcesArray InsertTuple3 $i $f(0) $f(1) $f(2)
	#}

	#clear everything related with the forces Poly Data set

	#forces Initialize

	#set the new points and the new field data in forces 	

        #forces SetPoints $relaxPoints
	#never tried the following (it might work)
	#[forces GetPointData] SetVectors forcesArray
	#[forces GetPointData] RemoveArray FORCES
        #[forces GetPointData] AddArray forcesArray

        readerForces SetFileName "$VTK_DATA/$fileNameForces" 
        readerForces Update

        forces SetPoints [[relax GetOutput] GetPoints]
        [forces GetPointData] SetVectors [[[readerForces GetOutput] GetPointData] GetVectors]

	#update the hessians on the atoms

	set fileNameHessians [format "%s%s%s" "hessians" "$cycle" ".vtk"]

	readerHessians SetFileName "$VTK_DATA/$fileNameHessians"
	readerHessians Update

	merge SetPoints [[relax GetOutput] GetPoints]
	[merge GetPointData] SetTensors [[[readerHessians GetOutput] GetPointData] GetTensors]

	#render the atoms in the new positions, the new forces and new hessians	
        renwin Render
}

#include the actors of the forces

proc iForces {} {

	ren AddActor ActorForces
	ren AddActor ActorScalarBar
	renwin Render
}

#exclude the actors of the forces

proc eForces {} {

        ren RemoveActor ActorForces
		ren RemoveActor ActorScalarBar
        renwin Render
}

#scale the size of the arrows (forces)

proc scaleForces {value} {

	set factor [.f.scale_forces get]
	GlyphForces SetScaleFactor $factor
}

#include the actors of the hessians

proc iHessians {} {

        ren AddActor ActorHessians
        renwin Render
}

#exclude the actors of the hessians

proc eHessians {} {

        ren RemoveActor ActorHessians
        renwin Render
}

#scale the size of the ellipsoids (hessians)

proc scaleHessians {value} {

        set factor [.f.scale_hessians get]
        GlyphHessians SetScaleFactor $factor
}

#save an image with the current frame

proc saveImage {}  {

        #determine which cycle we want to visualize
        set cycle [.f.scale_cycle get] 

	set fileName [format "%s%03d%s" "optimizationCycle" "$cycle" ".jpg"]

	imageWriter SetFileName $fileName
	imageWriter Write
}

#create a movie of the whole geometry optimization

proc saveMovie {} {

	global nofCycles
	global setCycle

	#start filming
	movieWriter Start

	#for all optimization cycles
	for {set i 0} {$i < $nofCycles} {incr i} {

        	#add the frame to the movie
        	movieWriter Write
	
                #wait for 500 milliseconds before showing the next frame
                after 500

		#set the new optimization cycle
		setCycle $i 
	}

	#terminate filming
	movieWriter End
}

#show the whole geometry optimization as a movie

proc playMovie {} {

	global nofCycles
	global setCycle
	
	#for all optimization cycles
        for {set i 0} {$i < $nofCycles} {incr i} {

		#wait for 500 milliseconds before showing the next frame
		after 500

                #set the new optimization cycle
                setCycle $i 
        }
}

##################################### END PROCEDURES ########################################################

#create the renderer

vtkRenderer ren
        #use RGB to set the color of the background to white
        ren SetBackground 1 1 1
	#add the actors for all frozen and relaxed atoms 	
	ren AddActor ActorAtomsFrozen
	ren AddActor ActorAtomsRelax
	#add the actors for all bonds between frozen and relaxed atoms
	ren AddActor ActorBondsFrozen
	ren AddActor ActorBondsRelax
	#add the actors for all forces acting on relaxed atoms
	ren AddActor ActorForces
	#add the actors for the hessians of all relaxed atoms
	ren AddActor ActorHessians
	#add the actor for the scalar bar (color coding of the forces)
	ren AddActor ActorScalarBar

#create the renderer window

vtkRenderWindow renwin
        renwin AddRenderer ren
        renwin Render
        #this creates a larger window
        renwin SetSize 512 512
	#use the off screen mode of the render window (only on Windows and Mesa compiled)
	#renwin OffScreenRenderingOn

#use the interactor

vtkRenderWindowInteractor iren
        iren SetRenderWindow renwin

#render after we have added the interactor
renwin Render

#Grab the output buffer of the render window and convert it into vtkImageData

vtkWindowToImageFilter w2i
	w2i SetInput renwin

#use the vtkImageData as input to create a movie file and several images
#note: vtkAVIWriter is only available on Windows

vtkAVIWriter movieWriter
#vtkMPEG2Writer movieWriter
	movieWriter SetInputConnection [w2i GetOutputPort]
	movieWriter SetFileName "optimization.avi"

#use the vtkRenderLargeImage filter in case you want to create images with resolution
#higher than the one supported in your screen

#vtkRenderLargeImage renLarge
#	renLarge SetInputConnection ren
#	renLarge SetMagnification 4

vtkJPEGWriter imageWriter
	imageWriter SetInputConnection [w2i GetOutputPort]
	#use the following with the vtkRenderLargeImage filter
	#imageWriter SetInput [renLarge GetOutput]

#########################################################################################################

# THE END 

########################################################################################################

