/**
 * Created by Anton Nefjodov on 15.03.2016.
 */
package com.domwires.extensions.physics
{
	import com.domwires.core.common.AbstractDisposable;
	import com.domwires.core.factory.IAppFactory;
	import com.domwires.core.factory.IAppFactoryImmutable;
	import com.domwires.core.mvc.model.AbstractModel;
	import com.domwires.extensions.physics.vo.units.JointDataVo;

	import nape.constraint.AngleJoint;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;

	public class JointObject extends AbstractModel implements IJointObject
	{
		[Autowired]
		public var factory:IAppFactoryImmutable;

		private var _data:JointDataVo;

		private var _angleJoint:AngleJoint;
		private var _pivotJoint:PivotJoint;

		public function JointObject(data:JointDataVo)
		{
			super();

			_data = data;
		}

		public function get data():JointDataVo
		{
			return _data;
		}

		public function connect(body_1:Body, body_2:Body):void
		{
			var anchor_1:Vec2 = body_1.worldPointToLocal(new Vec2(_data.x, _data.y), true);
			var anchor_2:Vec2 = body_2.worldPointToLocal(new Vec2(_data.x, _data.y), true);
			_pivotJoint = new PivotJoint(body_1, body_2, anchor_1, anchor_2);
			_pivotJoint.ignore = true;
			//_pivotJoint.stiff = false;
			_pivotJoint.userData.dataObject = this;

			if (!isNaN(_data.minAngle) && !isNaN(_data.maxAngle))
			{
				_angleJoint = new AngleJoint(body_1, body_2, _data.minAngle, _data.maxAngle, 1);
				_angleJoint.stiff = false;
				_angleJoint.userData.dataObject = this;
			}
		}

		public function get pivotJoint():PivotJoint
		{
			return _pivotJoint;
		}

		public function get angleJoint():AngleJoint
		{
			return _angleJoint;
		}

		override public function dispose():void
		{
			_angleJoint = null;
			_pivotJoint = null;
			_data = null;
			factory = null;

			super.dispose();
		}

		public function clone():IJointObject
		{
			var c:IJointObject = factory.getInstance(IJointObject, _data);
			return c;
		}
	}
}
