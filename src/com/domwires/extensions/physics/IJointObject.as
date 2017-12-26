/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.domwires.extensions.physics
{
	import com.domwires.core.mvc.model.IModel;
	import com.domwires.extensions.physics.vo.units.JointDataVo;

	import nape.constraint.AngleJoint;
	import nape.constraint.PivotJoint;
	import nape.phys.Body;

	JointObject;
	public interface IJointObject extends IModel
	{
		function get data():JointDataVo;
		function get pivotJoint():PivotJoint;
		function get angleJoint():AngleJoint;
		function connect(body_1:Body, body_2:Body):void;
		function clone():IJointObject;
	}
}
