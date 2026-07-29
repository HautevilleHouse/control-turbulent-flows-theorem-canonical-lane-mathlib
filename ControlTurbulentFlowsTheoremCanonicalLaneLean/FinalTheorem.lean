import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ControlTurbulentFlowsTheoremCanonicalLaneLean.ControlBridgeGateLayer

namespace HautevilleHouse
namespace ControlTurbulentFlowsTheoremCanonicalLaneLean

def ConstrainedControlTurbulentFlowClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_control_turbulent_flow_endgame (A : AdmissibleClass) :
    ConstrainedControlTurbulentFlowClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ControlTurbulentFlowsTheoremCanonicalLaneLean
end HautevilleHouse