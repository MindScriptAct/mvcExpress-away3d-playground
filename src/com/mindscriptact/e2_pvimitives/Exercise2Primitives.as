package com.mindscriptact.e2_pvimitives {
import away3d.cameras.*;
import away3d.containers.*;
import away3d.controllers.*;
import away3d.debug.*;
import away3d.entities.Mesh;
import away3d.extrusions.*;
import away3d.filters.*;
import away3d.lights.*;
import away3d.materials.*;
import away3d.materials.lightpickers.*;
import away3d.materials.methods.*;
import away3d.primitives.*;
import away3d.textures.*;
import com.mindscriptact.utils.away3d.camera.HoverCameraManager;
import flash.geom.Vector3D;

import flash.display.*;
import flash.events.*;
import flash.filters.*;
import flash.text.*;
import flash.ui.*;

[SWF(backgroundColor="#000000",frameRate="30",quality="LOW")]

public class Exercise2Primitives extends Sprite {
	
	//engine variables
	private var view:View3D;
	private var scene:Scene3D;
	private var awayStats:AwayStats;
	
	//light objects
	private var pointLight:PointLight;
	private var lightPicker:StaticLightPicker;
	
	//material objects
	private var redColorMaterial:ColorMaterial;
	
	//scene objects
	
	/**
	 * Constructor
	 */
	public function Exercise2Primitives() {
		init();
	}
	
	/**
	 * Global initialise function
	 */
	private function init():void {
		initEngine();
		initLights();
		initCamera();
		
		initMaterials();
		initObjects();
		
		initListeners();
	}
	
	/**
	 * Initialise the engine
	 */
	private function initEngine():void {
		//stage setup
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		// 3d view - window into 3d scene
		view = new View3D();
		addChild(view);
		
		// 3d scene.
		scene = view.scene;
		
		// stats
		awayStats = new AwayStats(view);
		addChild(awayStats);
	}
	
	/**
	 * Initialise the lights
	 */
	private function initLights():void {
		//point light
		pointLight = new PointLight();
		scene.addChild(pointLight);
		lightPicker = new StaticLightPicker([pointLight]);
	}
	
	private function initCamera():void {
		var hoverCameraManager:HoverCameraManager = new HoverCameraManager(view, 700, [pointLight]);
	}
	
	/**
	 * Initialise the materials
	 */
	private function initMaterials():void {
		// red color
		redColorMaterial = new ColorMaterial(0xFF0000, 0.8);
		redColorMaterial.lightPicker = lightPicker;
	}
	
	/**
	 * Initialise the scene objects
	 */
	private function initObjects():void {
		
		//Geometry -> 
		////PrimitiveBase	- PrimitiveBase is an abstract base class for mesh primitives, which are prebuilt simple meshes.
		{
			//CubeGeometry	 A Cube primitive mesh.
			var newCubeGeometry:CubeGeometry = new CubeGeometry();
			
			//SphereGeometry - A UV Sphere primitive mesh.
			var newSphereGeometry:SphereGeometry = new SphereGeometry(50);
			
			//CapsuleGeometry	 A UV Capsule primitive mesh.
			var newCapsuleGeometry:CapsuleGeometry = new CapsuleGeometry();
			
			//ConeGeometry	 A UV Cone primitive mesh.
			var newConeGeometry:ConeGeometry = new ConeGeometry();
			
			//CylinderGeometry	 A UV Cylinder primitive mesh.
			var newCylinderGeometry:CylinderGeometry = new CylinderGeometry();
			
			//PlaneGeometry	 A Plane primitive mesh.
			var newPlaneGeometry:PlaneGeometry = new PlaneGeometry();
			
			//RegularPolygonGeometry	 A UV RegularPolygon primitive mesh.
			var newRegularPoligonGeometry:RegularPolygonGeometry = new RegularPolygonGeometry();
			
		}
		
		//Entity
		{
			// SegmentSet
			{
				//WireframeAxesGrid - Class WireframeAxesGrid generates a grid of lines on a given planeWireframeAxesGrid
				
				var wireFrameAxesGrid:WireframeAxesGrid = new WireframeAxesGrid(4, 400, 1);
				scene.addChild(wireFrameAxesGrid);
				
				//WireframePrimitiveBase 
				{
					//WireframeCube	- Class WireFrameGrid generates a grid of lines on a given planeWireFrameGrid
					var wireFrameCube:WireframeCube = new WireframeCube(100, 100, 100, 0x0000FF, 5);
					wireFrameCube.x = 75;
					scene.addChild(wireFrameCube);
					
					//WireframeSphere - Class WireFrameGrid generates a grid of lines on a given planeWireFrameGrid
					var wireFrameSphere:WireframeSphere = new WireframeSphere(50, 16, 12, 0x0000FF, 5);
					wireFrameSphere.x = 75;
					wireFrameSphere.y = -150;
					scene.addChild(wireFrameSphere);
					
					//WireframeGrid	 Class WireframeGrid generates a grid of lines on a given planeWireframeGrid
					var wireframeGrid:WireframeGrid = new WireframeGrid(10, 100, 5, 0x0000FF);
					wireframeGrid.x = 75;
					wireframeGrid.y = 275;
					scene.addChild(wireframeGrid);
					
					//WireframePlane
					var wireframePlane:WireframePlane = new  WireframePlane(100, 100, 10, 10, 0x0000FF, 5);
					wireframePlane.x = 175;
					wireframePlane.y = 275;
					scene.addChild(wireframePlane);
					
					
					
					
				}
			}
			

				
			//Mesh - Mesh is an instance of a Geometry, augmenting it with a presence in the scene graph, a material, and an animation
			
			var cube:Mesh = new Mesh(newCubeGeometry, redColorMaterial);
			cube.x = -75;
			scene.addChild(cube);
			
			var sphere:Mesh = new Mesh(newSphereGeometry, redColorMaterial);
			sphere.x = -75;
			sphere.y = -150;
			scene.addChild(sphere);
			
			var capsule:Mesh = new Mesh(newCapsuleGeometry, redColorMaterial);
			capsule.x = -200;
			capsule.y = -150
			scene.addChild(capsule);
			
			var cone:Mesh = new Mesh(newConeGeometry, redColorMaterial);
			cone.x = -200;
			cone.y = 150;
			scene.addChild(cone);
			
			var cylinder:Mesh = new Mesh(newCylinderGeometry, redColorMaterial);
			cylinder.x = -75;
			cylinder.y = 150;
			scene.addChild(cylinder);
			
			var plane:Mesh = new Mesh(newPlaneGeometry, redColorMaterial);
			plane.x = -75;
			plane.y = 275;
			scene.addChild(plane);
			
			var poligon:Mesh = new Mesh(newRegularPoligonGeometry, redColorMaterial);
			poligon.x = -275;
			poligon.y = 275;
			scene.addChild(poligon);			
		
		}
	
		
		// TODO :
		//LineSegment
		//SkyBox	 A SkyBox class is used to render a sky in the scene.
			  
	
	}
	
	/**
	 * Initialise the listeners
	 */
	private function initListeners():void {
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	/**
	 * render loop
	 */
	private function onEnterFrame(event:Event):void {
		view.render();
	}

}
}
