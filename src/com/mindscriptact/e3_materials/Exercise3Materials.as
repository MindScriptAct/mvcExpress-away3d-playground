package com.mindscriptact.e3_materials {
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

import flash.display.*;
import flash.events.*;
import flash.filters.*;
import flash.text.*;
import flash.ui.*;

[SWF(backgroundColor="#000000",frameRate="30",quality="LOW")]

public class Exercise3Materials extends Sprite {
	
	// metal texture 512x512
	[Embed(source="/pic/metalTexture.jpg")]
	private var MetalTextureBitmap:Class;
	
	// been texture 64x64
	[Embed(source="/pic/bakedBeens.jpg")]
	private var BeensTextureBitmap:Class;
	
	// explosio texture 32x32
	[Embed(source="/pic/explode.png")]
	private var ExplodeTextureBitmap:Class;	
	
	//engine variables
	private var view:View3D;
	private var scene:Scene3D;
	private var awayStats:AwayStats;
	
	//light objects
	private var pointLight:PointLight;
	private var lightPicker:StaticLightPicker;
	
	//material objects
	private var redColorMaterial:ColorMaterial;
	private var redColorAlphaMaterial:ColorMaterial;
	private var metalPicMaterial:TextureMaterial;
	private var metalPicMaterial2:TextureMaterial;
	
	//scene objects
	private var redCube:Mesh;
	private var redAlphaCube:Mesh
	private var metalCube:Mesh;
	private var metalCube2:Mesh;
	
	/**
	 * Constructor
	 */
	public function Exercise3Materials() {
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
		var hoverCameraManager:HoverCameraManager = new HoverCameraManager(view, 500, [pointLight]);
	}
	
	/**
	 * Initialise the materials
	 */
	private function initMaterials():void {
		
		// MaterialBase
		{
			
			// DefaultMaterialBase - DefaultMaterialBase forms an abstract base class for the default materials provided by Away3D and use methods to define their appearance.
			{
				//ColorMaterial	 		ColorMaterial is a material that uses a flat colour as the surfaces diffuse.
				// red color
				redColorMaterial = new ColorMaterial(0xFF0000);
				redColorMaterial.lightPicker = lightPicker;
				
				// red color with alpha
				redColorAlphaMaterial = new ColorMaterial(0xFF0000, 0.5);
				redColorAlphaMaterial.lightPicker = lightPicker;
			
				//BitmapMaterial	 	BitmapMaterial is a material that uses a BitmapData texture as the surface's diffuse colour.
				// DEPRECATED !!!
			
				//TextureMaterial	 	TextureMaterial is a material that uses a texture as the surface's diffuse colour.
				//metalPicMaterial = new TextureMaterial(new MetalTextureBitmap().bitmapData);
				
				//var bd:BitmapData = new ExplodeTextureBitmap().bitmapData;
				
				metalPicMaterial = new TextureMaterial( new BitmapTexture(new BeensTextureBitmap().bitmapData), false)
				metalPicMaterial.lightPicker = lightPicker;
				
				metalPicMaterial2 = new TextureMaterial( new BitmapTexture(new BeensTextureBitmap().bitmapData), true)
				metalPicMaterial2.lightPicker = lightPicker;
				//TODO : how to get png TRANSPARANCY?
				//TODO : repeat in constructor ??
				//TODO : mipmap in constructor ??
				
			}
		}
		
		//TODO:
		
		//SkyBoxMaterial	 	SkyBoxMaterial is a material exclusively used to render skyboxes\
		//DefaultMaterialBase	DefaultMaterialBase forms an abstract base class for the default materials provided by Away3D and use methods to define their appearance.
		//LightSources	 
		//MaterialBase	 		MaterialBase forms an abstract base class for any material.
		//SegmentMaterial	 	SegmentMaterial is a material exclusively used to render wireframe object
		//VideoMaterial
	
	}
	
	/**
	 * Initialise the scene objects
	 */
	private function initObjects():void {
		// simle cube
		var newCubeGeometry:CubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		redCube = new Mesh(newCubeGeometry, redColorMaterial);
		redCube.x = -75;
		scene.addChild(redCube);
		
		redAlphaCube = new Mesh(newCubeGeometry, redColorAlphaMaterial);
		redAlphaCube.x = 75;
		scene.addChild(redAlphaCube);
		
		metalCube = new Mesh(newCubeGeometry, metalPicMaterial);
		metalCube.x = -75;
		metalCube.y = 150;
		scene.addChild(metalCube);
		
		metalCube2 = new Mesh(newCubeGeometry, metalPicMaterial2);
		metalCube2.x = 75;
		metalCube2.y = 150;
		scene.addChild(metalCube2);		
		
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
