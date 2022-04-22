/obj/effect/overmap/ship/handle_wraparound()
    var/nx = x
    var/ny = y
    var/low_edge = 1
    var/high_edge = GLOB.maps_data.overmap_size

    if(x <= low_edge)
        nx = high_edge
    if(x >= high_edge)
        nx = low_edge

    if(y <= low_edge)
        ny =high_edge
    if(y >= high_edge)
        ny = low_edge

    var/turf/T = locate(nx,ny,z)
    if(T)
        forceMove(T)
