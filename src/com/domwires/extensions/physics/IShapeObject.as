/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.domwires.extensions.physics
{
	import com.domwires.core.common.IDisposable;
	import com.domwires.extensions.physics.vo.units.ShapeDataVo;

	import nape.shape.Shape;

	ShapeObject;
	public interface IShapeObject extends IDisposable
	{
		function get vertexObjectList():Vector.<IVertexObject>;
		function get data():ShapeDataVo;
		function get shapes():Vector.<Shape>;
		function clone():IShapeObject;

//		function addVertexObject(value:IVertexObject):IShapeObject;
//		function removeVertexObject(value:IVertexObject):IShapeObject;
	}
}
