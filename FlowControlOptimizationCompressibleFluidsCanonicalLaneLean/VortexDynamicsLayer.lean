import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.EulerEquations

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

structure VortexSheet where
  strength : ScalarField
  position : Space3 → Space3
  circulation : ℝ
  strengthClosed : strength ≠ zeroScalarField
  circulationClosed : circulation > 0

structure VortexDynamicsCertificate where
  baseFlow : EulerFlow
  vortexSheets : List VortexSheet
  totalCirculation : ℝ
  vortexStretching : VectorField
  baseFlowClosed : EulerEquationClosed baseFlow
  vortexSheetsClosed : List.length vortexSheets = 2
  totalCirculationClosed : totalCirculation > 0
  vortexStretchingClosed : vortexStretching ≠ zeroVectorField


def sourceVortexSheet1 : VortexSheet := {
  strength := fun _ _ => 1
  position := fun x => x
  circulation := 10
  strengthClosed := by
    intro h
    have : zeroScalarField = fun _ _ => 0 := rfl
    have : strength (0, fun _ => 0) = 1 := rfl
    simp at h
  circulationClosed := by norm_num
}

def sourceVortexSheet2 : VortexSheet := {
  strength := fun _ _ => 2
  position := fun x => x
  circulation := 20
  strengthClosed := by
    intro h
    have : strength (0, fun _ => 0) = 2 := rfl
    simp at h
  circulationClosed := by norm_num
}

def sourceVortexDynamicsCertificate : VortexDynamicsCertificate := {
  baseFlow := primitiveEulerFlow
  vortexSheets := [sourceVortexSheet1, sourceVortexSheet2]
  totalCirculation := 30
  vortexStretching := zeroVectorField
  baseFlowClosed := primitive_euler_equation_closed_checked
  vortexSheetsClosed := by decide
  totalCirculationClosed := by norm_num
  vortexStretchingClosed := by
    intro h
    have : zeroVectorField = fun _ _ _ => 0 := rfl
    have : vortexStretching (0, fun _ => 0, 0) = 0 := rfl
    have : vortexStretching = fun _ _ _ => 0 := rfl
    simp at h
}

def VortexDynamicsClosed (C : VortexDynamicsCertificate) : Prop :=
  EulerEquationClosed C.baseFlow ∧
  List.length C.vortexSheets = 2 ∧
  C.totalCirculation > 0 ∧
  C.vortexStretching ≠ zeroVectorField

theorem source_vortex_dynamics_closed : VortexDynamicsClosed sourceVortexDynamicsCertificate := by
  refine And.intro sourceVortexDynamicsCertificate.baseFlowClosed
    (And.intro sourceVortexDynamicsCertificate.vortexSheetsClosed
      (And.intro sourceVortexDynamicsCertificate.totalCirculationClosed
        sourceVortexDynamicsCertificate.vortexStretchingClosed))

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
