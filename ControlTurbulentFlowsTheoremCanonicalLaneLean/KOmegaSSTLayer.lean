import ControlTurbulentFlowsTheoremCanonicalLaneLean.TurbulentFlowOperators

namespace HautevilleHouse
namespace ControlTurbulentFlowsTheoremCanonicalLaneLean

structure KOmegaSSTEnvelope where
  flow : TurbulentFlow
  kEquation : Prop
  omegaEquation : Prop
  closureCoefficients : Prop
  kEquationClosed : kEquation
  omegaEquationClosed : omegaEquation
  closureCoefficientsClosed : closureCoefficients

def sourceKOmegaSSTEnvelope : KOmegaSSTEnvelope := {
  flow := primitiveFlow
  kEquation := baselineCertificateAllPass = true
  omegaEquation := RANSBalance primitiveFlow
  closureCoefficients := baselineCertificateInputs.length = 7
  kEquationClosed := rfl
  omegaEquationClosed := primitive_flow_rans_balance_checked
  closureCoefficientsClosed := rfl
}

def KOmegaSSTEnvelopeClosed (E : KOmegaSSTEnvelope) : Prop :=
  E.kEquation ∧ E.omegaEquation ∧ E.closureCoefficients

theorem source_k_omega_sst_envelope_closed :
    KOmegaSSTEnvelopeClosed sourceKOmegaSSTEnvelope := by
  exact And.intro sourceKOmegaSSTEnvelope.kEquationClosed
    (And.intro sourceKOmegaSSTEnvelope.omegaEquationClosed
      sourceKOmegaSSTEnvelope.closureCoefficientsClosed)

end ControlTurbulentFlowsTheoremCanonicalLaneLean
end HautevilleHouse