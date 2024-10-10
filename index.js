import express from 'express';
import cors from 'cors';
import config from './src/configs/db-config.js';
import pkg from 'pg';
/*import aux from './src/entities/province.js' */
import ProvinceRouter from './src/controllers/province-controller.js';
import EventRouter from './src/controllers/event-controller.js';
import EventLocationRouter from './src/controllers/event-location-controller.js';
import LocationRouter from './src/controllers/location-controller.js';
import UserRouter from './src/controllers/user-controller.js';
import EventCategoryRouter from './src/controllers/event-category-router.js';

const app = express();
const port = 4000;

app.use(cors());
app.use(express.json());

app.use('/api/event', EventRouter);
app.use('/api/province', ProvinceRouter);
app.use('/api/event-location', EventLocationRouter);
app.use('/api/location', LocationRouter);
app.use('/api/user', UserRouter);
app.use('/api/event-category', EventCategoryRouter);

app.listen(port, () => {
    console.log(`Servidor escuchando en el puerto ${port}`);
});