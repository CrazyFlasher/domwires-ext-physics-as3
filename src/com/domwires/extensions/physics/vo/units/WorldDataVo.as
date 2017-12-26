/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.domwires.extensions.physics.vo.units
{
	import com.domwires.extensions.physics.vo.GravityVo;

	public class WorldDataVo extends PhysicsUnitDataVo
	{
		private var _gravity:GravityVo = new GravityVo();

		private var _bodyDataList:Vector.<BodyDataVo>;
		private var _jointDataList:Vector.<JointDataVo>;

		public function WorldDataVo(json:Object)
		{
			super(json);
		}

		[PostConstruct]
		public function init():void
		{
			var bodies:Vector.<BodyDataVo> = new <BodyDataVo>[];
			for each (var bodyJson:Object in json.bodies)
			{
				var bodyData:BodyDataVo = factory.getInstance(BodyDataVo, bodyJson);
				bodies.push(bodyData);
			}

			var joints:Vector.<JointDataVo> = new <JointDataVo>[];
			for each (var jointJson:Object in json.joints)
			{
				var jointData:JointDataVo = factory.getInstance(JointDataVo, jointJson);
				joints.push(jointData);
			}

			_bodyDataList = bodies;
			_jointDataList = joints;
			_gravity = factory.getInstance(GravityVo, [json.gravity.x, json.gravity.y]);
		}

		public function get bodyDataList():Vector.<BodyDataVo>
		{
			return _bodyDataList;
		}

		public function get gravity():GravityVo
		{
			return _gravity;
		}

		public function get jointDataList():Vector.<JointDataVo>
		{
			return _jointDataList;
		}
	}
}
