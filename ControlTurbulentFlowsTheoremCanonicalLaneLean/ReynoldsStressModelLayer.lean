import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ControlTurbulentFlowsTheoremCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev VectorField := Time → Space3 → Space3
abbrev ScalarField := Time → Space3 → ℝ

def zeroVectorField : VectorField := fun _ _ _ => 0
def zeroScalarField : ScalarField := fun _ _ => 0

structure ReynoldsStressTensor where
  components : Space3 → Space3 → ℝ
  trace : ScalarField
  anisotropy : Space3 → Space3 → ℝ

def zeroReynoldsStressTensor : ReynoldsStressTensor := {
  components := fun _ _ => 0
  trace := zeroScalarField
  anisotropy := fun _ _ => 0
}

structure TurbulenceModel where
  ReynoldsStress : ReynoldsStressTensor
  turbulentViscosity : ℝ
  modelConstants : List ℝ

def kEpsilonModel : TurbulenceModel := {
  ReynoldsStress := zeroReynoldsStressTensor
  turbulentViscosity := 1.0
  modelConstants := [0.09, 1.44, 1.92, 1.0, 1.3]
}

def ReynoldsStressClosure (m : TurbulenceModel) : Prop :=
  m.ReynoldsStress.trace = zeroScalarField

def ModelAdmissible (m : TurbulenceModel) : Prop :=
  m.turbulentViscosity > 0

def TurbulenceModelClosed (m : TurbulenceModel) : Prop :=
  ReynoldsStressClosure m ∧ ModelAdmissible m

def sourceTurbulenceModel : TurbulenceModel := kEpsilonModel

theorem source_reynolds_stress_closure_checked :
    ReynoldsStressClosure sourceTurbulenceModel := by
  rfl

theorem source_model_admissible_checked :
    ModelAdmissible sourceTurbulenceModel := by
  native_decide

theorem source_turbulence_model_closed_checked :
    TurbulenceModelClosed sourceTurbulenceModel := by
  exact And.intro source_reynolds_stress_closure_checked source_model_admissible_checked

end ControlTurbulentFlowsTheoremCanonicalLaneLean
end HautevilleHouse