import gleam/float
import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case left, right {
    Celsius(left), Celsius(right) | Fahrenheit(left), Fahrenheit(right) ->
      float.compare(left, right)

    Celsius(left), Fahrenheit(right) ->
      float.compare(left, fahrenheit_to_celsius(right))

    Fahrenheit(left), Celsius(right) ->
      float.compare(fahrenheit_to_celsius(left), right)
  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  cities
  |> list.sort(by: fn(left, right) {
    compare_temperature(left.temperature, right.temperature)
  })
}
