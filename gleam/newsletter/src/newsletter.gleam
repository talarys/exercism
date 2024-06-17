import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  path
  |> simplifile.read
  |> result.map(fn(x) { x |> string.trim |> string.split("\n") })
  |> result.nil_error
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  path |> simplifile.create_file |> result.nil_error
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  simplifile.append(path, email <> "\n") |> result.nil_error
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  use emails <- result.try(read_emails(emails_path))
  use _ <- result.try(create_log_file(log_path))
  emails
  |> list.map(fn(email) {
    use _ <- result.try(send_email(email))
    log_sent_email(log_path, email)
  })
  Ok(Nil)
}
