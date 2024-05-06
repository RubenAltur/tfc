// Importamos las bibliotecas ExpressJS y body-parser
import express from 'express';
import pkg from 'body-parser';
const {urlencoded, json} = pkg;
import { obtindreCarrefour,obtindreMasymas,obtindreMercadona } from './controllers/llistesController.js';
// Definimos app como una aplicación express, utilizando el método 
// de factoría express().
const app = express();

// Configuramos la aplicación para que descodifique 
// las peticiones del cliente y las pase a JSON.
app.use(urlencoded({ extended: true }));
app.use(json());

// Configuramos el servidor para escuchar por el puerto  8080
// Observad que el primer argumento es el puerto y el segundo
// es un callback que se lanza cuando se ha iniciado el servidor.
app.listen(8080, () => {
    console.log('Escuchando por el puerto 8080')
});

// Definimos el endpoint "/" para peticiones GET
// Observad que la función `get` requiere dos argumentos,
// el primero el "endpoint" y el segundo es un callback 
// que se invoca cuando se recibe una petición (req). En 
// esta función, en lugar de devolver un resultado con return
// lo que hacemos es enviarlo a través de la respuesta (res).
function DefaultController(req, res){
    res.send('Error 404. Not Found');
}
const router = express.Router();

router.get('/mercadona', obtindreMercadona);

router.get('/carrefour', obtindreCarrefour);

router.get('/masymas', obtindreMasymas);

app.use("/api/llistes", router);
app.use('*', DefaultController);