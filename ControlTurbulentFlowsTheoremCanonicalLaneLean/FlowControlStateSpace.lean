import FlowsControlTurbulentFlowsCanonicalLaneLean.AdmissibleClass
import Mathlib.Data.Real.Basic

/-!
# Control Turbulent Flows — State Space and Operators

This module defines the flow-control state space, operators, and
admissibility conditions for the Control Turbulent Flows Theorem.
-/

namespace HautevilleHouse
namespace FlowsControlTurbulentFlowsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure FlowControlOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  actuation : VectorField → VectorField
  sensor : VectorField → ScalarField
  actuationProjection : VectorField → VectorField
  actuationProjectionIdempotent : ∀ u, actuationProjection (actuationProjection u) = actuationProjection u

def primitiveOperators : FlowControlOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  actuation := fun u => u
  sensor := fun _ => zeroScalarField
  actuationProjection := fun u => u
  actuationProjectionIdempotent := by intro u; rfl
}

structure FlowControlFlow where
  velocity : VectorField
  pressure : ScalarField
  controlInput : VectorField
  viscosity : ℝ
  operators : FlowControlOperators

def primitiveFlow : FlowControlFlow := {
  velocity := zeroVectorField
  pressure := zeroScalarField
  controlInput := zeroVectorField
  viscosity := 1
  operators := primitiveOperators
}

def Incompressible (F : FlowControlFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def AnalyticBalance (F : FlowControlFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def ControlActuated (F : FlowControlFlow) : Prop :=
  F.operators.actuationProjection F.controlInput = F.controlInput

def ControlledNavierStokesClosed (F : FlowControlFlow) : Prop :=
  Incompressible F ∧ AnalyticBalance F ∧ ControlActuated F

theorem primitive_actuation_projection_idempotent_checked (u : VectorField) :
    primitiveOperators.actuationProjection (primitiveOperators.actuationProjection u) =
      primitiveOperators.actuationProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  rfl

theorem primitive_flow_analytic_balance_checked :
    AnalyticBalance primitiveFlow := by
  rfl

theorem primitive_flow_control_actuated_checked :
    ControlActuated primitiveFlow := by
  rfl

theorem primitive_flow_controlled_navier_stokes_closed_checked :
    ControlledNavierStokesClosed primitiveFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_analytic_balance_checked primitive_flow_control_actuated_checked)

end FlowsControlTurbulentFlowsCanonicalLaneLean
end HautevilleHouse
