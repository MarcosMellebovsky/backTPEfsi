import { Router } from 'express';
import ProvinceRepository from '../repositories/province-repository.js';
import ProvinceService from '../services/province-service.js'

const router = Router();
const svc = new ProvinceService();

//all
router.get('', async(req, res) => {
    const resArray = await svc.getAllAsync();
    res.status(resArray[1]).send(resArray[0]);
});
//id
router.get('/:id', async(req, res) => {
    
    const id = req.params.id;
    const resArray = await svc.getByIdAsync(id);
    res.status(resArray[1]).send(resArray[0]);
    
});
//subir provicia
router.post('', async(req, res) => {
    const body = req.body;
    const resArray = await svc.createAsync(body);
    res.status(resArray[1]).send(resArray[0]);
});
//eliminar provincia
router.delete('/:id', async(req, res) => {
    const id = req.params.id;
    const resArray = await svc.deleateAsync(id);
    res.status(resArray[1]).send(resArray[0]);
});
//modificar provincia
router.put('', async(req, res) => {
    const body = req.body;
    const resArray = await svc.putAsync(body);
    res.status(resArray[1]).send(resArray[0]);
});

//locations
router.get('/:id/locations', async (req, res) => {
    const provinceId = parseInt(req.params.id, 10);
    
    if (isNaN(provinceId)) {
        return res.status(400).json({ message: "ID de provincia inválido" });
    }

    const result = await svc.getLocationsByProvinceId(provinceId);

    res.status(result.status).json(result.data);
});


export default router;