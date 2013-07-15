package tweenx909;


class EaseX {
		static inline private var PI 	= 3.1415926535897932384626433832795;
		static inline private var PI_H 	= PI / 2;
		
		
		/*
		 * LINEAR
		 */
		static public function linear(t:Float):Float{
			return t;
		}
		
		/* 
		 * SINE
		 */
		static public function sineIn(t:Float):Float {
            return 
                if ( t == 0 )       0
                else if ( t == 1 )  1
			    else                1 - Math.cos(t * PI_H);
		}
		
		static public function sineOut(t:Float):Float {
			return 
                if ( t == 0 )       0
                else if ( t == 1 )  1
			    else                Math.sin(t * PI_H);
		}
		
		static public function sineInOut(t:Float):Float {
			return 
                if ( t == 0 )       0
                else if ( t == 1 )  1
			    else                -0.5 * (Math.cos(Math.PI * t) - 1);
		}
		
		static public function sineOutIn(t:Float):Float {
			return 
                if ( t == 0 )       0
                else if ( t == 1 )  1
			    else (t < 0.5) ?
                         0.5 * Math.sin((t * 2) * PI_H) 
                        :
                        -0.5 * Math.cos((t * 2 - 1) * PI_H) + 1;
		}
		
		/*
		 * QUAD EASING
		 */
		static public function quadIn(t:Float):Float {
			return t * t;
		}
		
		static public function quadOut(t:Float):Float {
			return - t * (t - 2);
		}
		static public function quadInOut(t:Float):Float {
			return (t < 0.5) ?
				2 * t * t
				:
				-2 * ((t -= 1) * t) + 1;
		}
		static public function quadOutIn(t:Float):Float {
			return (t < 0.5) ?
				-0.5 * (t = (t * 2)) * (t - 2)
				:
				0.5 * (t = (t * 2 - 1)) * t + 0.5;
		}
		
		
		/*
		 * CUBIC EASING
		 */
		static public function cubicIn(t:Float):Float {
			return t * t * t;
		}
		static public function cubicOut(t:Float):Float {
			return (t = t - 1) * t * t + 1;
		}
		static public function cubicInOut(t:Float):Float {
			return ((t *= 2) < 1) ? 
				0.5 * t * t * t : 
				0.5 * ((t -= 2) * t * t + 2);
		}
		static public function cubicOutIn(t:Float):Float {
			return 0.5 * ((t = t * 2 - 1) * t * t + 1);
		}
		
		
		/*
		 * QUART EASING
		 */
		
		static public function quartIn(t:Float):Float {
			return t * t * t * t;
		}
		
		static public function quartOut(t:Float):Float {
			return 1 - (t = (t = t - 1) * t) * t;
		}
		
		static public function quartInOut(t:Float):Float {
			return ((t *= 2) < 1) ?
				0.5 * t * t * t * t
				:
				-0.5 * ((t -= 2) * t * t * t - 2);
		}
		
		static public function quartOutIn(t:Float):Float {
			return (t < 0.5) ?
				-0.5 * (t = t * 2 - 1) * t * t * t + 0.5
				:
				0.5 * (t = t * 2 - 1) * t * t * t + 0.5;
		}
		
		
		/*
		 * QUINT EASING
		 */
		static public function quintIn(t:Float):Float {
			return t * t * t * t * t;
		}
		static public function quintOut(t:Float):Float {
			return (t = t - 1) * t * t * t * t + 1;
		}
		static public function quintInOut(t:Float):Float {
			return ((t *= 2) < 1) ? 
				0.5 * t * t * t * t * t
				:
				0.5 * (t -= 2) * t * t * t * t + 1;
		}
		static public function quintOutIn(t:Float):Float {
			return 0.5 * ((t = t * 2 - 1) * t * t * t * t + 1);
		}
		
		
		/* 
		 * EXPO EASING
		 */
		static public function expoIn(t:Float):Float {
			return t == 0 ? 0 : Math.pow(2, 10 * (t - 1));
		}
		static public function expoOut(t:Float):Float {
			return t == 1 ? 1 : (1 - Math.pow(2, -10 * t));
		}
		static public function expoInOut(t:Float):Float {
			return 	(t == 0) ? 0 :
					(t == 1) ? 1 :
					((t *= 2) < 1) ? 
						0.5 * Math.pow(2, 10 * (t - 1)) :
						0.5 * (2 - Math.pow(2, -10 * --t));
		}
		static public function expoOutIn(t:Float):Float {
			return 	(t < 0.5) ? 
						0.5 * (1 - Math.pow(2, -20 * t)) :
						(t == 0.5) ? 
							0.5 : 
							0.5 * (Math.pow(2, 20 * (t - 1)) + 1);
		}
		
		/*
		 * CIRC EASING
		 */
		static public function circIn(t:Float):Float {
			return 1 - Math.sqrt(1 - t * t);
		}
		static public function circOut(t:Float):Float {
			return Math.sqrt(t * (2 - t));
		}
		static public function circInOut(t:Float):Float {
			return ((t *= 2) < 1) ?
				-0.5 * (Math.sqrt(1 - t * t) - 1)
				:
				0.5 * (Math.sqrt(1 - (t -= 2) * t) + 1);
		}
		static public function circOutIn(t:Float):Float {
			return (t < 0.5) ?
				0.5 * Math.sqrt(1 - (t = t * 2 - 1) * t)
				:
				-0.5 * ((Math.sqrt(1 - (t = t * 2 - 1) * t) - 1) - 1);
		}
		
		
		/*
		 * BOUNCE EASING
		 */
		static public function bounceIn(t:Float):Float {
			if ((t = 1 - t) < (1 / 2.75)) 	return 1 - ((7.5625 * t * t));
			if (t < (2 / 2.75))             return 1 - ((7.5625 * (t -= (1.5 / 2.75)) * t + 0.75));
			if (t < (2.5 / 2.75))           return 1 - ((7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375));
			                                return 1 - ((7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375));
		}
		static public function bounceOut(t:Float):Float {
			if (t < (1 / 2.75)) 	return (7.5625 * t * t);
			if (t < (2 / 2.75))     return (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75);
			if (t < (2.5 / 2.75))   return (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375);
			                        return (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375);
		}
		static public function bounceInOut(t:Float):Float {
			if (t < 0.5){
				if ((t = (1 - t * 2)) < (1 / 2.75)) 	return (1 - ((7.5625 * t * t))) * 0.5;
				if (t < (2 / 2.75))                     return (1 - ((7.5625 * (t -= (1.5 / 2.75)) * t + 0.75))) * 0.5;
				if (t < (2.5 / 2.75))                   return (1 - ((7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375))) * 0.5;
				                                        return (1 - ((7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375))) * 0.5;
			}else{
				if ((t = (t * 2 - 1)) < (1 / 2.75)) 	return ((7.5625 * t * t)) * 0.5 + 0.5;
				if (t < (2 / 2.75))                     return ((7.5625 * (t -= (1.5 / 2.75)) * t + 0.75)) * 0.5 + 0.5;
				if (t < (2.5 / 2.75))                   return ((7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375)) * 0.5 + 0.5;
				                                        return ((7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375)) * 0.5 + 0.5;
			}
		}
		static public function bounceOutIn(t:Float):Float {
			if (t < 0.5) {
				if ((t = (t * 2)) < (1 / 2.75)) 	return 0.5 * (7.5625 * t * t);
				if (t < (2 / 2.75))                 return 0.5 * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75);
				if (t < (2.5 / 2.75))               return 0.5 * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375);
				                                    return 0.5 * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375);
			}else{
				if ((t = (1 - (t * 2 - 1))) < (1 / 2.75))	return 0.5 - (0.5 * (7.5625 * t * t)) + 0.5;
				if (t < (2 / 2.75))                         return 0.5 - (0.5 * (7.5625 * (t -= (1.5 / 2.75)) * t + 0.75)) + 0.5;
				if (t < (2.5 / 2.75))                       return 0.5 - (0.5 * (7.5625 * (t -= (2.25 / 2.75)) * t + 0.9375)) + 0.5;
				                                            return 0.5 - (0.5 * (7.5625 * (t -= (2.625 / 2.75)) * t + 0.984375)) + 0.5;
			}
		}
		
		static public inline var overshoot:Float = 1.70158;
		
        /*
		 * BACK EASING
		 */
		static public function backIn(t:Float):Float {
			if ( t == 0 ) return 0;
			if ( t == 1 ) return 1;
			return t * t * ((overshoot + 1) * t - overshoot);
		}
		
		static public function backOut(t:Float):Float {
			if ( t == 0 ) return 0;
			if ( t == 1 ) return 1;
			return ((t = t - 1) * t * ((overshoot + 1) * t + overshoot) + 1);
		}
		
		static public function backInOut(t:Float):Float {
			if ( t == 0 ) return 0;
			if ( t == 1 ) return 1;
			if ((t *= 2) < 1) return 0.5 * (t * t * (((overshoot * 1.525) + 1) * t - overshoot * 1.525));
			return 0.5 * ((t -= 2) * t * (((overshoot * 1.525) + 1) * t + overshoot * 1.525) + 2);
		}
		
		static public function backOutIn(t:Float):Float {
			if ( t == 0 ) return 0;
			if ( t == 1 ) return 1;
			if (t < 0.5) return 0.5 * ((t = t * 2 - 1) * t * ((overshoot + 1) * t + overshoot) + 1);
			return 0.5 * (t = t * 2 - 1) * t * ((overshoot + 1) * t - overshoot) + 0.5;
		}
		
		/*
		 * ELASTIC EASING
		 */
		static private inline var amplitude:Float   = 1;
        static private inline var period:Float      = 0.0003;
		    
        static public function elasticIn(t:Float):Float {
			if (t == 0) return 0;
			if (t == 1) return 1;
			
			var s:Float = period / 4;
			return -(amplitude * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * 0.001 - s) * (2 * Math.PI) / period));
		}
		
		static public function elasticOut(t:Float):Float {
			if (t == 0) return 0;
			if (t == 1) return 1;
			
			var s:Float = period / 4;
			return Math.pow(2, -10 * t) * Math.sin((t * 0.001 - s) * (2 * Math.PI) / period) + 1;
		}
		
		static public function elasticInOut(t:Float):Float {
			if (t == 0) return 0;
			if (t == 1) return 1;
			
			var s:Float = period / 4;
			
			if ((t *= 2) < 1)
				return -0.5 * (amplitude * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * 0.001 - s) * (2 * Math.PI) / period));
			else
				return amplitude * Math.pow(2, -10 * (t -= 1)) * Math.sin((t * 0.001 - s) * (2 * Math.PI) / period) * 0.5 + 1;
		}
		
		static public function elasticOutIn(t:Float):Float {
			if (t < 0.5) {
				if ((t *= 2) == 0) return 0;
				var s = period / 4;
				return (amplitude / 2) * Math.pow(2, -10 * t) * Math.sin((t * 0.001 - s) * (2 * Math.PI) / period) + 0.5;
			}else{
				if (t == 0.5) 	return 0.5;
				if (t == 1) 	return 1;
				t = t * 2 - 1;
				var s = period / 4;
				return -((amplitude / 2) * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * 0.001 - s) * (2 * Math.PI) / period)) + 0.5;
			}
		}
}