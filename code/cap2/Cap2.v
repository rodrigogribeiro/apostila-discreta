(** Lógica proposicional em Coq **)

Require Import List Arith_base.

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

Section Semantics.
  (* Definição dos conectivos *)

  Definition negB (a : bool) : bool := if a then false else true.

  Definition andB (a b : bool) : bool :=
    match a, b with
      | true , b' => b'
      | false , _ => false
    end.

  Definition orB (a b : bool) : bool :=
    match a , b with
      | false, b' => b'
      | true, _   => true
    end.

  Definition implB(a b : bool) : bool :=
    match a , b with
      | true , false => false
      | _ , _        => true
    end.

  Definition iffB (a  b : bool) : bool :=
    match a , b with
      | false, false => true
      | true , true  => true
      | _ , _ => false
    end.

  (*  Definição da semântica *)

  Fixpoint vars' (f : Formula) (m : list nat) : list nat :=
    match f with
      | Falsum => m
      | Verum  => m
      | Var v  => if In_dec eq_nat_dec v m then m else v :: m
      | Not f' => vars' f' m
      | And l r => vars' r (vars' l m)
      | Or l r => vars' r (vars' l m)
      | Implies l r => vars' r (vars' l m)
      | Iff l r => vars' r (vars' l m)
    end.

  Definition vars (f : Formula) : list nat := vars' f nil.

  Definition Assign : Set := list bool.

  Fixpoint eval (a : Assign)(f : Formula) : bool :=
    match f with
      | Falsum => false
      | Verum => true
      | Var v => nth v a false
      | Not f' => negB (eval a f')
      | And l r => andB (eval a l) (eval a r)
      | Or l r => orB (eval a l) (eval a r)
      | Implies l r => implB (eval a l) (eval a r)
      | Iff l r => iffB (eval a l) (eval a r)
    end.

   (** exemplo **)

  Definition assignEx40 : Assign := true :: true :: false :: nil.
  Definition formulaEx40 : Formula := Implies (Not (Var 0)) (And (Var 1) (Var 2)).

  Eval compute in eval assignEx40 formulaEx40.
End Semantics.