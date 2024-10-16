import pkg from "pg";
import jwt from "jsonwebtoken";
import config from "../configs/db-config.js";
const { Client } = pkg;
const client = new Client(config);

await client.connect();

let token = "";
export { token };

export class UserRepository {
  createAsync = async (body) => {
    try {
      let first_name = body.first_name;
      let last_name = body.last_name;
      let username = body.username;
      let password = body.password;

      // Obtener el último id
      const sql = `SELECT id FROM public.users ORDER BY id DESC limit 1;`;
      const result = await client.query(sql);
      let obj = result.rows[0];
      const id = obj.id + 1;

      // Validar correo y otros campos
      function validarEmail(username) {
        const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return regex.test(username);
      }
      
      if (first_name.length < 3 || last_name.length < 3) {
        return ["Nombre o apellido inválido", 400];
      } else if (!validarEmail(username)) {
        return ["Correo inválido", 400];
      } else if (password.length < 3) {
        return ["Contraseña inválida", 400];
      } else {
        // Insertar el usuario en la base de datos
        const sql = `
          INSERT INTO public.users
              (id, first_name, last_name, username, password)
          VALUES
              ($1, $2, $3, $4, $5)`;
        const values = [id, first_name, last_name, username, password];
        await client.query(sql, values);

        // Generar token JWT
        const payload = { id, username };
        const secretKey = "ClaveSecreta3000$";
        const options = { expiresIn: "2h", issuer: "miOrganizacion" };
        const token = jwt.sign(payload, secretKey, options);

        // Retornar el token y el estado exitoso
        return [{ success: true, message: "Usuario creado", token: token }, 201];
      }
    } catch (error) {
      console.error("Error:", error);
      return [{ success: false, message: "Error interno del servidor" }, 500];
    }
  };

  logAsync = async (body) => {
    function validarEmail(username) {
      const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
      return regex.test(username);
    }

    let username = body.username;
    let password = body.password;

    if (!validarEmail(username)) {
      return [
        { success: false, message: "El email es inválido", token: "" },
        400,
      ];
    }

    const sql = `SELECT * FROM public.users WHERE username = $1 AND password = $2`;
    const values = [username, password];

    try {
      const result = await client.query(sql, values);
      const usuarioDevuelto = result.rows[0]; // Obtenemos el primer resultado de la consulta

      if (usuarioDevuelto) {
        const payload = {
          id: usuarioDevuelto.id,
          username: usuarioDevuelto.username,
        };
        const secretKey = "ClaveSecreta3000$";
        const options = {
          expiresIn: "2h",
          issuer: "miOrganizacion",
        };
        const token = jwt.sign(payload, secretKey, options);

        return [{ success: true, message: "", token: token }, 200];
      } else {
        return [
          { success: false, message: "Usuario o clave inválida", token: "" },
          401,
        ];
      }
    } catch (error) {
      console.error("Error al ejecutar la consulta SQL:", error);
      return [
        { success: false, message: "Error en la base de datos", token: "" },
        500,
      ];
    }
  };
}
