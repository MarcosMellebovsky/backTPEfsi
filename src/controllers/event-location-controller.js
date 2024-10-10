import { Router } from 'express';
import EventLocationService from '../services/event-location-service.js'

const router = Router();
const svc = new EventLocationService();


router.get('', async(req, res) => {
    const resArray = await svc.getAllAsync();
    res.status(resArray[1]).send(resArray[0]);
});

router.get('/:id', async (req, res) => {
    const id = req.params.id;
    const resArray = await svc.getByIdAsync(id);
    console.log(resArray)
    res.status(resArray[0][1]).send(resArray[0][0]);
    
});

router.post('', async(req, res) => {
    const body = req.body;
    const resArray = await svc.createAsync(body);
    res.status(resArray[1]).send(resArray[0]);
});
router.put('', async(req, res) => {
    const body = req.body;
    const token = req.headers.authorization && req.headers.authorization.split(' ')[1]; 

    const resArray = await svc.putAsync(body,token);
    res.status(resArray[1]).send(resArray[0]);
});
router.delete('/:id', async (req, res) => {
    const id = req.params.id;
    const resArray = await svc.deleteAsync(id);
    res.status(resArray[1]).send(resArray[0]);
    
});
export default router;