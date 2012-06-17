package com.mindscriptact.utils.away3d.camera {
import away3d.cameras.Camera3D;
import away3d.containers.View3D;
import away3d.controllers.HoverController;
import away3d.core.base.Object3D;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;

/**
 * COMMENT
 * @author Raimundas Banevicius (raima156@yahoo.com)
 */
public class HoverCameraManager {
	private var view:View3D;
	private var distance:int;
	private var folowers:Vector.<Object3D> = new Vector.<Object3D>();
	private var camera:Camera3D;
	private var cameraController:HoverController;
	private var stage:Stage;
	
	//navigation variables
	private var tiltSpeed:Number = 2;
	private var panSpeed:Number = 2;
	private var distanceSpeed:Number = 2;
	private var tiltIncrement:Number = 0;
	private var panIncrement:Number = 0;
	private var distanceIncrement:Number = 0;
	//
	// navigation state
	private var move:Boolean;
	private var lastPanAngle:int;
	private var lastTiltAngle:int;
	private var lastMouseX:int;
	private var lastMouseY:int;
	
	public function HoverCameraManager(view:View3D, distance:int, cameraFolowers:Array = null) {
		this.view = view;
		this.distance = distance;
		if (cameraFolowers) {
			for (var i:int = 0; i < cameraFolowers.length; i++) {
				if (cameraFolowers[i] is Object3D) {
					folowers.push(cameraFolowers[i]);
				} else {
					throw Error("Please add only Object3D subclasses as cameraFolowers for HoverCameraManager");
				}
			}
		}
		init();
		initEvents();
	}
	
	private function init():void {
		camera = view.camera;
		
		//setup controller to be used on the camera
		cameraController = new HoverController(camera, null, 30, 20, distance);
	
	}
	
	private function initEvents():void {
		view.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		view.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		//stage.addEventListener(Event.RESIZE, onResize);
		
		stage = this.view.stage;
		if (stage) {
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		} else {
			throw Error("Failed to get stage. Please add view3d to stage before using HoverCameraManager.");
		}
	}
	
	private function onMouseDown(event:MouseEvent):void {
		move = true;
		lastPanAngle = cameraController.panAngle;
		lastTiltAngle = cameraController.tiltAngle;
		lastMouseX = stage.mouseX;
		lastMouseY = stage.mouseY;
		stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}
	
	/**
	 * Mouse up listener for navigation
	 */
	private function onMouseUp(event:MouseEvent):void {
		move = false;
		stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}
	
	/**
	 * Mouse stage leave listener for navigation
	 */
	private function onStageMouseLeave(event:Event):void {
		move = false;
		stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
	}
	
	/**
	 * Key down listener for camera control
	 */
	private function onKeyDown(event:KeyboardEvent):void {
		switch (event.keyCode) {
			case Keyboard.UP: 
			case Keyboard.W: 
			case Keyboard.COMMA: // for dworak keiboard
				tiltIncrement = tiltSpeed;
				break;
			case Keyboard.DOWN: 
			case Keyboard.S: 
			case Keyboard.O: // for dworak keiboard
				tiltIncrement = -tiltSpeed;
				break;
			case Keyboard.LEFT: 
			case Keyboard.A: 
				panIncrement = panSpeed;
				break;
			case Keyboard.RIGHT: 
			case Keyboard.D: 
			case Keyboard.E: // for dworak keiboard
				panIncrement = -panSpeed;
				break;
			case Keyboard.Z: 
			case Keyboard.SEMICOLON: // for dworak keiboard
				distanceIncrement = distanceSpeed;
				break;
			case Keyboard.X: 
			case Keyboard.Q: // for dworak keiboard
				distanceIncrement = -distanceSpeed;
				break;
		}
	}
	
	/**
	 * Key up listener for camera control
	 */
	private function onKeyUp(event:KeyboardEvent):void {
		switch (event.keyCode) {
			case Keyboard.UP: 
			case Keyboard.W: 
			case Keyboard.DOWN: 
			case Keyboard.S: 
			case Keyboard.COMMA: // for dworak keiboard
			case Keyboard.O: // for dworak keiboard
				tiltIncrement = 0;
				break;
			case Keyboard.LEFT: 
			case Keyboard.A: 
			case Keyboard.RIGHT: 
			case Keyboard.D: 
			case Keyboard.E: // for dworak keiboard
				panIncrement = 0;
				break;
			case Keyboard.Z: 
			case Keyboard.X: 
			case Keyboard.SEMICOLON: // for dworak keiboard
			case Keyboard.Q: // for dworak keiboard
				distanceIncrement = 0;
				break;
		}
	}
	
	/**
	 * Navigation and render loop
	 */
	private function onEnterFrame(event:Event):void {
		if (move) {
			cameraController.panAngle = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
			cameraController.tiltAngle = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;
		}
		
		cameraController.panAngle += panIncrement;
		cameraController.tiltAngle += tiltIncrement;
		cameraController.distance += distanceIncrement;
		
		for (var i:int = 0; i < folowers.length; i++) {
			folowers[i].position = camera.position;
		}
	}
}
}