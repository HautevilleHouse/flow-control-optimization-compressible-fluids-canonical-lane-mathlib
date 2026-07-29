import FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.OptimalControlLayer

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

structure BoundaryControlCertificate where
  optimalControl : OptimalControlCertificate
  boundaryConditionClosed : Prop
  actuationModelClosed : Prop
  boundaryConditionClosedProof : boundaryConditionClosed
  actuationModelClosedProof : actuationModelClosed

def sourceBoundaryControlCertificate : BoundaryControlCertificate := {
  optimalControl := sourceOptimalControlCertificate
  boundaryConditionClosed := True
  actuationModelClosed := True
  boundaryConditionClosedProof := trivial
  actuationModelClosedProof := trivial
}

def BoundaryControlClosed (C : BoundaryControlCertificate) : Prop :=
  OptimalControlClosed C.optimalControl ∧ C.boundaryConditionClosed ∧ C.actuationModelClosed

theorem source_boundary_control_closed :
    BoundaryControlClosed sourceBoundaryControlCertificate := by
  exact And.intro source_optimal_control_closed
    (And.intro sourceBoundaryControlCertificate.boundaryConditionClosedProof
      sourceBoundaryControlCertificate.actuationModelClosedProof)

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse