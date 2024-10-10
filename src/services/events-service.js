import EventRepository from '../repositories/event-repository.js';
import jwt from "jsonwebtoken";
const secretKey = "ClaveSecreta3000$";

export default class EventService {

  searchAsync = async (params) => {
    const repo = new EventRepository();

    const arrayEventos = await repo.searchAsync(params);
    let resArray;
    if (arrayEventos != '') {
      resArray = [arrayEventos, 200];
    } else {
      resArray = ["No se encuentran eventos", 404];
    }
    return resArray;
  }

    getByIdAsync = async (id) => {
        const repo = new EventRepository();
        const arrayEventos = await repo.getByIdAsync(id);
        console.log(arrayEventos)
            if (arrayEventos && Object.keys(arrayEventos).length !== 0) {
            return [arrayEventos, 200];
        } else {
            return ["Evento no encontrado", 404];
        }
    }
  

  searchEnrollments = async (eventId, params) => {
    const repo = new EventRepository();
    const enrollments = await repo.searchEnrollments(eventId, params);
    let resArray;
    if (enrollments.collection.length > 0) {

      resArray = [enrollments, 200];;
    } else {
      resArray = ["Participante no encontrado", 404];
    }
    return resArray;

  };

  createAsync = async (body, token) => {
    const repo = new EventRepository();
    let resArray = repo.createAsync(body, token);
    return resArray;
  }

  UpdateAsync = async (body, token) => {
    const repo = new EventRepository();
    let restArray
    if (body.id) {

      return repo.updateAsync(body.id, body, token);
    } else {
      resArray = ["Id missing", 404];

      return restArray;
    }
  }

  deleteEvent = async (id, token) => {
    const repo = new EventRepository();

    try {
      if (!token) {
        return { success: false, status: 401, message: "Unauthorized. Token missing." };
      }

      let payloadOriginal;
      try {
        payloadOriginal = jwt.verify(token, secretKey);
      } catch (error) {
        console.error("Error verifying JWT:", error);
        return { success: false, status: 401, message: "Unauthorized. Invalid token." };
      }

      const idCreatorUser = await repo.checkEventExistence(id);
      if (!idCreatorUser) {
        return { success: false, status: 404, message: `Event with ID ${id} not found` };
      }

      if (idCreatorUser !== payloadOriginal.id) {
        return { success: false, status: 401, message: "Unauthorized. Event does not belong to authenticated user." };
      }

      const registeredUsersCount = await repo.checkRegisteredUsers(id);
      if (registeredUsersCount > 0) {
        return { success: false, status: 400, message: "There are registered users for this event" };
      }

      const deletionSuccessful = await repo.deleteEvent(id);
      if (!deletionSuccessful) {
        return { success: false, status: 404, message: `Event with ID ${id} not found` };
      }

      return { success: true, status: 200, message: "Event deleted successfully" };
    } catch (error) {
      console.error("Error in event service:", error);
      return { success: false, status: 500, message: "Internal server error" };
    }
  }



  addEnrollmentOfUser = async (id) => {
    const repo = new EventRepository();
    const result = await repo.addEnrollmentOfUser(id)
    return result;

  }

  deleteEnrollmentOfUser = async (eventId) => {
    const repo = new EventRepository();
    const result = await repo.deleteEnrollmentOfUser(eventId)
    return result;
  }

  ratingEnrollment = async (eventId, eventRating, bodyDesc) => {
    const repo = new EventRepository();
    const enrollments = await repo.ratingEnrollments(eventId, eventRating, bodyDesc);
    return enrollments;
  };

}
