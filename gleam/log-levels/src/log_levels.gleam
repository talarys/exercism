import gleam/string

pub fn message(log_line: String) -> String {
  case log_line {
    "[INFO]:" <> message -> message
    "[ERROR]:" <> message -> message
    "[WARNING]:" <> message -> message
    _ -> log_line
  }
  |> string.trim()
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[INFO]" <> _ -> "info"
    "[ERROR]" <> _ -> "error"
    "[WARNING]" <> _ -> "warning"
    _ -> "info"
  }
  |> string.trim()
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " " <> "(" <> log_level(log_line) <> ")"
}
