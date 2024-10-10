import express from 'express';
import cors from 'cors';
import config from '../configs/db-config.js';
import pkg from 'pg';
const { Client } = pkg

class Event
{
    id;
    name;
    description;
    id_event_category;
    id_event_location;
    start_date;
    duration_in_minutes;
    price;
    enabled_for_enrollment;
    max_assistance;
    id_creator_user;
}

export default Event
