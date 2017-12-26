/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.domwires.extensions.physics
{
	import com.domwires.core.mvc.model.IModel;
	import com.domwires.extensions.physics.vo.units.VertexDataVo;

	import nape.geom.Vec2;

	VertexObject;
	public interface IVertexObject extends IModel
	{
		function get x():Number;
		function get y():Number;
		function get data():VertexDataVo;
		function get vertex():Vec2;
		function clone():IVertexObject;
	}
}
