/obj/item
	var/obj/item/layer_above
	var/obj/item/layer_below

/obj/item/proc/add_layer(var/obj/item/layer)
	if(layer_above)
		return 0

	src.layer_above = layer
	layer.layer_below = src
