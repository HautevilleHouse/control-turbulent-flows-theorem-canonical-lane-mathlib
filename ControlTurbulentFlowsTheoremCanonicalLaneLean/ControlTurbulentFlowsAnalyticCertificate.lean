import ControlTurbulentFlowsTheoremCanonicalLaneLean.RegularityEndpointLayer

namespace HautevilleHouse
namespace ControlTurbulentFlowsTheoremCanonicalLaneLean

structure ControlTurbulentFlowsAnalyticCertificate where
  substrate : MathlibPDESubstrate
  operatorsClosed : Prop
  weakLayerClosed : Prop
  energyLayerClosed : Prop
  compactnessLayerClosed : Prop
  endpointLayerClosed : Prop
  canonicalCarriageImported : Prop
  operatorsClosedProof : operatorsClosed
  weakLayerClosedProof : weakLayerClosed
  energyLayerClosedProof : energyLayerClosed
  compactnessLayerClosedProof : compactnessLayerClosed
  endpointLayerClosedProof : endpointLayerClosed
  canonicalCarriageImportedProof : canonicalCarriageImported

def sourceControlTurbulentFlowsAnalyticCertificate : ControlTurbulentFlowsAnalyticCertificate := {
  substrate := mathlibPDESubstrate
  operatorsClosed := NavierStokesEquationClosed primitiveFlow
  weakLayerClosed := LerayHopfEnvelopeClosed sourceLerayHopfEnvelope
  energyLayerClosed := EnergyEnstrophyClosed sourceEnergyEnstrophyCertificate
  compactnessLayerClosed := CompactnessRigidityClosed sourceCompactnessRigidityCertificate
  endpointLayerClosed := RegularityEndpointClosed sourceRegularityEndpointCertificate
  canonicalCarriageImported := commonCoreProjectionLawAvailable ∧ commonCoreCarriageLawAvailable ∧ commonCoreIdempotenceAvailable
  operatorsClosedProof := primitive_flow_equation_closed_checked
  weakLayerClosedProof := source_leray_hopf_envelope_closed
  energyLayerClosedProof := source_energy_enstrophy_closed
  compactnessLayerClosedProof := source_compactness_rigidity_closed
  endpointLayerClosedProof := source_regularity_endpoint_closed
  canonicalCarriageImportedProof := And.intro mathlib_common_core_projection_law_checked
    (And.intro mathlib_common_core_carriage_law_checked mathlib_common_core_idempotence_checked)
}

def ControlTurbulentFlowsAnalyticCertificateClosed (C : ControlTurbulentFlowsAnalyticCertificate) : Prop :=
  C.operatorsClosed ∧
  C.weakLayerClosed ∧
  C.energyLayerClosed ∧
  C.compactnessLayerClosed ∧
  C.endpointLayerClosed ∧
  C.canonicalCarriageImported

theorem source_control_turbulent_flows_analytic_certificate_closed :
    ControlTurbulentFlowsAnalyticCertificateClosed sourceControlTurbulentFlowsAnalyticCertificate := by
  exact And.intro sourceControlTurbulentFlowsAnalyticCertificate.operatorsClosedProof
    (And.intro sourceControlTurbulentFlowsAnalyticCertificate.weakLayerClosedProof
      (And.intro sourceControlTurbulentFlowsAnalyticCertificate.energyLayerClosedProof
        (And.intro sourceControlTurbulentFlowsAnalyticCertificate.compactnessLayerClosedProof
          (And.intro sourceControlTurbulentFlowsAnalyticCertificate.endpointLayerClosedProof
            sourceControlTurbulentFlowsAnalyticCertificate.canonicalCarriageImportedProof))))

end ControlTurbulentFlowsTheoremCanonicalLaneLean
end HautevilleHouse
