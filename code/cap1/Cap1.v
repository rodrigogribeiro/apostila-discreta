(**

Código de exemplo para o Capítulo 1 da apostila.

*)


(* Definição de valores booleanos *)

Inductive Bool : Set :=
   | T : Bool
   | F : Bool.

(* Números naturais *)

Inductive Nat : Set :=
  | Zero : Nat
  | Suc  : Nat -> Nat.

(* Exemplos *)

Definition three : Nat := Suc (Suc (Suc Zero)).
Definition five  : Nat := Suc (Suc three).

(* Listas *)

Inductive List (T : Set) : Set :=
  | Nil  : List T
  | Cons : T -> List T -> List T.

(* alguns exemplos de listas *)

Definition list0 : List Bool := Cons Bool T (Cons Bool F (Nil Bool)).

(* açúcar sintático para listas *)

Arguments Nil {T}.
Arguments Cons {T} _ _.

Notation "x :: l" := (Cons x l) (at level 60, right associativity).
Notation "[ ]" := Nil.

(* listas usando açúcar sintático *)

Definition list1 : List Bool := Cons T (Cons F Nil).
Definition list2 : List Bool := T :: F :: [].

(* Definipes semânticas *)

Definition BoolSem (b : Bool) : nat :=
  match b with
    | T => 1
    | F => 0
  end.

(* teste *)

Eval compute in BoolSem T.

Fixpoint NatSem (n : Nat) : nat :=
  match n with
    | Zero  => 0
    | Suc n => 1 + NatSem n
  end.

(* teste da semântica de números naturais *)

Eval compute in NatSem five.

(* funções sobre listas *)

Fixpoint length {T} (l : List T) : nat :=
  match l with
    | []      => 0
    | t :: ts => 1 + length ts
  end.

Fixpoint app {T} (l l' : List T) : List T :=
  match l with
    | []      => l'
    | t :: ts => t :: (app ts l')
  end.