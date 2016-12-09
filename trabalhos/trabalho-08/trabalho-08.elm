import Html exposing (text)

type alias Env = (String -> Int)
zero: Env
zero = \ask -> 0

type Exp = Var String
         | Add  Exp Exp
         | Sub  Exp Exp
         | Mult Exp Exp
         | Divi Exp Exp
         | Numero Int

type Prog = Attr String Exp
          | Seq Prog Prog
          | If Exp Prog Prog
          | While Exp Prog

evalExp : Exp -> Env -> Int
evalExp exp env =
    case exp of
        Var var        -> (env var)
        Add exp1 exp2  -> (evalExp exp1 env) + (evalExp exp2 env)
        Sub exp1 exp2  -> (evalExp exp1 env) - (evalExp exp2 env)
        Mult exp1 exp2 -> (evalExp exp1 env) * (evalExp exp2 env)
        Divi exp1 exp2 -> (evalExp exp1 env) // (evalExp exp2 env)
        Numero n       -> n

evalProg : Prog -> Env -> Env
evalProg s env =
    case s of
        Seq s1 s2 ->
            (evalProg s2 (evalProg s1 env))
        Attr var exp ->
            let
                val = (evalExp exp env)
            in
                \ask -> if ask == var then val else (env ask)
        If exp prog1 prog2 ->
            if (evalExp exp env) /= 0 then
              (evalProg prog1 env)
            else
              (evalProg prog2 env)
        While exp prog ->
            if (evalExp exp env) /= 0 then
              (evalProg (While exp prog) (evalProg prog env))
            else
              env


lang : Prog -> Int
lang p = ((evalProg p zero) "ret")

p1 : Prog
p1 = (Attr "ret" (Sub (Numero 10) (Numero 5)))


p2: Prog
p2 = Seq
          (Attr "x" (Numero 0))
          (If (Var "x")
              (Attr "ret" (Var "x"))
              (Attr "ret" (Numero 2)))

p3 : Prog
p3 = Seq
        (Attr "i" (Numero 5))
        (While (Var "i")
          (Seq
            (Attr "ret" (Add (Var "ret") (Numero 4)))
            (Attr "i" (Sub (Var "i") (Numero 1)))))

p4 : Prog
p4 = Seq
        (Seq
          (Attr "x" (Sub  (Numero 15) (Numero 7)))
          (Attr "y" (Divi (Numero 64) (Numero 8))))
        (Attr "ret" (Add (Var "x") (Var "y")))


--main = text (toString (lang p1))
--main = text (toString (lang p2))
--main = text (toString (lang p3))
main = text (toString (lang p4))
