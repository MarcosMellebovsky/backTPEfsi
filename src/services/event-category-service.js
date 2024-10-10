import EventCategoryRepository from "../repositories/event-category-repository.js";
export default class EventCategoryService {
  getAllAsync = async () => {
    const repo = new EventCategoryRepository();
    const arrayEventCategory = await repo.getAllAsync();
    let resArray;
    if (arrayEventCategory != "") {
      resArray = [arrayEventCategory, 200];
    } else {
      resArray = ["No se encuentran provincias", 404];
    }
    return resArray;
  };
  getByIdAsync = async (id) => {
    const repo = new EventCategoryRepository();
    const arrayEventCategory = await repo.getByIdAsync(id);
    let resArray;
    if (arrayEventCategory != "") {
      resArray = [arrayEventCategory, 200];
    } else {
      resArray = ["Provincia no encontrada", 404];
    }
    return resArray;
  };
  createAsync = async (body) => {
    const repo = new EventCategoryRepository();
    let resArray = repo.createAsync(body);
    return resArray;
  };
  putAsync = async (body) => {
    const repo = new EventCategoryRepository();
    let resArray = repo.putAsync(body);
    return resArray;
  };
  deleateAsync = async (id) => {
    const repo = new EventCategoryRepository();
    let resArray = repo.deleateAsync(id);
    return resArray;
  };
}
