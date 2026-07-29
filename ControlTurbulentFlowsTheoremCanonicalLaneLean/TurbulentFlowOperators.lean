import ControlTurbulentFlowsTheoremCanonicalLaneLean.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ControlTurbulentFlowsTheoremCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure TurbulentFlowOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  pressureProjection : VectorField → VectorField
  eddyViscosity : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveOperators : TurbulentFlowOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  pressureProjection := fun u => u
  eddyViscosity := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure TurbulentFlow where
  velocity : VectorField
  pressure : ScalarField
  viscosity : ℝ
  operators : TurbulentFlowOperators

def primitiveFlow : TurbulentFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  viscosity := 1
  operators := primitiveOperators
}

def Incompressible (F : TurbulentFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def RANSBalance (F : TurbulentFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def EddyViscosityModel (F : TurbulentFlow) : Prop :=
  F.operators.eddyViscosity F.velocity = F.velocity

def PressureProjected (F : TurbulentFlow) : Prop :=
  F.operators.pressureProjection F.velocity = F.velocity

def TurbulentFlowEquationClosed (F : TurbulentFlow) : Prop :=
  Incompressible F ∧ RANSBalance F ∧ EddyViscosityModel F ∧ PressureProjected F

theorem primitive_pressure_projection_idempotent_checked (u : VectorField) :
    primitiveOperators.pressureProjection (primitiveOperators.pressureProjection u) =
      primitiveOperators.pressureProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  rfl

theorem primitive_flow_rans_balance_checked :
    RANSBalance primitiveFlow := by
  rfl

theorem primitive_flow_eddy_viscosity_model_checked :
    EddyViscosityModel primitiveFlow := by
  rfl

theorem primitive_flow_pressure_projected_checked :
    PressureProjected primitiveFlow := by
  rfl

theorem primitive_flow_equation_closed_checked :
    TurbulentFlowEquationClosed primitiveFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_rans_balance_checked
      (And.intro primitive_flow_eddy_viscosity_model_checked primitive_flow_pressure_projected_checked))

end ControlTurbulentFlowsTheoremCanonicalLaneLean
end HautevilleHouse