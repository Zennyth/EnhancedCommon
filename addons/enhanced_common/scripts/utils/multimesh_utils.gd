extends Object
class_name MultiMeshUtils

static func create_multimesh_instance_2d_from_texture(texture: Texture2D, coordinates: Array[Vector2], material: Material = null) -> MultiMeshInstance2D:
	var instance := MultiMeshInstance2D.new()
	var multimesh: MultiMesh = MultiMesh.new()
	var mesh: QuadMesh = QuadMesh.new()

	mesh.size = texture.get_size()

	if texture is AtlasTexture:
		var image: Image = texture.atlas.get_image()
		var icon: Image = Image.create(texture.region.size.x, texture.region.size.y, false, image.get_format())
		icon.blit_rect(image, texture.region, Vector2i.ZERO)
		instance.texture = ImageTexture.create_from_image(icon)
	else:
		instance.texture = texture
	
	multimesh.instance_count = len(coordinates)
	
	for i in len(coordinates):
		multimesh.set_instance_transform_2d(i, Transform2D(PI, coordinates[i]))
		
	multimesh.mesh = mesh
	instance.material = material
	instance.multimesh = multimesh
	
	return instance