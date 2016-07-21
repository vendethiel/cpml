--- Mesh utilities
-- @module mesh

local modules = (...):gsub('%.[^%.]+$', '') .. "."
local vec3    = require(modules .. "vec3")
local mesh    = {}

-- vertices is an arbitrary list of vec3s
function mesh.average(vertices)
	local out = vec3()
	for _, v in ipairs(vertices) do
		out:add(out, v)
	end
	return out:div(out, #vertices)
end

-- triangle[1] is a vec3
-- triangle[2] is a vec3
-- triangle[3] is a vec3
function mesh.normal(triangle)
	local ca  = vec3():sub(triangle[3], triangle[1])
	local ba  = vec3():sub(triangle[2], triangle[1])
	local out = vec3()
	return out
		:cross(ca, ba)
		:normalize(out)
end

-- triangle[1] is a vec3
-- triangle[2] is a vec3
-- triangle[3] is a vec3
function mesh.plane_from_triangle(triangle)
	local out = {}
	local ca  = vec3():sub(triangle[3], triangle[1])
	local ba  = vec3():sub(triangle[2], triangle[1])

	out.origin = triangle[1]
	out.normal = vec3()
		:cross(ba, ca)
		:normalize(out)
	out.dot = -out.normal:dot(out.origin)

	return out
end

-- plane.origin is a vec3
-- plane.normal is a vec3
-- direction    is a vec3
function mesh.is_front_facing(plane, direction)
	return plane.normal:dot(direction) <= 0
end

-- point        is a vec3
-- plane.origin is a vec3
-- plane.normal is a vec3
-- plane.dot    is a number
function mesh.signed_distance(point, plane)
	dot = plane.dot or -plane.normal:dot(plane.origin)
	return point:dot(plane.normal) + dot
end

return mesh
