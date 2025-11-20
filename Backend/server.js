const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const path = require('path');

const app = express();
const port = 3000;

app.use(cors());
app.use(express.json()); // Para manejar datos JSON
app.use(express.static(path.join(__dirname, '..', 'frontend')));

// Conexión a PostgreSQL
const pool = new Pool({
  host: 'localhost',
  user: 'postgres',      // cambia si usas otro usuario
  password: 'cft.2025',  // tu contraseña
  database: 'Perfumes',
  port: 5432
});

// Probar conexión
pool.connect()
  .then(() => console.log('✅ Conectado a PostgreSQL'))
  .catch(err => console.error('❌ Error de conexión:', err));

// Ruta para obtener los productos
app.get('/productos', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM productos');
    res.json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Error en el servidor');
  }
});

// Ruta para obtener clientes
app.get('/clientes', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM clientes');
    res.json(result.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).send('Error en el servidor');
  }
});

// Iniciar el servidor
// const PORT = 5000;
// app.listen(PORT, () => {
//     console.log('Servidor corriendo en http://localhost:${PORT}');
// });

// Servir el frontend
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '..', 'frontend', 'index.html'));
});

app.listen(port, () => console.log(`🚀 Servidor en http://localhost:${port}`));