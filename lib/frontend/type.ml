type t =
  | Unit
  | Bool
  | Float
  | Fun of t list * t
  | Var of t option ref

let gentyp () = Var (ref None)


(* helper function for printing a list *)
let rec pp_list = function
  | [] -> ""
  | [x] -> x
  | x :: xs -> x ^ " " ^ pp_list xs

let rec string_of_type = function
  | Unit -> "unit"
  | Bool  -> "bool"
  | Float -> "float"
  | Fun (ts, t) -> "(" ^ pp_list (List.map (string_of_type) ts) ^ " -> " ^ (string_of_type t) ^ ")"
  | Var({ contents = Some t }) -> "var-some: " ^ string_of_type t
  | Var({ contents = None }) -> "unknown"
