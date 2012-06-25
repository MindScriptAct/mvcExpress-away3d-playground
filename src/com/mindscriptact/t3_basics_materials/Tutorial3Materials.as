package com.mindscriptact.t3_basics_materials {
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

public class Tutorial3Materials extends Sprite {
	
	// metal texture 512x512
	[Embed(source="/pic/metalTexture.jpg")]
	private var MetalTextureBitmap:Class;
	
	// explosio texture 32x32
	[Embed(source="/pic/explode.png")]
	private var ExplodeTextureBitmap:Class;
	
	// Environment map.
	[Embed(source="/skybox/snow_positive_x.jpg")]
	private var EnvPosX:Class;
	[Embed(source="/skybox/snow_positive_y.jpg")]
	private var EnvPosY:Class;
	[Embed(source="/skybox/snow_positive_z.jpg")]
	private var EnvPosZ:Class;
	[Embed(source="/skybox/snow_negative_x.jpg")]
	private var EnvNegX:Class;
	[Embed(source="/skybox/snow_negative_y.jpg")]
	private var EnvNegY:Class;
	[Embed(source="/skybox/snow_negative_z.jpg")]
	private var EnvNegZ:Class;
	
	//engine variables
	private var view:View3D;
	private var scene:Scene3D;
	//debug
	private var awayStats:AwayStats;
	
	//light objects
	private var pointLight:PointLight;
	private var lightPicker:StaticLightPicker;
	
	//material objects
	
	//scene objects
	
	/** Constructor */
	public function Tutorial3Materials() {
		init();
	}
	
	/**
	 * Global initialise function
	 */
	private function init():void {
		initEngine();
		initLights();
		initCamera();
		
		initMaterialsAndObjects();
		
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
	 * Initialise the materials and objects
	 */
	private function initMaterialsAndObjects():void {
		
		//TODO:
		
		//SkyBoxMaterial	 	SkyBoxMaterial is a material exclusively used to render skyboxes\
		//DefaultMaterialBase	DefaultMaterialBase forms an abstract base class for the default materials provided by Away3D and use methods to define their appearance.
		//LightSources	 
		//MaterialBase	 		MaterialBase forms an abstract base class for any material.
		//SegmentMaterial	 	SegmentMaterial is a material exclusively used to render wireframe object
		//VideoMaterial
		
		//TODO : repeat in constructor ??
		//TODO : mipmap in constructor ??
		
		//----------------------------------
		//     debug trident
		//----------------------------------
		var trident:Trident = new Trident(500);
		scene.addChild(trident);
		
		//----------------------------------
		//     sky Box texture
		//----------------------------------
		// cube texture
		var skyBoxCubeTexture:BitmapCubeTexture = new BitmapCubeTexture(new EnvPosX().bitmapData, new EnvNegX().bitmapData, new EnvPosY().bitmapData, new EnvNegY().bitmapData, new EnvPosZ().bitmapData, new EnvNegZ().bitmapData);
		//SkyBox	 A SkyBox class is used to render a sky in the scene.
		var skyBox:SkyBox = new SkyBox(skyBoxCubeTexture);
		scene.addChild(skyBox);
		
		//*
		//----------------------------------
		//   Red cube  
		//----------------------------------
		//ColorMaterial	 		ColorMaterial is a material that uses a flat colour as the surfaces diffuse.
		// red color
		var redColorMaterial:ColorMaterial = new ColorMaterial(0xFF0000);
		redColorMaterial.lightPicker = lightPicker;
		// geomatry
		var newCubeGeometry:CubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh
		var redCube:Mesh = new Mesh(newCubeGeometry, redColorMaterial);
		redCube.x = 75;
		scene.addChild(redCube);
		//*/
		
		//*
		//----------------------------------
		//    Red transparent cube 
		//----------------------------------
		// red color with alpha
		var redColorAlphaMaterial:ColorMaterial = new ColorMaterial(0xFF0000, 0.5);
		redColorAlphaMaterial.lightPicker = lightPicker;
		// geomatry
		newCubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh
		var redAlphaCube:Mesh = new Mesh(newCubeGeometry, redColorAlphaMaterial);
		redAlphaCube.x = -75;
		scene.addChild(redAlphaCube);
		//*/
		
		//*
		//----------------------------------
		//    jpg picture
		//----------------------------------
		//BitmapMaterial
		metalTexture = new BitmapTexture(new MetalTextureBitmap().bitmapData);
		//TextureMaterial
		var metalPicMaterialSmooth:TextureMaterial = new TextureMaterial(metalTexture)
		metalPicMaterialSmooth.lightPicker = lightPicker;
		// geomatry
		newCubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh		
		var metalCubeSmooth:Mesh = new Mesh(newCubeGeometry, metalPicMaterialSmooth);
		metalCubeSmooth.x = 75;
		metalCubeSmooth.y = 150;
		scene.addChild(metalCubeSmooth);
		//*/
		
		//*
		//----------------------------------
		//    jpg picture without smooth
		//----------------------------------
		//BitmapMaterial
		var metalTexture:BitmapTexture = new BitmapTexture(new MetalTextureBitmap().bitmapData);
		//TextureMaterial		
		var metalPicMaterialPixelated:TextureMaterial = new TextureMaterial(metalTexture, false)
		metalPicMaterialPixelated.lightPicker = lightPicker;
		// geomatry
		newCubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh		
		var metalCubePixelated:Mesh = new Mesh(newCubeGeometry, metalPicMaterialPixelated);
		metalCubePixelated.x = -75;
		metalCubePixelated.y = 150;
		scene.addChild(metalCubePixelated);
		//*/
		
		//*
		//----------------------------------
		//    jpg picture with transparency
		//----------------------------------
		//BitmapMaterial
		metalTexture = new BitmapTexture(new MetalTextureBitmap().bitmapData);
		//TextureMaterial
		var metalPicMaterialAlpha:TextureMaterial = new TextureMaterial(metalTexture)
		metalPicMaterialAlpha.lightPicker = lightPicker;
		metalPicMaterialAlpha.alpha = 0.7;
		// geomatry
		newCubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh		
		var metalCubeAlpha:Mesh = new Mesh(newCubeGeometry, metalPicMaterialAlpha);
		metalCubeAlpha.x = -205;
		metalCubeAlpha.y = 150;
		scene.addChild(metalCubeAlpha);
		//*/
		
		//*
		//----------------------------------
		//   png picture  
		//----------------------------------
		//BitmapMaterial
		var explodeTexture:BitmapTexture = new BitmapTexture(new ExplodeTextureBitmap().bitmapData);
		//TextureMaterial		
		var explodeMaterialNoAlphaBlending:TextureMaterial = new TextureMaterial(explodeTexture);
		explodeMaterialNoAlphaBlending.lightPicker = lightPicker;
		// geomatry
		newCubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh
		var explosionCubeNoAlpha:Mesh = new Mesh(newCubeGeometry, explodeMaterialNoAlphaBlending);
		explosionCubeNoAlpha.x = 200;
		explosionCubeNoAlpha.y = -150;
		scene.addChild(explosionCubeNoAlpha);
		//*/
		
		//*
		//----------------------------------
		//     png picture with alphaBlending
		//----------------------------------
		//BitmapMaterial
		explodeTexture = new BitmapTexture(new ExplodeTextureBitmap().bitmapData);
		//TextureMaterial		
		var explodeMaterialSmooth:TextureMaterial = new TextureMaterial(explodeTexture);
		explodeMaterialSmooth.lightPicker = lightPicker;
		explodeMaterialSmooth.alphaBlending = true;
		// geomatry
		newCubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh		
		var explosionCubeSmooth:Mesh = new Mesh(newCubeGeometry, explodeMaterialSmooth);
		explosionCubeSmooth.x = 75;
		explosionCubeSmooth.y = -150;
		scene.addChild(explosionCubeSmooth);
		//*/
		
		//*
		//----------------------------------
		//   png picture with alphaThreshold  
		//----------------------------------
		//BitmapMaterial
		explodeTexture = new BitmapTexture(new ExplodeTextureBitmap().bitmapData);
		//TextureMaterial	
		var explodeMaterialWithAlphaThreshhold:TextureMaterial = new TextureMaterial(explodeTexture);
		explodeMaterialWithAlphaThreshhold.lightPicker = lightPicker;
		explodeMaterialWithAlphaThreshhold.alphaThreshold = 0.9;
		// geomatry
		newCubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh		
		var explosionCubeWithAlphaTroshhold:Mesh = new Mesh(newCubeGeometry, explodeMaterialWithAlphaThreshhold);
		explosionCubeWithAlphaTroshhold.x = -75;
		explosionCubeWithAlphaTroshhold.y = -150;
		scene.addChild(explosionCubeWithAlphaTroshhold);
		//*/
		
		//*
		//----------------------------------
		//     png picture without smooth (with alphaThreshold)
		//----------------------------------
		//BitmapMaterial
		explodeTexture = new BitmapTexture(new ExplodeTextureBitmap().bitmapData);
		//TextureMaterial	
		var explodeMaterialPixelated:TextureMaterial = new TextureMaterial(explodeTexture, false);
		explodeMaterialPixelated.lightPicker = lightPicker;
		explodeMaterialPixelated.alphaThreshold = 0.9;
		// geomatry
		newCubeGeometry = new CubeGeometry(100, 100, 100, 10, 10, 10, false);
		// mesh		
		var explosionCube:Mesh = new Mesh(newCubeGeometry, explodeMaterialPixelated);
		explosionCube.x = -200;
		explosionCube.y = -150;
		scene.addChild(explosionCube);
		//*/
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
