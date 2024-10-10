import pkg from 'pg'
import config from '../configs/db-config.js';
import jwt from 'jsonwebtoken';
import {token} from '../repositories/user-repository.js';
const { Client } = pkg
const client = new Client(config);

await client.connect();
export default class LocationRepository {
    
    getAllAsync = async () => {
       
        let sql = `select l.id,l.name,p.*,l.latitude,l.longitude from locations l inner join provinces p on l.id_province = p.id`;
        let result = await client.query(sql)
        const Location = result.rows;
        return Location
    }
    getByIdAsync = async (id) => {
        
        let sql = `SELECT l.id, l.name, p.*, l.latitude, l.longitude 
        FROM locations l 
        INNER JOIN provinces p ON l.id_province = p.id 
        WHERE l.id = $1 
        LIMIT 1`;
        
        let values = [id];
        let result = await client.query(sql, values)
        let Location = result.rows;
        console.log(Location);
        return Location
    }
    getLocationByIdAsync = async (id) => {
        
        const secretKey = "ClaveSecreta3000$";
        let validacionToken = token; 
        let payloadOriginal = null;
        let resArray;
        try{
            payloadOriginal = await jwt.verify(validacionToken,secretKey);
            
            if(payloadOriginal != null){
                console.log(payloadOriginal)
                let sql = `select el.* from locations l inner join event_locations el on l.id = l.id WHERE el.id_location=$1`;
                const values = [id];
                let result = await client.query(sql, values)
                const Location = result.rows;
                if (Location != '') {
            
                    resArray = [Location,200];;
                } else {
                resArray = ["Ubicacion no encontrada",404];
                }
            }
            else{
                console.log(e);
            resArray = ["Unauthorized",401];
            }
            
        }catch(e){
            console.log(e);
            resArray = ["Unauthorized",401];
        }
        
        return resArray;
        
    }
}