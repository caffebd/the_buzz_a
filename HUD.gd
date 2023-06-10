extends Control


	

func update_distance(dist):
#	%Distance.text = "The BUZZ "+str(dist)
	%DistanceBar.size.x = 300/dist
	%DistanceBar.color = Color( 1/dist,1-(1/dist),1-(1/dist),1)
	
