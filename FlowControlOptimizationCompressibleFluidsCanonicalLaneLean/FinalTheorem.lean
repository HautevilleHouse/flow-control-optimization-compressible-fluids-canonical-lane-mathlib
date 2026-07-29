import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

def FlowControlOptimizationCompressibleFluidsClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem flow_control_optimization_compressible_fluids_endgame (A : AdmissibleClass) :
    FlowControlOptimizationCompressibleFluidsClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse