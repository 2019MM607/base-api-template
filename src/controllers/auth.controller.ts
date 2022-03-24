import { Request, Response } from 'express'
import { encryptPassword } from '../helpers/encryptPassword';
import { pool } from "../database/pool";

import bcrypt from 'bcryptjs'
import { getToken } from '../helpers/generateToken';



export const signUp = async (req: Request, res: Response) => {

    const { name, email, password } = req.body

    try {

        //verificar que ese email no esté en uso

        const userExists = await pool.query(
            "SELECT  u_email FROM users WHERE u_email = $1",
            [email]);

        // guardar usuario e incriptar contraseña

        if (userExists.rowCount > 0) {
            return res.status(201).json({ ok: false, msg: 'el email ya existe' })

        }

        const encrypted = encryptPassword(password)
        await pool.query('INSERT INTO users (u_name, u_email, u_password) VALUES($1, $2, $3)', [name, email, encrypted])

        const getNewUser = await pool.query('SELECT id_user, u_name, u_email FROM users WHERE u_email = $1', [email])


        //token
        const token = await getToken(getNewUser.rows[0].id_user, getNewUser.rows[0].u_email) as string
        res.header('auth-token', token).status(200).json({
            ok: true,
            name: getNewUser.rows[0].u_name,
            email: getNewUser.rows[0].u_email,
            token
        })






    } catch (error) {
        res.status(400).json({ ok: false, error })

    }
}


export const signIn = async (req: Request, res: Response) => {

    const { email, password } = req.body

    try {
        const userExists = await pool.query(
            "SELECT id_user, u_name, u_email, u_password FROM users WHERE u_email = $1",
            [email]);


        if (userExists.rowCount == 0) {
            return res.status(201).json({ ok: false, msg: 'el email no existe' })
        }

        const validPassword = bcrypt.compareSync(password, userExists.rows[0].u_password)

        if (!validPassword) {
            return res.status(201).json({
                ok: false,
                msg: "contraseña incorrecta",
            });
        }



        //token
        const token = await getToken(userExists.rows[0].id_user, userExists.rows[0].u_email) as string
        res.header('auth-token', token).status(200).json({
            ok: true,
            name: userExists.rows[0].u_name,
            email: userExists.rows[0].u_email,
            token
        })


    } catch (error) {
        res.status(500).json({ ok: false, error })
    }




}


export const profile = async (req: Request, res: Response) => {

    const user = await pool.query('SELECT * FROM users WHERE id_user = $1', [req.id_user])

    if (!user) {
        res.status(400).json({ ok: false })
    }

    res.status(200).json({ ok: true, data: user.rows })

}

