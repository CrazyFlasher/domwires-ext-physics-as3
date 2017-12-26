/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.domwires.extensions.physics
{
	import com.domwires.core.factory.IAppFactoryImmutable;
	import com.domwires.core.mvc.model.AbstractModel;
	import com.domwires.extensions.physics.vo.units.VertexDataVo;

	import nape.geom.Vec2;

	public class VertexObject extends AbstractModel implements IVertexObject
	{
		[Autowired]
		public var factory:IAppFactoryImmutable;

		private var _vertex:Vec2;

		private var _data:VertexDataVo;

		public function VertexObject(data:VertexDataVo)
		{
			super();

			_data = data;
		}

		[PostConstruct]
		public function init():void
		{
			_vertex = new Vec2(_data.x, _data.y);
		}

		public function get x():Number
		{
			return _data.x;
		}

		public function get y():Number
		{
			return _data.y;
		}

		public function get data():VertexDataVo
		{
			return _data;
		}

		public function get vertex():Vec2
		{
			return _vertex;
		}

		override public function dispose():void
		{
			_vertex.dispose();

			_vertex = null;
			_data = null;
			factory = null;

			super.dispose();
		}

		public function clone():IVertexObject
		{
			var c:IVertexObject = factory.getInstance(IVertexObject, _data);
			return c;
		}
	}
}
