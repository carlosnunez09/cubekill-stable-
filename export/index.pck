GDPC                �                                                                      "   X   res://.godot/exported/133200997/export-af68f187d0e53086024c842c16659d87-main_tester.scn �B      �      ՠ�ȩ��h�^`�%Ѽ    X   res://.godot/exported/133200997/export-b35b29b7cc8cad2207fc241845c674e4-shootable.scn   �+      �      U�-���/Y���q�    T   res://.godot/exported/133200997/export-ea4cc94ea5a3c20e03f4bba9c6d23a0a-player.scn  �%      /      0��|9�Sk倱�b�    T   res://.godot/exported/133200997/export-f2c37ee60deab96f2b6849309f6f9141-index.scn   �8      �	      �i�i�O����*��[    ,   res://.godot/global_script_class_cache.cfg  �T             ��Р�8���8~$}P�    D   res://.godot/imported/cube.png-5d888a3b3b871cded2e6899cbd5a2571.ctex        ^       @_� $"s8_��+��    L   res://.godot/imported/cube_hallo.png-04a2757452a3f6d2ee24d882511948c8.ctex         �       �u$�V���
�0����    P   res://.godot/imported/cube_halo-export.png-850f43b944cedfa2002ef36cc29258cf.ctex�      n       2�1e9����xt    D   res://.godot/imported/icon.svg-ea0529c935a8d335ffeea918a1cb2245.ctex�      �      �̛�*$q�*�́     H   res://.godot/imported/loader.png-73c468fd9511e5c5db00c69f1d97304c.ctex  �      0      ~��s�h;� 8/m�y    L   res://.godot/imported/round_asset.png-60ec9af84a3bbc6ed0f392ef8ecf25e9.ctex        �       H��V���I�C�@�       res://.godot/uid_cache.bin  �X      �      �9�_�=�%�Z��{��    $   res://char_assets/cube.png.import   `       �       m yF,�`o�dp    (   res://char_assets/cube_hallo.png.import �      �       ��y�%�୻w��{�d�    0   res://char_assets/cube_halo-export.png.import   0      �       �`�?�i�p�jcP�    (   res://char_assets/round_asset.png.import�      �       	��f�n��(Ģ�m       res://code/GameManager.gd   �      �       NФ�D`��`�"�<r       res://code/Sprite2D.gd  �      "      <{�H�����F}� �(       res://code/colorGen.gd  �      Q      �}
��1!E6��       res://code/life_bullet.gd   �      0      G�W�]eIPΊA�8(       res://code/misc_adjust.gd         )      ��k� ��ԗ%��C       res://code/mouse.gd @      �      "R��osLaX$E�gs`       res://code/mouseTest.gd       �       e���3����������       res://code/set_Vel.gd         �       ���O�Q{�(r��q>�       res://ect/loader.png.import       �       N|��"W���U>..       res://msic/icon.svg  U      �      C��=U���^Qu��U3       res://msic/icon.svg.import  �$      �       ��vp.\�Q=4�r��        res://prefab/player.tscn.remap   S      c       O����}'�>�	��    $   res://prefab/shootable.tscn.remap   �S      f       ���D��|�O�	�o       res://project.binaryPZ      �      ����[b.��i�`�-�E        res://scean/CharacterBody2D.gd  �1      >      ߡ
�6<�CM�)�E�       res://scean/index.tscn.remap T      b       ��#������S�.    $   res://scean/main_tester.tscn.remap  pT      h       �|z��L[�c��*Um        res://scean/multiplayerTester.gdpJ      �      a?��Z��Mt�5�#��    D��GST2              ����                          &   RIFF   WEBPVP8L   /� ���������  ��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://kc4cqarq3e2"
path="res://.godot/imported/cube.png-5d888a3b3b871cded2e6899cbd5a2571.ctex"
metadata={
"vram_texture": false
}
 rGST2              ����                          �   RIFF�   WEBPVP8L�   /�0��?��p�l��O� >���u� >������� 8M��v�3w��I������{Fc�8j��{֜�{���q�OD=Ҝ�{֔��l�p������YΪ�����]��-�ST1�- �_'�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dopnf8fic3god"
path="res://.godot/imported/cube_hallo.png-04a2757452a3f6d2ee24d882511948c8.ctex"
metadata={
"vram_texture": false
}
 o����d~GST2              ����                          6   RIFF.   WEBPVP8L"   /�0��?���P� c����$Q���tȗNo
[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://dkvv8k85s5iad"
path="res://.godot/imported/cube_halo-export.png-850f43b944cedfa2002ef36cc29258cf.ctex"
metadata={
"vram_texture": false
}
 7�GST2              ����                          n   RIFFf   WEBPVP8LY   /�0��?��p�l�Q�3�	�R���)3Q��	��	n��$`�4��rϮ���L����ݳk5f�F(@ ��2�A � �V�}�IP�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://urskajopx8ms"
path="res://.godot/imported/round_asset.png-60ec9af84a3bbc6ed0f392ef8ecf25e9.ctex"
metadata={
"vram_texture": false
}
 ��5ӑ�A�:extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var rng = RandomNumberGenerator.new()
	#rng.seed = Time.get_unix_time_from_system()
	var r = rng.randf_range(0.5, 1.0)
	var g = rng.randf_range(0.5, 1.0)
	var b = rng.randf_range(0.5, 1.0)
	
	var sprite = self 
	
	#spite.modulate = Color(r,g,b,1)
	sprite.modulate = Color(r,g,b,1)
	


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_parent().get_node("playerSprite").get_modulate())
	pass


���6�&m�	*�{X6extends Node

var Player = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
3ѠNextends RigidBody2D

var lifespan = 4.0  # Adjust this to set the bullet's lifespan in seconds
var time_to_live = lifespan

func _ready():
	var rng = RandomNumberGenerator.new()
	self.modulate = Color(rng.randf_range(0.4, 1), rng.randf_range(0.4, 1), rng.randf_range(0.4, 1))

	#print(Color(rng.randf_range(0.4, 1), rng.randf_range(0.4, 1), rng.randf_range(0.4, 1))
	return

func _process(delta):
	time_to_live -= delta

	if time_to_live <= 0:
		queue_free()

func _on_BulletTimer_timeout():
	pass  # No need to connect the Timer, so this is an empty function
extends Node


@export var PlayerScene : PackedScene


func _ready():
	var index = 0
	for i in GameManager.Player:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Player[i].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("playerSpawnPoint"):
			if spawn.name == str(index):
				currentPlayer.global_position + spawn.global_position
			index +=1
	
	
	
	
	# Load your custom cursor image (Resource)
	var cursor_image = preload("res://char_assets/cube_hallo.png")

	# Set the custom mouse cursor with a 0, 0 offset
	set_custom_mouse_cursor(cursor_image, Input.CURSOR_ARROW, Vector2(10, 10))
	

func set_custom_mouse_cursor(image: Resource, shape: int = 0, hotspot: Vector2 = Vector2(0, 0)):
	Input.set_custom_mouse_cursor(image, shape, hotspot)
Fa���extends Sprite2D

var speed = 100.0

func _process(delta):
	var target_position = get_global_mouse_pos()
	var direction = (target_position - position).normalized()
	
	position += direction * speed * delta

	# Optional: Limit movement within the bounds of the Sprite2D
	position.x = clamp(position.x, -get_viewport_rect().size.x / 2, get_viewport_rect().size.x / 2)
	position.y = clamp(position.y, -get_viewport_rect().size.y / 2, get_viewport_rect().size.y / 2)
��extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
�R����Q�1extends RigidBody2D

var velocity = Vector2()

func _process(delta):
	# Move the projectile based on its velocity
	move_and_collide(velocity * 3)
:�fK**���ٸ�extends RigidBody2D 


var projectile_scene = preload("res://prefab/shootable.tscn")


var shoot_velocity = 1000
var speed = 100.0
var max_speed = 200.0
var fire_rate = 0.1

var can_fire = true



var object_position = Vector2(0, 0)
var key_directions = {
	KEY_W: Vector2(0, -1),
	KEY_S: Vector2(0, 1),
	KEY_A: Vector2(-1, 0),
	KEY_D: Vector2(1, 0)
}



func _ready():
	object_position = position
	
	# Create and set up the timer
	#object_position = Vector2(0,0)
	


func _physics_process(delta):

	look_at(get_global_mouse_position())
	pass


func _process(delta):
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_ins = projectile_scene.instantiate()
		bullet_ins.position = $bulletpoint.global_position
		bullet_ins.rotation_degrees = rotation
		bullet_ins.apply_impulse(Vector2(cos(rotation), sin(rotation)) * shoot_velocity, Vector2())
		#bullet_ins.script = script_bullet
		get_tree().get_root().add_child(bullet_ins)
		print(bullet_ins.script)
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
		
		
{��fn��+m�uU
GST2   @   @      ����               @ @        �   RIFF�   WEBPVP8L�   /?�' H�g�u�@��
Ͽ@��ѥ� \�pЀm؄B�!(� ����&��@D��m�H��{���ʼ�y��-o�7,�/�s����!��u	�*"�|�v�Ix@�lv� ��Zw�$�<�%�2s�S�ץ2bT*]���+���Ɖ�����}���O%C�p�*��qw�5�rko{h���[����L�ċ�8=��D7�����:��6��_��� [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ds3lw25wy2mpp"
path="res://.godot/imported/loader.png-73c468fd9511e5c5db00c69f1d97304c.ctex"
metadata={
"vram_texture": false
}
 K�v�S+�^ý�\GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[ {zl?���%
[�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c31lyyr58n658"
path="res://.godot/imported/icon.svg-ea0529c935a8d335ffeea918a1cb2245.ctex"
metadata={
"vram_texture": false
}
 �7�����f6g��RSRC                    PackedScene            ��������                                                  . 	   position 	   rotation    resource_local_to_scene    resource_name    custom_solver_bias    size    script    properties/0/path    properties/0/spawn    properties/0/sync    properties/0/watch    properties/1/path    properties/1/spawn    properties/1/sync    properties/1/watch 	   _bundled       Script    res://scean/CharacterBody2D.gd ��������
   Texture2D '   res://char_assets/cube_halo-export.png 3�:�,�m      local://RectangleShape2D_b6wkm �      %   local://SceneReplicationConfig_tqdkd �         local://PackedScene_wtwwi o         RectangleShape2D       
      B   B         SceneReplicationConfig 	                  	         
                                                                       PackedScene          	         names "         player    script    CharacterBody2D 	   Sprite2D    texture    bulletpoint 	   position    Node2D    CollisionShape2D    shape    MultiplayerSynchronizer    replication_config    	   variants                          
   �G�A                             node_count             nodes     -   ��������       ����                            ����                           ����                           ����   	                  
   
   ����                   conn_count              conns               node_paths              editable_instances              version             RSRC�RSRC                    PackedScene            ��������                                            
      resource_local_to_scene    resource_name 	   friction    rough    bounce 
   absorbent    script    custom_solver_bias    radius 	   _bundled       Script    res://code/life_bullet.gd ��������
   Texture2D "   res://char_assets/round_asset.png ָ���      local://PhysicsMaterial_6aalg "         local://CircleShape2D_qty2x N      %   local://SceneReplicationConfig_70exp x         local://PackedScene_kk6go �         PhysicsMaterial            �>         CircleShape2D          (IA         SceneReplicationConfig             PackedScene    	      	         names "         RigidBody2D    scale    mass    inertia    physics_material_override    gravity_scale    contact_monitor    script    CollisionShape2D    shape    RoundAsset    texture 	   Sprite2D    MultiplayerSynchronizer    replication_config    	   variants       
   �|_?�|_?   
�#<   ff�?                                 
   o�>o�>                                 node_count             nodes     4   ��������        ����                                                                ����         	                     
   ����            	                     ����      
             conn_count              conns               node_paths              editable_instances              version             RSRC^jextends CharacterBody2D

const max_speed = 200
const accel = 600
const friction = 600
var input = Vector2.ZERO


var shoot_velocity = 1000
var speed = 100.0
var fire_rate = 0.1
var can_fire = true
var projectile_scene = preload("res://prefab/shootable.tscn")



func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	pass


func get_input():
	input.x = int(Input.is_action_pressed("d_action")) - int(Input.is_action_pressed("a_action"))
	input.y = int(Input.is_action_pressed("s_action")) - int(Input.is_action_pressed("w_action"))
	
	return input.normalized()
	
func _physics_process(delta):
	player_movemnet(delta)
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("fire") and can_fire:
		#can_fire = false
		#await get_tree().create_timer(fire_rate).timeout
		#can_fire = true
		_shooting.rpc()
		pass
	

func player_movemnet(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		input = get_input()
		
		if input == Vector2.ZERO:
			if velocity.length() > (friction * delta):
				velocity -= velocity.normalized() * (friction * delta)
			else:
				velocity = Vector2.ZERO
		else:
			velocity += (input * accel * delta)
			velocity = velocity.limit_length(max_speed)
		move_and_slide()
		return
	
@rpc("any_peer","call_local")
func _shooting():
	#if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		
	var bullet_ins = projectile_scene.instantiate()
	bullet_ins.position = $bulletpoint.global_position
	bullet_ins.rotation_degrees = rotation
	bullet_ins.apply_impulse(Vector2(cos(rotation), sin(rotation)) * shoot_velocity, Vector2())
		#bullet_ins.script = script_bullet
	get_tree().get_root().add_child(bullet_ins)
	#can_fire = false
	#await get_tree().create_timer(fire_rate).timeout
	#can_fire = true
		
	return
	
	
n�RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    blend_mode    light_mode    particles_animation    script 	   _bundled       Script !   res://scean/multiplayerTester.gd ��������   !   local://CanvasItemMaterial_optsr {         local://PackedScene_6afuo �         CanvasItemMaterial             PackedScene          	         names "          index    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Control    Label    anchor_left    anchor_top    offset_left    offset_top    offset_right    offset_bottom $   theme_override_font_sizes/font_size    text    Start 	   material    custom_minimum_size    pivot_offset    flat    Button    join    Host    name 	   LineEdit    _on_start_button_down    button_down    _on_join_button_down    _on_host_button_down    	   variants    7                    �?                         ����   ��v>   P�=   ��@?   �µ>   h�>   ��<   � D   � 7C   �      
   cube kill           
   ff�       j�<   7��>   ���=   5^�>   ����   `e=   �Ⱦ   >
      @       .         start          h��<   ���>   /�=   }??   ��о   p>   ��Ծ   �/]>      join    ���<   F�?   #��=   � 0?   yt�>   ���=   x�>   	84>      host
    ��>   ��S>   {�>   4]�   ���   �ף�      node_count             nodes     �   ��������       ����                                                          	   	   ����               
               	      
                                                         ����                           
                                                                                          ����               
                !      "      #      $      %      &            '                           ����               
   (      )      *      +      ,      -      .      /            0                           ����
               
         1      2      3            4      5      6             conn_count             conns                                                                                      node_paths              editable_instances              version             RSRC$������RSRC                    PackedScene            ��������                                            
      resource_local_to_scene    resource_name 	   friction    rough    bounce 
   absorbent    script    custom_solver_bias    size 	   _bundled       Script    res://code/misc_adjust.gd ��������   PackedScene    res://prefab/player.tscn ����p�'>
   Texture2D    res://char_assets/cube.png ��U��I       local://PhysicsMaterial_xardg           local://RectangleShape2D_tb23e d         local://PackedScene_ul6gf �         PhysicsMaterial                   {.>                  RectangleShape2D       
      B   B         PackedScene    	      	         names "         Node2D 	   position    script    PlayerScene "   metadata/_edit_horizontal_guides_     metadata/_edit_vertical_guides_ 	   Sprite2D 	   modulate    scale    texture 	   Camera2D    RigidBody2D    mass    physics_material_override    gravity_scale 
   can_sleep    lock_rotation    freeze    freeze_mode    Cube    CollisionShape2D    shape    Spawn    Node    0    playerSpawnPoint    1    	   variants       
     �A  ��                               �           l�                 �?
     C �B              zD                                             
     �C  �
     ��  C      node_count    	         nodes     g   ��������        ����                                                    ����               	                  
   
   ����                      ����            	      
                                            ����   	                       ����                           ����                      ����                             ����                     conn_count              conns               node_paths              editable_instances              version             RSRC�|�-���T{extends Control

@export var Address = "100.106.91.136"
@export var port = 8910
var peer
# Called when the node enters the scene tree for the first time.
func _ready():
# Function that gets called when the button is pressed.
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	if "--server" in OS.get_cmdline_args():
		hostGame()
	
	pass


#peer connected
func PlayerConnected(id):
	print("player connected" + str(id))
	sendPlayerInformation.rpc_id(1,$name.text, multiplayer.get_unique_id())

	
#peer connected
func PlayerDisconnected(id):
	print("player disconnected" + str(id))
#called only from clients
func connected_to_server(id):
	print("player connected to server!" + str(id))
	
	
	
#called only from clients
func connection_failed(id):
	print("player failed to connect " + id)

@rpc("any_peer")
func sendPlayerInformation(name, id):
	if!GameManager.Player.has(id):
		GameManager.Player[id] = {
			"name" : name,
			"id" : id,
			"score": 0
		}
	if multiplayer.is_server():
		for i in GameManager.Player:
			sendPlayerInformation.rpc(GameManager.Player[i].name,i)



@rpc("any_peer","call_local")
func StartGame():
	var scean = load("res://scean/main_tester.tscn").instantiate()
	get_tree().root.add_child(scean)
	self.hide()
	pass

func _on_start_button_down():
	StartGame.rpc()
	pass
	
	
	
	
#compress_fastLZ
func hostGame():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port,4)
	if error != OK:
		print("canno  host: " +  str(error))
		return
	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	
	
	multiplayer.set_multiplayer_peer(peer)
	print("waiting")
	#sendPlayerInformation($name.text,multiplayer.get_unique_id())

func _on_host_button_down():
	hostGame()
	sendPlayerInformation($name.text,multiplayer.get_unique_id())
	pass # Replace with function body.




func _on_join_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address,port)
	peer.get_host().compress(ENetConnection.COMPRESS_FASTLZ)
	multiplayer.set_multiplayer_peer(peer)
	pass # Replace with function body.
o���|[remap]

path="res://.godot/exported/133200997/export-ea4cc94ea5a3c20e03f4bba9c6d23a0a-player.scn"
cl7�aޒ�43揔[remap]

path="res://.godot/exported/133200997/export-b35b29b7cc8cad2207fc241845c674e4-shootable.scn"
ik
�y��pL[remap]

path="res://.godot/exported/133200997/export-f2c37ee60deab96f2b6849309f6f9141-index.scn"
����0d���[remap]

path="res://.godot/exported/133200997/export-af68f187d0e53086024c842c16659d87-main_tester.scn"
�؏��:list=Array[Dictionary]([])
�u���<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
�~%sJ�s���
   ��U��I    res://char_assets/cube.png����nq    res://char_assets/cube_hallo.png3�:�,�m&   res://char_assets/cube_halo-export.pngָ���!   res://char_assets/round_asset.pngղ�Mi-�u   res://ect/loader.png�ggC�C^   res://msic/icon.svg����p�'>   res://prefab/player.tscnd�~J   res://prefab/shootable.tscn�^~)�'p   res://scean/index.tscns�bC�Oh   res://scean/main_tester.tscn�����ECFG      application/config/name         Cubekill(stable)   application/run/main_scene          res://scean/index.tscn     application/config/features(   "         4.1    GL Compatibility        application/boot_splash/bg_color      q�>q�>q�>  �?   application/config/icon         res://msic/icon.svg    autoload/GameManager$         *res://code/GameManager.gd  !   display/mouse_cursor/custom_image(          res://char_assets/cube_hallo.png,   display/mouse_cursor/tooltip_position_offset         �   �   importer_defaults/texture�              compress/channel_pack                compress/hdr_compression            compress/high_quality                compress/lossy_quality    ffffff�?      compress/mode                compress/normal_map              detect_3d/compress_to               mipmaps/generate             mipmaps/limit      ����      process/fix_alpha_border            process/hdr_as_srgb              process/hdr_clamp_exposure               process/normal_map_invert_y              process/premult_alpha                process/size_limit               roughness/mode               roughness/src_normal       
   input/fire�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         canceled          pressed           double_click          script         input/a_action�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/w_action�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script         input/s_action�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/d_action�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script      #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility