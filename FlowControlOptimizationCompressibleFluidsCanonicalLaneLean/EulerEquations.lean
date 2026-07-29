import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure EulerOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  pressureGradient : ScalarField → VectorField

def primitiveEulerOperators : EulerOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  pressureGradient := fun _ => zeroVectorField
}

structure EulerFlow where
  velocity : VectorField
  pressure : ScalarField
  density : ScalarField
  operators : EulerOperators

def primitiveEulerFlow : EulerFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  density := zeroScalarField
  operators := primitiveEulerOperators
}

def EulerEquationClosed (F : EulerFlow) : Prop :=
  F.operators.timeDerivative F.velocity =
    F.operators.transport F.velocity + F.operators.pressureGradient F.pressure

theorem primitive_euler_equation_closed_checked : EulerEquationClosed primitiveEulerFlow := by
  rfl

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
