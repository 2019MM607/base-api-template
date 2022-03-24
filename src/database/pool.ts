import { Pool } from 'pg'

export const pool = new Pool({
    host: 'localhost',
    user: 'postgres',
    password: 'karolg4A',
    database: 'cihem',
    port: 5432
})

