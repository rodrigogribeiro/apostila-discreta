(** Lógica proposicional em Coq **)

(** Sintaxe da lógica proposicional *)

Section Syntax.

  Inductive Formula : Set :=
     | Falsum  : Formula
     | Verum : Formula
     | Var : nat -> Formula
     | Not : Formula -> Formula
     | And  : Formula -> Formula -> Formula
     | Or    : Formula -> Formula -> Formula
     | Implies : Formula -> Formula -> Formula
     | Iff  : Formula -> Formula -> Formula.

  (** Notações para o tipo fórmula *)

  Notation "# n" := (Var n) (at level 40).
  Notation ":~ A" := (Not A)(at level 40).
  Notation "A '&' B" := (And A B)(at level 50, left associativity).
  Notation "A '|' B" := (Or A B)(at level 50, left associativity).
  Notation "A '->>' B" := (Implies A B)(at level 60, right associativity).
  Notation "A '<<->>' B" := (Iff A B)(at level 70, right associativity).

  (* Alguns exemplos *)

  Definition exemplo1 : Formula := Implies (Not (Var 0)) (Var 1).
  Definition exemplo1' : Formula := :~ (# 0) ->> (# 1).
  (* Uma definição incorreta:

  Definition exemplo2 : Formula := :~ ((# 0) |).

  esta representa um termo sintaticamente incorreto e, é rejeitada  por Coq.
  *)
End Syntax.