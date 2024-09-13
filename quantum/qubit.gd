class_name Qubit


enum Type {
    Zero,
    One,
    Plus,
    Minus
}

const INV_SQRT2 := 1 / sqrt(2)


var state := State.new()
var idx: int = 0


func _init(alpha_: Complex, beta_: Complex) -> void:
    state.qubits = [self]
    state.amplitudes = [alpha_, beta_]


func observe() -> bool:
    return state.observe(self)


static func from_type(type: Type) -> Qubit:
    match type:
        Type.Zero:
            return Qubit.new(Complex.new(1, 0), Complex.new(0, 0))
        Type.One:
            return Qubit.new(Complex.new(0, 0), Complex.new(1, 0))
        Type.Plus:
            return Qubit.new(Complex.new(INV_SQRT2, 0), Complex.new(INV_SQRT2, 0))
        Type.Minus:
            return Qubit.new(Complex.new(INV_SQRT2, 0), Complex.new(-INV_SQRT2, 0))
        _:
            assert(false, "Invalid qubit type: " + str(type))
            return Qubit.new(Complex.new(0, 0), Complex.new(0, 0))


func _to_string() -> String:
    return "Qubit(" + str(round(100 * state.get_probability(self, 0))) + " % |0> + " + str(round(100 * state.get_probability(self, 1))) + " % |1>)"