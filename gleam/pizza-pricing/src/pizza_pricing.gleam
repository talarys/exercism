// TODO: please define the Pizza custom type
pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(p) -> 1 + pizza_price(p)
    ExtraToppings(p) -> 2 + pizza_price(p)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  case order {
    [] -> 0
    [a] -> 3 + pizza_price(a)
    [a, b] -> 2 + pizza_price(a) + pizza_price(b)
    [a, b, c] -> pizza_price(a) + pizza_price(b) + pizza_price(c)
    [a, ..rest] -> pizza_price(a) + order_price(rest)
  }
}
