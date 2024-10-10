import EventLocationRepository from '../repositories/event-location-repository.js';
export default class EventLocationService{
    getAllAsync = async () => {
        const repo = new EventLocationRepository();
        const resArray= await repo.getAllAsync();
        return resArray; 
    }

    getByIdAsync = async (id) =>{
        const repo = new EventLocationRepository();
        const arrayEventLocation= await repo.getByIdAsync(id);
        let resArray;
        if (arrayEventLocation != '') {
            
            resArray = [arrayEventLocation,200];;
        } else {
            resArray = ["Ubicacion no encontrada",404];
        }
        return resArray;
    }
    createAsync = async (body) => {
        const repo = new EventLocationRepository();
        let resArray = repo.createAsync(body);
        return resArray;
    };
    putAsync = async (body,token) => {
        const repo = new EventLocationRepository();
        let resArray = repo.putAsync(body,token);
        return resArray;
    };
    deleteAsync = async (id) =>{
        const repo = new EventLocationRepository();
        const resArray= await repo.deleteAsync(id);
        return resArray;
    }
    

       
}