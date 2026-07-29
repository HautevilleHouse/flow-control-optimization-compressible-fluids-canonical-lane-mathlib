import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.FlowControlOptimizationCompressibleFluidsCanonicalLaneLean.CompressibleNavierStokesLayer

namespace HautevilleHouse
namespace FlowControlOptimizationCompressibleFluidsCanonicalLaneLean

structure TurbulenceScalingCertificate where
  flow : CompressibleNSFlow
  reynoldsNumber : ℝ
  dissipationRate : ℝ
  kolmogorovLength : ℝ
  scalingExponents : List ℝ
  reynoldsNumberClosed : reynoldsNumber > 0
  dissipationRateClosed : dissipationRate > 0
  kolmogorovLengthClosed : kolmogorovLength > 0
  scalingExponentsClosed : scalingExponents.length = 3
  flowClosed : CompressibleNSEquationsClosed flow


def sourceTurbulenceScalingCertificate : TurbulenceScalingCertificate := {
  flow := primitiveCompressibleNSFlow
  reynoldsNumber := 1000
  dissipationRate := 0.1
  kolmogorovLength := 0.01
  scalingExponents := [5/3, 2, 1]
  reynoldsNumberClosed := by norm_num
  dissipationRateClosed := by norm_num
  kolmogorovLengthClosed := by norm_num
  scalingExponentsClosed := by decide
  flowClosed := primitive_compressible_ns_closed_checked
}

def TurbulenceScalingClosed (C : TurbulenceScalingCertificate) : Prop :=
  CompressibleNSEquationsClosed C.flow ∧
  C.reynoldsNumber > 0 ∧
  C.dissipationRate > 0 ∧
  C.kolmogorovLength > 0 ∧
  C.scalingExponents.length = 3

theorem source_turbulence_scaling_closed : TurbulenceScalingClosed sourceTurbulenceScalingCertificate := by
  refine And.intro sourceTurbulenceScalingCertificate.flowClosed
    (And.intro sourceTurbulenceScalingCertificate.reynoldsNumberClosed
      (And.intro sourceTurbulenceScalingCertificate.dissipationRateClosed
        (And.intro sourceTurbulenceScalingCertificate.kolmogorovLengthClosed
          sourceTurbulenceScalingCertificate.scalingExponentsClosed)))

end FlowControlOptimizationCompressibleFluidsCanonicalLaneLean
end HautevilleHouse
