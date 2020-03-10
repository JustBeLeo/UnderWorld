extends Control

func _on_shop_box_pressed():
	# 其实只需要内部响应 然后传出操作完成的信号即可
	$shop_hand.visible = true
	$AP.play("放入盒子")
