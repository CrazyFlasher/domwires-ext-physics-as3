/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.domwires.extensions.physics
{
	import com.domwires.core.common.IDisposable;
	import com.domwires.extensions.physics.vo.units.WorldDataVo;

	import nape.space.Space;

	WorldObject;
	public interface IWorldObject extends IDisposable
	{
		function get data():WorldDataVo;
		function get bodyObjectList():Vector.<IBodyObject>;
		function get jointObjectList():Vector.<IJointObject>;
		function bodyObjectById(id:String):IBodyObject;
		function jointObjectById(id:String):IJointObject;
		function get space():Space;
		function clone():IWorldObject;

//		function addBodyObject(value:IBodyObject):IWorldObject;
//		function removeBodyObject(value:IBodyObject):IWorldObject;
//		function addJointObject(value:IJointObject):IWorldObject;
//		function removeJointObject(value:IJointObject):IWorldObject;
	}
}
