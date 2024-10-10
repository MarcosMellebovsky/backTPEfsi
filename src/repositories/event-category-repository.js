import pkg from "pg";

import config from "../configs/db-config.js";
const { Client } = pkg;
const client = new Client(config);

await client.connect();
export default class EventCategoryService {
  getAllAsync = async () => {
    let sql = `SELECT * from event_categories`;
    let result = await client.query(sql);
    const eventCategorys = result.rows;
    return eventCategorys;
  };
  getByIdAsync = async (id) => {
    let sql = `SELECT * from event_categories WHERE id=$1`;
    const values = [id];
    let result = await client.query(sql, values);
    const eventCategorys = result.rows;
    return eventCategorys;
  };
  createAsync = async (body) => {
    try {



      if (body.name === "" || body.name.length <= 3) {
        return [
          "El nombre (name) está vacío o tiene menos de tres (3) letras.",
          400,
        ]}

      const sql1 = `SELECT id FROM public.event_categories ORDER BY id DESC limit 1;`;
      let result1 = await client.query(sql1);
      let obj = result1.rows[0];
      let id = obj.id + 1;
      let nombre = body.name;
      let display_order = body.display_order;


      
      const sql = `
            INSERT INTO event_categories
                (id,name,display_order)
            VALUES
                ($1,$2,$3)`;
      const values = [id, nombre, parseInt(display_order)];
      const result = await client.query(sql, values);
      return ["created", 200];

    
    } catch (error) {
      return [error, 404];
    }
  };
  putAsync = async (body) => {
    try {
      const sql1 = `SELECT id from event_categories WHERE id=$1`;
      const valuesID = [parseInt(body.id)];
      const resultID = await client.query(sql1, valuesID);

      if (resultID.rows.length === 0) {
        return ["Categoria de evento no encontrada", 404];
      }

      

      if (body.name === "" || body.name.length <= 3) {
        return [
          "El nombre (name) está vacío o tiene menos de tres (3) letras.",
          400,
        ];
      }
      else{
        const sql2 = `UPDATE event_categories
                          SET name = $1,
                              display_order = $2
                          WHERE id = $3`;

      const values = [body.name, parseInt(body.display_order), parseInt(valuesID)];
      const result = await client.query(sql2, values);
      return ["Update", 200];
      }

    } catch (error) {
      return [error.message, 400];
    }
  };

  deleateAsync = async (id) => {
    let resArray;
    const valuesID = [parseInt(id)];
    try {
      
      const sql5 = `SELECT id from event_categories WHERE id=$1`;
      const valuesID = [parseInt(id)];
      const resultID = await client.query(sql5, valuesID);

      if (resultID.rows.length === 0) {
        return ["Categoria de evento no encontrada", 404];
      } 
      else{
       
      let sql3 = `UPDATE events
        SET id_event_category = null
        WHERE id = $1`;
        let result3 = await client.query(sql3, valuesID);

      let sql2 = `DELETE FROM event_categories WHERE id=$1`;
      let result = await client.query(sql2, valuesID);
      resArray = ["Categoria de evento eliminada correctamente", 200];
       
    }
    } catch (error) {
      resArray = ["Error", 404];
      console.log(error);
    }

    return resArray;
  };
}
