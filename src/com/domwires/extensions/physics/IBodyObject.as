/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.domwires.extensions.physics
{
	import com.domwires.core.common.IDisposable;
	import com.domwires.extensions.physics.vo.units.BodyDataVo;

	import nape.phys.Body;

	BodyObject;
	public interface IBodyObject extends IDisposable
	{
		function get shapeObjectList():Vector.<IShapeObject>;
		function get data():BodyDataVo;
		function get body():Body;
		function shapeObjectById(id:String):IShapeObject;
		function clone():IBodyObject;

//		function addShapeObject(value:IShapeObject):IBodyObject;
//		function removeShapeObject(value:IShapeObject):IBodyObject;
	}
}
