mutable struct SinkhornParameters
    L::Int
    ε::Float64
    tol::Float64

    averaged_updates::Bool
    debias::Bool

    update_potentials::Bool
end

SinkhornParameters(L::Int) = SinkhornParameters(L, 5e-3, 0, false, true, false)
SinkhornParameters(L, ε) = SinkhornParameters(L, ε, 0, false, true, false)

function _safe_log!(log_x, x)
    for i in eachindex(x)
        x[i] <= 0 ? log_x[i] = -1e4 : log_x[i] = log(x[i])
    end
end

function _safe_log(x::AbstractArray)
    log_x = zero(x)
    for i in eachindex(x)
        x[i] <= 0 ? log_x[i] = -1e4 : log_x[i] = log(x[i])
    end
    log_x
end

function _safe_log(x::Real)
    if x <= 0
        return -1e4
    else
        return log(x)
    end
end