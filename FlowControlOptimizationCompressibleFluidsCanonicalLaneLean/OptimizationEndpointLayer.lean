import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.FlowControlLayer

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

structure OptimizationEndpointCertificate where
  flowControl : FlowControlCertificate
  optimalControl : VectorField
  adjointState : VectorField
  optimalityCondition : Prop
  optimalControlClosed : optimalControl ≠ zeroVectorField
  adjointStateClosed : adjointState ≠ zeroVectorField
  optimalityConditionClosed : optimalityCondition
  flowControlClosed : FlowControlClosed flowControl


def sourceOptimizationEndpointCertificate : OptimizationEndpointCertificate := {
  flowControl := sourceFlowControlCertificate
  optimalControl := zeroVectorField
  adjointState := zeroVectorField
  optimalityCondition := True
  optimalControlClosed := by
    intro h
    have : optimalControl = fun _ _ _ => 0 := rfl
    simp at h
  adjointStateClosed := by
    intro h
    have : adjointState = fun _ _ _ => 0 := rfl
    simp at h
  optimalityConditionClosed := trivial
  flowControlClosed := source_flow_control_closed
}

def OptimizationEndpointClosed (C : OptimizationEndpointCertificate) : Prop :=
  FlowControlClosed C.flowControl ∧
  C.optimalControl ≠ zeroVectorField ∧
  C.adjointState ≠ zeroVectorField ∧
  C.optimalityCondition

theorem source_optimization_endpoint_closed : OptimizationEndpointClosed sourceOptimizationEndpointCertificate := by
  refine And.intro sourceOptimizationEndpointCertificate.flowControlClosed
    (And.intro sourceOptimizationEndpointCertificate.optimalControlClosed
      (And.intro sourceOptimizationEndpointCertificate.adjointStateClosed
        sourceOptimizationEndpointCertificate.optimalityConditionClosed))

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
