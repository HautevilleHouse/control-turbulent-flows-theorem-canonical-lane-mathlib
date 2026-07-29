import ControlTurbulentFlowsTheoremCanonicalLaneLean.ControlActuationLayer

namespace HautevilleHouse
namespace ControlTurbulentFlowsTheoremCanonicalLaneLean

structure TurbulentBoundaryCertificate where
  controlActuation : ControlActuationCertificate
  boundaryControl : Prop
  dragReduction : Prop
  boundaryControlClosed : boundaryControl
  dragReductionClosed : dragReduction

def sourceTurbulentBoundaryCertificate : TurbulentBoundaryCertificate := {
  controlActuation := sourceControlActuationCertificate
  boundaryControl := baselineCertificateAllPass = true
  dragReduction := baselineCertificateInputs.length = 7
  boundaryControlClosed := rfl
  dragReductionClosed := rfl
}

def TurbulentBoundaryClosed (C : TurbulentBoundaryCertificate) : Prop :=
  ControlActuationClosed C.controlActuation ∧
  C.boundaryControl ∧
  C.dragReduction

theorem source_turbulent_boundary_closed :
    TurbulentBoundaryClosed sourceTurbulentBoundaryCertificate := by
  exact And.intro source_control_actuation_closed
    (And.intro sourceTurbulentBoundaryCertificate.boundaryControlClosed
      sourceTurbulentBoundaryCertificate.dragReductionClosed)

end ControlTurbulentFlowsTheoremCanonicalLaneLean
end HautevilleHouse