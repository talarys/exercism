import gleam/bit_array
import gleam/io
import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0 -> Ok(Adenine)
    1 -> Ok(Cytosine)
    2 -> Ok(Guanine)
    3 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.map(encode_nucleotide)
  |> list.fold(<<>>, fn(acc, n) { <<acc:bits, n:2>> })
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  do_decode(dna, [])
}

fn do_decode(dna: BitArray, acc: List(Nucleotide)) {
  case dna {
    <<>> -> Ok(acc |> list.reverse)
    <<code:2, rest:bits>> -> {
      case decode_nucleotide(code) {
        Error(Nil) -> Error(Nil)
        Ok(nucleotide) -> do_decode(rest, [nucleotide, ..acc])
      }
    }
    _ -> Error(Nil)
  }
}
