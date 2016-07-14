module Gts
export gts_point_new, GtsObject, GtsPoint, gts_point_class, gts_destroy

const libGTS = "libgts"

abstract AbstractGtsObject

immutable GtsObject <: AbstractGtsObject
    gtsObjectClass::Ptr{Void}
    reserved::Ptr{Void}
    flags::UInt32
end

immutable GtsPoint <: AbstractGtsObject
    gtsObject::GtsObject
    x::Float64
    y::Float64
    z::Float64
end

function gts_point_class()
    return ccall((:gts_point_class, libGTS), Ptr{Void}, ())
end

function gts_point_new(x, y, z)
    pointclass = gts_point_class()
    gtspointer = ccall((:gts_point_new, libGTS), Ref{GtsPoint}, (Ptr{Void}, Cfloat, Cfloat, Cfloat), pointclass, x, y, z)
    return gtspointer
end

function gts_destroy{T<:AbstractGtsObject}(ob::Ref{T})
    return ccall((:gts_object_destroy, libGTS), Void, (Ref{T},), ob)
end

end # module
