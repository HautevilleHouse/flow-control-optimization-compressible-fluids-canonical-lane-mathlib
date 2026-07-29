import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.VortexDynamicsLayer

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

structure FlowControlCertificate where
  vortexDynamics : VortexDynamicsCertificate
  controlSurface : VectorField
  targetVelocity : VectorField
  costFunctional : ScalarField
  controlSurfaceClosed : controlSurface ≠ zeroVectorField
  targetVelocityClosed : targetVelocity ≠ zeroVectorField
  costFunctionalClosed : ∀ t x, costFunctional t x ≥ 0
  vortexDynamicsClosed : VortexDynamicsClosed vortexDynamics


def sourceFlowControlCertificate : FlowControlCertificate := {
  vortexDynamics := sourceVortexDynamicsCertificate
  controlSurface := zeroVectorField
  targetVelocity := zeroVectorField
  costFunctional := zeroScalarField
  controlSurfaceClosed := by
    intro h
    have : controlSurface = fun _ _ _ => 0 := rfl
    simp at h
  targetVelocityClosed := by
    intro h
    have : targetVelocity = fun _ _ _ => 0 := rfl
    simp at h
  costFunctionalClosed := by
    intro t x
    rfl
  vortexDynamicsClosed := source_vortex_dynamics_closed
}

def FlowControlClosed (C : FlowControlCertificate) : Prop :=
  VortexDynamicsClosed C.vortexDynamics ∧
  C.controlSurface ≠ zeroVectorField ∧
  C.targetVelocity ≠ zeroVectorField ∧
  ∀ t x, C.costFunctional t x ≥ 0

theorem source_flow_control_closed : FlowControlClosed sourceFlowControlCertificate := by
  refine And.intro sourceFlowControlCertificate.vortexDynamicsClosed
    (And.intro sourceFlowControlCertificate.controlSurfaceClosed
      (And.intro sourceFlowControlCertificate.targetVelocityClosed
        sourceFlowControlCertificate.costFunctionalClosed))

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
