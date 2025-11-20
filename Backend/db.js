const { Pool } = require('pg');

// Configuración de la base de datos
const pool = new Pool({
  user: 'postgres', // Cambiar esto por el usuario de PostgreSQL
  host: 'localhost', // Cambiar esto si la base de datos está en otro host
  database: 'Perfumes', // Cambiar esto por el nombre de la base de datos
  password: 'cft.2025', // Cambiar esto por la contraseña
  port: 5432, // Puerto por defecto de PostgreSQL
});

module.exports = pool;