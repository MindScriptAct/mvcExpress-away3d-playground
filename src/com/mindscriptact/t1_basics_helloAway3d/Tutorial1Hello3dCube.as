package com.mindscriptact.t1_basics_helloAway3d {
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
import away3dplus.controllers.SimpleHoverController;

import flash.display.*;
import flash.events.*;
import flash.filters.*;
import flash.text.*;
import flash.ui.*;

[SWF(backgroundColor="#000000",frameRate="30",quality="LOW")]

public class Tutorial1Hello3dCube extends Sprite {
	
	//engine variables
	private var view:View3D;
	private var scene:Scene3D;
	
	// debug
	private var awayStats:AwayStats;
	
	//light objects
	private var pointLight:PointLight;
	private var lightPicker:StaticLightPicker;
	
	//material objects
	private var redColorMaterial:ColorMaterial;
	
	//scene objects
	private var cube:Mesh;
	
	/** Constructor */
	public function Tutorial1Hello3dCube() {
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
		var hoverCameraManager:SimpleHoverController = new SimpleHoverController(view, 500, [pointLight]);
	}
	
	/**
	 * Initialise the materials
	 */
	private function initMaterials():void {
		// red color
		redColorMaterial = new ColorMaterial(0xFF0000);
		redColorMaterial.lightPicker = lightPicker;
	}
	
	/**
	 * Initialise the scene objects
	 */
	private function initObjects():void {
		// simle cube
		var newCubeGeometry:CubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		cube = new Mesh(newCubeGeometry, redColorMaterial);
		scene.addChild(cube);
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
