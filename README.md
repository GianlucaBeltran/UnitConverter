## Glossary

- [Goal](#goal-)
- [Demo](#demo-)
- [Development](#development-)
	- [Logic](#logic-)
	- [User Interface](#uI-)
- [Improvements](#improvements-)

## Goal <a name="Goal"></a>

The goal of this project was to practice what i had learned about Swift and SwiftUI and make an app i could actually use. 

The focus of the app is to convert units, currently it converts:

- Length
- Temperature
- Mass
- Time

## Demo <a name="Demo"></a>

<img src="Images/Simulator-Screen-Recording-iPhone-14-Pro-2023-07-25-at-23.05.49.gif" alt="Demo Gif" style="width:200px;"/>

## Development <a name="Development"></a>

#### Logic <a name="Logic"></a>

> For the sake of an example i will use length units. 

First i created an enum for every unit type to avoid typos:

```Swift
enum LengthTypes: String, CaseIterable {
    case Kilometer = "Kilometer"
    case Meter = "Meter"
    case Centimeter = "Centimeter"
    case Milimiter = "Milimeter"
    case Mile = "Mile"
    case Yard = "Yard"
    case Foot = "Foot"
    case Inch = "Inch"
    case NauticalMile = "Nautical Mile"
}
```

> Every type enum follows the `String` protocol, to allow a string value for every case and the `CaseIterable` protocol, to allow for iteration of the enum in a `ForEach` or `for` loop.

The unit conversions are made through maps, to avoid unnecessary conditional logic. This is done by converting every unit into a base one, for example, in lengths every unit is converted to meters:

```Swift
let lengthConversionMap = [
	LengthTypes.Kilometer.rawValue: 1000,
	LengthTypes.Meter.rawValue: 1,
	LengthTypes.Centimeter.rawValue: 0.01,
	LengthTypes.Milimiter.rawValue: 0.001,
	LengthTypes.Mile.rawValue: 1609.34,
	LengthTypes.Yard.rawValue: 0.9144,
	LengthTypes.Foot.rawValue: 0.3048,
	LengthTypes.Inch.rawValue: 0.0254,
	LengthTypes.NauticalMile.rawValue: 1852
]
```

Once we have the conversion map we can use it in the formula:

`unitValue * fromUnit / toUnit`

So converting 10 km to miles would look like:

`10 * 1000 / 1609.34 = 6.21`

So the code would look like:

```Swift
func convertUnits(from: LengthTypes, to: LengthTypes, a:
Double) -> Double  {
    return a * (lengthConversionMap[from.rawValue] ?? 1) / (lengthConversionMap[to.rawValue] ?? 1)
}
```

> `lengthConversionMap[from.rawValue]` has to be unwrapped because Swift doesn't know if there will be a value in the map, in this case the variable is being unwrapped using 1 as a fallback value if the optional were to be `nil`

The function receives two `LengthTypes` and the value that will be converted, using the previous example the parameters would be: 
`from: kilometer, to: miles, a: 10` 

The rest of the development was focused on the UI.


#### User Interface <a name="UI"></a>

I decided to go for a one page format, using a slider to change between units that are being converted.

<img src="Images/Simulator Screenshot - iPhone 14 Pro - 2023-07-25 at 22.35.44.png" alt="Image 1" style="width:200px;"/>   <img src="Images/Simulator Screenshot - iPhone 14 Pro - 2023-07-25 at 22.43.40.png" alt="Image 2" style="width:200px;"/>   <img src="Images/Simulator Screenshot - iPhone 14 Pro - 2023-07-25 at 22.48.36.png " alt="Image 2" style="width:200px;"/>

I tried to follow the same functionality as the chrome unit converter, so both inputs works, meaning you can write directly into the `To` input and the `From` value will change and if you choose a unit from the picker that is set on the other input they will swap places retaining the value that was set in the `From` input.

## Improvements <a name="Improvements"></a>

The main thing i would improve in this project would be the view displaying logic, i would make it cleaner by avoiding the repetition of code. It would be good to revisit and make the improvements.
