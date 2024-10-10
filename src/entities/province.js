import express from 'express';
import cors from 'cors';
import config from '../configs/db-config.js';

class Province {
    id;
    name;
    full_name;
    latitude;
    logitude;
    display_order;
}

export default Province;
