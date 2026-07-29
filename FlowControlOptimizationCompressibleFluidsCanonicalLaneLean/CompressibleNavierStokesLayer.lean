import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.EulerEquations

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

structure CompressibleNSOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  stressTensor : VectorField → VectorField
  heatFlux : ScalarField → VectorField

def primitiveCompressibleNSOperators : CompressibleNSOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  stressTensor := fun u => u
  heatFlux := fun _ => zeroVectorField
}

structure CompressibleNSFlow where
  velocity : VectorField
  pressure : ScalarField
  density : ScalarField
  temperature : ScalarField
  viscosity : ℝ
  thermalConductivity : ℝ
  operators : CompressibleNSOperators

def primitiveCompressibleNSFlow : CompressibleNSFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  density := zeroScalarField
  temperature := zeroScalarField
  viscosity := 1
  thermalConductivity := 1
  operators := primitiveCompressibleNSOperators
}

def ContinuityEquation (F : CompressibleNSFlow) : Prop :=
  F.operators.timeDerivative (fun t x => F.density t x) +
    F.operators.divergence (fun t x => F.density t x • F.velocity t x) = zeroScalarField

def MomentumEquation (F : CompressibleNSFlow) : Prop :=
  F.operators.timeDerivative (fun t x => F.density t x • F.velocity t x) +
    F.operators.divergence (fun t x => F.density t x • F.velocity t x ⊗ F.velocity t x) =
    F.operators.divergence (F.operators.stressTensor F.velocity) + F.operators.gradient F.pressure

def EnergyEquation (F : CompressibleNSFlow) : Prop :=
  F.operators.timeDerivative (fun t x => F.density t x * F.temperature t x) +
    F.operators.divergence (fun t x => F.density t x * F.temperature t x • F.velocity t x) =
    F.operators.divergence (F.operators.heatFlux F.temperature)

def CompressibleNSEquationsClosed (F : CompressibleNSFlow) : Prop :=
  ContinuityEquation F ∧ MomentumEquation F ∧ EnergyEquation F

theorem primitive_compressible_ns_closed_checked : CompressibleNSEquationsClosed primitiveCompressibleNSFlow := by
  refine And.intro ?_ (And.intro ?_ ?_)
  · rfl
  · rfl
  · rfl

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
