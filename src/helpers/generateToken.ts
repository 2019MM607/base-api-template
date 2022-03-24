import jwt from 'jsonwebtoken'


export const getToken = (id_user: number, email: string) => {

    return new Promise((resolve, reject) => {

        const payload = { id_user, email }

        jwt.sign(payload, process.env.SECRET || 'SECRET_KEY_FOR_AUTH', {
            expiresIn: '10s'
        }, (err, token) => {
            err && reject('No token created')

            resolve(token)
        })

    })

}