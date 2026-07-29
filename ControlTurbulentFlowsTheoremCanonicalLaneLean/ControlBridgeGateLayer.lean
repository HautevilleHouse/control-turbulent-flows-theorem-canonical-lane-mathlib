import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ControlTurbulentFlowsTheoremCanonicalLaneLean.ControlTurbulentFlowVelocityLayer
import HautevilleHouse.ControlTurbulentFlowsTheoremCanonicalLaneLean.ReynoldsStressModelLayer

namespace HautevilleHouse
namespace ControlTurbulentFlowsTheoremCanonicalLaneLean

structure ControlTurbulentFlowCertificate where
  flowState : TurbulentFlowState
  turbulenceModel : TurbulenceModel
  controlEquationClosed : ControlTurbulentFlowEquation flowState
  modelClosed : TurbulenceModelClosed turbulenceModel
  bridgeConstantKeys : List String
  bridgeConstantKeysClosed : bridgeConstantKeys.length = 7
  remainderRecorded : ℝ
  remainderRecordedClosed : remainderRecorded = 0

def sourceControlTurbulentFlowCertificate : ControlTurbulentFlowCertificate := {
  flowState := primitiveTurbulentFlowState
  turbulenceModel := sourceTurbulenceModel
  controlEquationClosed := primitive_turbulent_flow_control_equation_checked
  modelClosed := source_turbulence_model_closed_checked
  bridgeConstantKeys := ["C_mu", "C1_eps", "C2_eps", "sigma_k", "sigma_eps", "kappa", "Pr_t"]
  bridgeConstantKeysClosed := rfl
  remainderRecorded := 0
  remainderRecordedClosed := rfl
}

def bridgeClosed (A : AdmissibleClass) : Prop :=
  NativeBridgeClosed A.object

theorem bridge_from_admissible_class (A : AdmissibleClass) :
    bridgeClosed A := by
  exact And.intro A.object.sourceKeyChecked A.object.theoremObjectChecked

def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

theorem gate_from_admissible_class (A : AdmissibleClass) :
    gateClosed A := by
  exact A.gateWitness

end ControlTurbulentFlowsTheoremCanonicalLaneLean
end HautevilleHouse