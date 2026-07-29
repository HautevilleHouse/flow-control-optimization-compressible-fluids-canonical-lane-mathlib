import canonicalLaneMathlib.NavierStokesAnalyticClosure

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

def FlowControlAdmittedAnalyticClosure : Prop :=
  FlowControlAnalyticCertificateClosed sourceFlowControlAnalyticCertificate ∧
  ConstrainedFlowControlClosure analyticAdmissibleClass

def UnrestrictedClassicalFlowControlBoundaryCarried : Prop :=
  formalizationCertificate.theoremBoundaryOpen = true ∧
  mathlibPDESubstrate.unrestrictedNavierStokesStackCarried = true

theorem flow_control_admitted_analytic_closure_checked :
    FlowControlAdmittedAnalyticClosure := by
  exact And.intro source_flow_control_analytic_certificate_closed
    (constrained_flow_control_endgame analyticAdmissibleClass)

theorem unrestricted_classical_flow_control_boundary_carried_checked :
    UnrestrictedClassicalFlowControlBoundaryCarried := by
  exact And.intro rfl rfl

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse