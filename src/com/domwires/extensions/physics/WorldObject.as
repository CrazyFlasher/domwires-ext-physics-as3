/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.domwires.extensions.physics
{
	import com.domwires.core.factory.IAppFactoryImmutable;
	import com.domwires.core.mvc.model.IModel;
	import com.domwires.core.mvc.model.IModelContainer;
	import com.domwires.core.mvc.model.ModelContainer;
	import com.domwires.extensions.physics.vo.units.BodyDataVo;
	import com.domwires.extensions.physics.vo.units.JointDataVo;
	import com.domwires.extensions.physics.vo.units.WorldDataVo;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyList;
	import nape.space.Space;

	public class WorldObject extends ModelContainer implements IWorldObject
	{
		[Autowired]
		public var factory:IAppFactoryImmutable;

		private var _space:Space;

		private var _data:WorldDataVo;

		private var _bodyObjectList:Vector.<IBodyObject>;
		private var _jointObjectList:Vector.<IJointObject>;

		public function WorldObject(data:WorldDataVo)
		{
			super();

			_data = data;
		}

		[PostConstruct]
		public function init():void
		{
			_space = new Space(new Vec2(_data.gravity.x, _data.gravity.y));

			_bodyObjectList = new <IBodyObject>[];

			var bodyObject:IBodyObject;
			for each (var bodyData:BodyDataVo in _data.bodyDataList)
			{
				bodyObject = factory.getInstance(IBodyObject, bodyData);

				addBodyObject(bodyObject);
			}

			_jointObjectList = new <IJointObject>[];

			var jointObject:IJointObject;
			var bodiesToConnect:Vector.<Body>;
			for each (var jointData:JointDataVo in _data.jointDataList)
			{
				jointObject = factory.getInstance(IJointObject, jointData);

				bodiesToConnect = getBodiesToConnect(jointObject.data);

				if(bodiesToConnect.length > 1)
				{
					jointObject.connect(bodiesToConnect[0], bodiesToConnect[1]);

					_space.constraints.add(jointObject.pivotJoint);

					if (jointObject.angleJoint != null)
					{
						_space.constraints.add(jointObject.angleJoint);
					}

					_jointObjectList.push(jointObject);

					addModel(jointObject);
				}
			}

			_space.userData.dataObject = this;
		}

		public function addBodyObject(bodyObject:IBodyObject):IWorldObject
		{
			addModel(bodyObject);

			_bodyObjectList.push(bodyObject);

			_space.bodies.add(bodyObject.body);

			return this;
		}

		public function removeBodyObject(bodyObject:IBodyObject):IWorldObject
		{
			removeModel(bodyObject);

			_bodyObjectList.removeAt(_bodyObjectList.indexOf(bodyObject));

			_space.bodies.remove(bodyObject.body);

			return this;
		}

		private function getBodiesToConnect(data:JointDataVo):Vector.<Body>
		{
			var bodiesToConnect:Vector.<Body> = new <Body>[];

			if (data.bodyToConnectIdList && data.bodyToConnectIdList.length > 0)
			{
				for each (var bodyId:String in data.bodyToConnectIdList)
				{
					if (bodyId == "$world")
					{
						bodiesToConnect.push(_space.world);
					}else
					{
						for each (var bodyObject:IBodyObject in _bodyObjectList)
						{
							if (bodyObject.data.id == bodyId)
							{
								bodiesToConnect.push(bodyObject.body);
							}
						}
					}
				}
			}else
			{
				var bodiesUnderJoint:BodyList = getBodiesUnderJoint(data.x, data.y);
				for (var i:int = 0; i < bodiesUnderJoint.length; i++)
				{
					bodiesToConnect.push(bodiesUnderJoint.at(i));
				}
			}

			return bodiesToConnect;
		}

		private function getBodiesUnderJoint(jointX:Number, jointY:Number):BodyList
		{
			return space.bodiesUnderPoint(new Vec2(jointX, jointY));
		}

		public function get data():WorldDataVo
		{
			return _data;
		}

		public function get bodyObjectList():Vector.<IBodyObject>
		{
			return _bodyObjectList;
		}

		public function get space():Space
		{
			return _space;
		}

		public function get jointObjectList():Vector.<IJointObject>
		{
			return _jointObjectList;
		}

		public function bodyObjectById(id:String):IBodyObject
		{
			for each (var bodyObject:IBodyObject in _bodyObjectList)
			{
				if (bodyObject.data.id == id)
				{
					return bodyObject;
				}
			}

			return null;
		}

		public function jointObjectById(id:String):IJointObject
		{
			for each (var jointObject:IJointObject in _jointObjectList)
			{
				if (jointObject.data.id == id)
				{
					return jointObject;
				}
			}

			return null;
		}

		override public function dispose():void
		{
			for each (var bodyObject:IBodyObject in _bodyObjectList)
			{
				bodyObject.dispose();
			}
			for each (var jointObject:IJointObject in _jointObjectList)
			{
				jointObject.dispose();
			}

			_space.bodies.clear();

			_bodyObjectList = null;
			_jointObjectList = null;
			_space = null;
			_data = null;
			factory = null;

			super.dispose();
		}

		public function clone():IWorldObject
		{
			var c:IWorldObject = factory.getInstance(IWorldObject, _data);
			return c;
		}
	}
}
