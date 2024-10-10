import pkg from "pg";
import Province from "../entities/province.js";

import config from "../configs/db-config.js";
const { Client } = pkg;
const client = new Client(config);

await client.connect();
export default class ProvinceRepository {
  getAllAsync = async () => {
    let sql = `SELECT * from provinces order by id`;
    let result = await client.query(sql);
    const provincias = result.rows;
    return provincias;
  };
  getByIdAsync = async (id) => {
    let sql = `SELECT * from provinces WHERE id=$1`;
    const values = [id];
    let result = await client.query(sql, values);
    const provincia = result.rows;
    return provincia;
  };
  createAsync = async (body) => {
    try {
        const { name, full_name, latitude, longitude, display_order } = body;

        if (!name || name.length < 3) {
            return ["El campo 'name' está vacío o tiene menos de 3 letras.", 400];
        }

        const lat = parseFloat(latitude);
        const lon = parseFloat(longitude);

        if (isNaN(lat) || isNaN(lon)) {
            return ["Los campos 'latitude' y 'longitude' deben ser números válidos.", 400];
        }

        if (lat < -90 || lat > 90) {
            return ["El campo 'latitude' debe estar entre -90 y 90.", 400];
        }

        if (lon < -180 || lon > 180) {
            return ["El campo 'longitude' debe estar entre -180 y 180.", 400];
        }

        if (isNaN(parseInt(display_order))) {
            return ["El campo 'display_order' debe ser un número entero válido.", 400];
        }

        const display_orden = parseInt(display_order);

        const sql1 = `SELECT id FROM public.provinces ORDER BY id DESC LIMIT 1;`;
        const result1 = await client.query(sql1);
        const id = result1.rows[0] ? result1.rows[0].id + 1 : 1;

        const sql = `
            INSERT INTO provinces
                (name, full_name, latitude, longitude, display_order, id)
            VALUES
                ($1, $2, $3, $4, $5, $6)`;
        const values = [name, full_name, lat, lon, display_orden, id];

        await client.query(sql, values);

        return ["Provincia creada con éxito", 201];

    } catch (error) {
        console.error("Error en la creación de la provincia:", error);
        return ["Error interno del servidor", 500];
    }
};

  putAsync = async (body) => {
    try {
      const sql1 = `SELECT id from provinces WHERE id=$1`;
      const valuesID = [parseInt(body.id)];
      const resultID = await client.query(sql1, valuesID);

      if (resultID.rows.length === 0) {
        return ["Provincia no encontrada", 404];
      }

      const sql2 = `UPDATE provinces
                              SET name = $1,
                                  full_name = $2,
                                  latitude = $3,
                                  longitude = $4,
                                  display_order = $5
                              WHERE id = $6`;

      const values = [
        body.name,
        body.full_name,
        body.latitude,
        body.longitude,
        body.display_order,
        body.id,
      ];
      const result = await client.query(sql2, values);

      if (body.name === "" || body.name.length <= 3) {
        return ["No cumple con las reglas de negocio", 400];
      }

      return ["Update", 200];
    } catch (error) {
      return [error.message, 400];
    }
  };

  deleateAsync = async (id) => {
    let resArray;
    const valuesID = [parseInt(id)];
    try {
      let sql2 = `DELETE FROM provinces WHERE id=$1`;
      let result = await client.query(sql2, valuesID);
      resArray = ["Provincia eliminada correctamente", 200];
    } catch (error) {
      resArray = ["Provincia no encontrada", 404];
      console.log(error);
    }

    return resArray;
  };

  getLocationsByProvinceId = async (provinceId)=> {
    try {
        const query = 'SELECT * FROM locations WHERE id_province = $1';
        const result = await client.query(query, [provinceId]);

        if (result.rows.length === 0) {
            return null;
        }

        return result.rows;
    } catch (error) {
        console.error('Error fetching locations:', error);
        throw error;
    }
}

}


