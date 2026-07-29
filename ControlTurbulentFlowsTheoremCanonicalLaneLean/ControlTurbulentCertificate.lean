import FlowsControlTurbulentFlowsCanonicalLaneLean.StochasticForcingLayer

/-!
# Control Turbulent Flows Certificate

This module packages all layers into a single proof-carrying certificate.
-/

namespace HautevilleHouse
namespace FlowsControlTurbulentFlowsCanonicalLaneLean

structure ControlTurbulentCertificate where
  stochasticForcing : StochasticForcingCertificate
  operatorsClosed : Prop
  romClosed : Prop
  actuationClosed : Prop
  stochasticClosed : Prop
  operatorsClosedProof : operatorsClosed
  romClosedProof : romClosed
  actuationClosedProof : actuationClosed
  stochasticClosedProof : stochasticClosed

def sourceControlTurbulentCertificate : ControlTurbulentCertificate := {
  stochasticForcing := sourceStochasticForcingCertificate
  operatorsClosed := ControlledNavierStokesClosed primitiveFlow
  romClosed := ReducedOrderModelClosed sourceGalerkinProjection
  actuationClosed := ActuationBoundaryClosed sourceActuationBoundaryCertificate
  stochasticClosed := StochasticForcingClosed sourceStochasticForcingCertificate
  operatorsClosedProof := primitive_flow_controlled_navier_stokes_closed_checked
  romClosedProof := source_reduced_order_model_closed
  actuationClosedProof := source_actuation_boundary_closed
  stochasticClosedProof := source_stochastic_forcing_closed
}

def ControlTurbulentCertificateClosed (C : ControlTurbulentCertificate) : Prop :=
  C.operatorsClosed ∧
  C.romClosed ∧
  C.actuationClosed ∧
  C.stochasticClosed

theorem source_control_turbulent_certificate_closed :
    ControlTurbulentCertificateClosed sourceControlTurbulentCertificate := by
  exact And.intro sourceControlTurbulentCertificate.operatorsClosedProof
    (And.intro sourceControlTurbulentCertificate.romClosedProof
      (And.intro sourceControlTurbulentCertificate.actuationClosedProof
        sourceControlTurbulentCertificate.stochasticClosedProof))

end FlowsControlTurbulentFlowsCanonicalLaneLean
end HautevilleHouse
