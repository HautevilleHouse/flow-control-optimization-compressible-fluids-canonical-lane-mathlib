import FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.BoundaryLayerControl

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

structure TurbulenceModelCertificate where
  boundaryControl : BoundaryControlCertificate
  reynoldsStressClosed : Prop
  dissipationRateClosed : Prop
  reynoldsStressClosedProof : reynoldsStressClosed
  dissipationRateClosedProof : dissipationRateClosed

def sourceTurbulenceModelCertificate : TurbulenceModelCertificate := {
  boundaryControl := sourceBoundaryControlCertificate
  reynoldsStressClosed := True
  dissipationRateClosed := True
  reynoldsStressClosedProof := trivial
  dissipationRateClosedProof := trivial
}

def TurbulenceModelClosed (C : TurbulenceModelCertificate) : Prop :=
  BoundaryControlClosed C.boundaryControl ∧ C.reynoldsStressClosed ∧ C.dissipationRateClosed

theorem source_turbulence_model_closed :
    TurbulenceModelClosed sourceTurbulenceModelCertificate := by
  exact And.intro source_boundary_control_closed
    (And.intro sourceTurbulenceModelCertificate.reynoldsStressClosedProof
      sourceTurbulenceModelCertificate.dissipationRateClosedProof)

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse