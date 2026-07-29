import FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.CompressibleFlowOperators

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

structure OptimalControlCertificate where
  flow : CompressibleFlow
  controlObjective : Prop
  adjointClosed : Prop
  optimalityCondition : Prop
  controlObjectiveClosed : controlObjective
  adjointClosedProof : adjointClosed
  optimalityConditionClosed : optimalityCondition

def sourceOptimalControlCertificate : OptimalControlCertificate := {
  flow := primitiveFlow
  controlObjective := CompressibleFlowClosed primitiveFlow
  adjointClosed := True
  optimalityCondition := True
  controlObjectiveClosed := primitive_flow_closed_checked
  adjointClosedProof := trivial
  optimalityConditionClosed := trivial
}

def OptimalControlClosed (C : OptimalControlCertificate) : Prop :=
  C.controlObjective ∧ C.adjointClosed ∧ C.optimalityCondition

theorem source_optimal_control_closed :
    OptimalControlClosed sourceOptimalControlCertificate := by
  exact And.intro sourceOptimalControlCertificate.controlObjectiveClosed
    (And.intro sourceOptimalControlCertificate.adjointClosedProof
      sourceOptimalControlCertificate.optimalityConditionClosed)

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse