import { profile, signIn, signUp } from "../controllers/auth.controller";
import { Router } from "express";
import { check } from "express-validator";
import { validate } from "../middlewares/validation";
import { verifyToken } from "../middlewares/verifyToken";

const router: Router = Router()

router.post('/signup',
    [
        check('name', 'el nombre de usuario es obligatorio').not().isEmpty(),
        check('email', 'el email es obligatorio').isEmail(),
        check('password', 'la contraseña debe ser mayor o igual a 8 caracteres').isLength({ min: 8 }),
        validate

    ],
    signUp)


router.post('/signin',
    [
        check('email', 'el email es obligatorio').isEmail(),
        check('password', 'la contraseña es obligatoria').isLength({ min: 8 })
    ],
    signIn)

router.get('/profile', verifyToken, profile)




export default router;