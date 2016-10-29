package core.focus;
import component.basic.NumberInputFocus;
import component.complex.ComplexEasingSelectFocus;
import component.complex.ComplexEasingId;

enum FocusState 
{
	ComplexEasingSelect(detail:ComplexEasingSelectFocus);
	NumberInput(detail:NumberInputFocus); 
	None;
}