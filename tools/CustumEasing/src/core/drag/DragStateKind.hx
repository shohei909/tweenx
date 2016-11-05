package core.drag;
import component.basic.NumberSliderDrag;
import component.complex.ComplexEasingDrag;

enum DragStateKind 
{
    NumberSlider(detail:NumberSliderDrag);
    ComplexEasing(detail:ComplexEasingDrag);
}