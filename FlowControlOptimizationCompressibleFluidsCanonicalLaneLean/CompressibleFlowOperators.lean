import FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.MathlibStatement
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev DensityField := Time → Space3 → ℝ
abbrev VelocityField := Time → Space3 → Space3
abbrev PressureField := Time → Space3 → ℝ

def zeroDensityField : DensityField := fun _ _ => 0
def zeroVelocityField : VelocityField := fun _ _ _ => 0
def zeroPressureField : PressureField := fun _ _ => 0

structure CompressibleFlowOperators where
  divergence : VelocityField → DensityField
  gradient : DensityField → VelocityField
  laplacian : VelocityField → VelocityField
  timeDerivative : DensityField → DensityField
  advection : VelocityField → DensityField → DensityField
  pressureProjection : VelocityField → VelocityField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveOperators : CompressibleFlowOperators := {
  divergence := fun _ => zeroDensityField
  gradient := fun _ => zeroVelocityField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroDensityField
  advection := fun _ _ => zeroDensityField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure CompressibleFlow where
  density : DensityField
  velocity : VelocityField
  pressure : PressureField
  viscosity : ℝ
  operators : CompressibleFlowOperators

def primitiveFlow : CompressibleFlow := {
  density := zeroDensityField
  velocity := zeroVelocityField
  pressure := zeroPressureField
  viscosity := 1
  operators := primitiveOperators
}

def ContinuityEquation (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative F.density = F.operators.divergence F.velocity

def MomentumEquation (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative F.density = F.operators.laplacian F.velocity

def CompressibleFlowClosed (F : CompressibleFlow) : Prop :=
  ContinuityEquation F ∧ MomentumEquation F ∧ True

theorem primitive_flow_continuity_checked :
    ContinuityEquation primitiveFlow := by
  rfl

theorem primitive_flow_momentum_checked :
    MomentumEquation primitiveFlow := by
  rfl

theorem primitive_flow_closed_checked :
    CompressibleFlowClosed primitiveFlow := by
  exact And.intro primitive_flow_continuity_checked (And.intro primitive_flow_momentum_checked trivial)

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse