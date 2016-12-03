# Math.pow vs Math.exp

source code: [ExpoBenchCase.hx](src/cases/ExpoBenchCase.hx)

## Result
|   | Flash(Chrome) | Flash(Firefox) | JavaScript(Node) | JavaScript(Chrome)| JavaScript(Firefox)  | JavaScript(Edge) | C# | Java | C++ | Neko |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
|Math.pow(2, 10 * (t - 1))|484ms|792ms|887ms|870ms|504ms|2326ms|406ms|792ms|513ms|2139ms|
|Math.exp(6.931471805599453 * (t - 1))|137ms|422ms|86ms|199ms|313ms|1983ms|197ms|623ms|131ms|1739ms|
|Average error|7.492e-18|5.335e-18|1.375e-17|8.102e-18|8.095e-18|7.504e-18|7.492e-18|7.480e-18|7.486e-18|7.486e-18|

## Environment

```
OS  : Windows 10 Home (version 1607)
CPU : Intel(R) Core(TM) i7-6700HQ

Haxe           : 3.4.0-RC.1 (hxcs:3.2.0, hxjava:3.2.0, hxcpp:git_fa32f23)
node           : v4.6.1
java           : 1.8.0_111
.NET Framework : 4.0.30319.42000
Chrome         : 54.0.2840.99 m (64-bit)
Firfox         : 50.0.2
Flash Player   : 23.0.0.207
Microsoft Edge : 38.14393.0.0
```
