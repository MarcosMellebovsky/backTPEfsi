import LocationRepository from '../repositories/location-repository.js';
export default class LocationService{
    getAllAsync = async () => {
        const repo = new LocationRepository();
        const arrayLocation= await repo.getAllAsync();
        let resArray;
        if(arrayLocation != ''){
            resArray = [arrayLocation, 200];
        }
        else{
            resArray = ["No se encuentran locations", 404]
        }
        return resArray; 
    }

    getByIdAsync = async (id) =>{
        const repo = new LocationRepository();
        let arrayLocation= await repo.getByIdAsync(id);
        let resArray;
        if (arrayLocation != '') {
            
            resArray = [arrayLocation,200];;
        } else {
            resArray = ["Ubicacion no encontrada",404];
        }
        return resArray;
    }
    getLocationByIdAsync = async (id) =>{
        const repo = new LocationRepository();
        const resArray= await repo.getLocationByIdAsync(id);
        return resArray;
    }

       
}