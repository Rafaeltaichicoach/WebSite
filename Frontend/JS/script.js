//function pintar(color) {
//    elemento = document.querySelector("body");
//    elemento.style.backgroundColor = color;
//}

//function agregarBordes(elementId) {
//    elemento = document.querySelector('#' + elementId);
//    elemento.style.border="dashed 3px brown"
//}

// Carrito de compras
let carrito = [];

function agregarAlCarrito(nombreProducto, precio) {
    carrito.push({ nombre: nombreProducto, precio: precio });
    actualizarCarrito();
}

function actualizarCarrito() {
    const carritoCantidad = document.getElementById('carrito-cantidad');
    const carritoLista = document.getElementById('carrito-lista');
    const carritoVacio = document.getElementById('carrito-vacio');
    const carritoTotal = document.getElementById('carrito-total');
    carritoCantidad.textContent = carrito.length;
    carritoLista.innerHTML = '';
    let total = 0;
    if (carrito.length === 0) {
        carritoVacio.style.display = 'block';
        carritoTotal.textContent = 'Total: $0';
    } else {
        carritoVacio.style.display = 'none';
        carrito.forEach((producto, idx) => {
            const li = document.createElement('li');
            li.textContent = producto.nombre + ' - $' + producto.precio.toLocaleString('es-CL');
            carritoLista.appendChild(li);
            total += producto.precio;
        });
        carritoTotal.textContent = 'Total: $' + total.toLocaleString('es-CL');
    }
}
"Efecto palanca"
function toggleCarrito() {
    const carritoDiv = document.getElementById('carrito');
    carritoDiv.style.display = carritoDiv.style.display === 'none' ? 'block' : 'none';
}

 const form = document.getElementById('formAgregar');
    const contenedor = document.getElementById('contenedor');
    const btnCargar = document.getElementById('btnCargar');
    const mensajeVacio = document.getElementById('mensajeVacio');

    async function cargarMonedas() {
      const res = await fetch('/productos');
      const datos = await res.json();

      contenedor.innerHTML = '';
      if (datos.length === 0) {
        mensajeVacio.textContent = 'No hay monedas registradas.';
        return;
      } else {
        mensajeVacio.textContent = '';
      }

      datos.forEach(m => {
        const card = document.createElement('div');
        card.classList.add('card');
        card.innerHTML = `
          <h3>${m.nombre_producto}</h3>
          <p class="valor">$${m.precio}</p>
        `;
        contenedor.appendChild(card);
      });
    }

    // form.addEventListener('submit', async e => {
    //   e.preventDefault();
    //   const nombre = document.getElementById('nombre').value.trim();
    //   const valor = document.getElementById('valor').value.trim();

    //   if (!nombre || !valor) return alert('Completa ambos campos');

      // await fetch('/productos', {
      //   method: 'POST',
      //   headers: { 'Content-Type': 'application/json' },
      //   body: JSON.stringify({ nombre, valor })
      // });

       form.reset();
     cargarMonedas();
   // })
    ;

    btnCargar.addEventListener('click', cargarMonedas);

    document.querySelectorAll('.tarjeta').forEach(t => {
      t.addEventListener('mouseenter', () => {
        t.style.transform = 'scale(1.05)';
      });
      t.addEventListener('mouseleave', () => {
        t.style.transform = 'scale(1)';
      });
    });

// const tarjeta = document.createElement('div');
// tarjeta.className = 'tarjeta';
// tarjeta.innerHTML = `
//   <h3>${nombre}</h3>
//   <p>EDP 100 ml</p>
//   <p>$${valor}</p>
// `;
// contenedor.appendChild(tarjeta);

fetch('/api/perfumes')
  .then(res => res.json())
  .then(data => {
    data.forEach(perfume => {
      const tarjeta = document.createElement('div');
      tarjeta.className = 'tarjeta';
      tarjeta.innerHTML = `
        <h3>${perfume.nombre}</h3>
        <p>EDP 100 ml</p>
        <p>$${perfume.valor}</p>
      `;
      contenedor.appendChild(tarjeta);
    });
  });

  tarjeta.className = 'card text-center shadow-sm';
tarjeta.style.width = '18rem';
tarjeta.innerHTML = `
  <img src="${perfume.imagen}" class="card-img-top" alt="${perfume.nombre}">
  <div class="card-body">
    <h5 class="card-title">${perfume.nombre}</h5>
    <p class="card-text">EDP 100 ml</p>
    <p class="card-text fw-bold text-primary">$${perfume.valor}</p>
    <button class="btn btn-outline-primary" onclick="agregarAlCarrito('${perfume.nombre}', ${perfume.valor})">Agregar al carrito</button>
  </div>
`;
