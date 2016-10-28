package core.focus;
import component.basic.RateInputFocus;
import component.complex.ComplexEasingSelectFocus;
import component.simple.InOutSelectFocus;
import component.complex.ComplexEasingId;

enum FocusState 
{
	ComplexEasingSelect(detail:ComplexEasingSelectFocus);
	InOutSelect(detail:InOutSelectFocus);
	RateInput(detail:RateInputFocus); 
	None;
}