window.addEventListener('message', function(event) {
    if (event.data.type === 'updateHUD') {
        // Asegurarse de que el HUD esté visible
        document.getElementById('hud').style.display = 'block';

        // Actualizar texto
        document.getElementById('money').children[1].textContent = '$' + event.data.money;
        document.getElementById('bank').children[1].textContent = '$' + event.data.bank;
        document.getElementById('job').children[1].textContent = event.data.job;
        document.getElementById('rank').children[1].textContent = event.data.rank || 'No asignado'; // Actualiza el grado


        // Agregar clases específicas para el color de dinero y trabajo
        document.getElementById('money').classList.add('money'); // Agregar clase 'money'
        document.getElementById('job').classList.add('work'); // Agregar clase 'work'
        document.getElementById('bank').classList.add('bank'); // Agregar clase 'bank'

        // Mostrar/ocultar velocímetro y combustible según la variable showSpeed
        if (event.data.showSpeed) {
            document.getElementById('speed').style.display = 'block';
            // Mostrar velocidad en km/h y RPM
            document.getElementById('speed').children[1].textContent = Math.round(event.data.speed) + ' km/h';  

            // Actualizar barra de progreso de RPM (0 - 6000 RPM)
            const rpmPercentage = (event.data.rpm / 6000) * 100;  // Ajustamos la barra a un rango de 0 a 6000
            updateBar('speed-bar', rpmPercentage, '#ff4081');

            // Mostrar recuadro de combustible
            document.getElementById('fuel').style.display = 'block';
            const fuelPercentage = (event.data.fuel / 100) * 100; // Convierte el nivel de combustible a porcentaje
            updateBar('fuel-bar', fuelPercentage, '#c340ff'); // Azul para el combustible
        } else {
            document.getElementById('speed').style.display = 'none'; // Ocultar velocímetro si no está en un vehículo
            document.getElementById('fuel').style.display = 'none'; // Ocultar combustible
        }

        // Actualizar barras de progreso
        updateBar('health-bar', event.data.health, '#ff4081'); // Salud (rojo)
        updateBar('hunger-bar', event.data.hunger, '#ffb84d'); // Hambre (amarillo)
        updateBar('thirst-bar', event.data.thirst, '#66ccff'); // Sed (azul)
    }

    // Escuchar el mensaje para ocultar el HUD
    if (event.data.type === 'hideHUD') {
        document.getElementById('hud').style.display = 'none'; // Ocultar el HUD
    }
});


function updateBar(barId, value, color) {
    const bar = document.getElementById(barId);
    const percentage = value; // El valor ya debe estar entre 0 y 100

    // Cambiar el color de la barra según el valor
    const barFill = bar.querySelector('span') || document.createElement('span');
    bar.innerHTML = ''; // Limpiar el contenido anterior
    bar.appendChild(barFill);

    barFill.style.width = percentage + '%';
    barFill.style.backgroundColor = color;
}
