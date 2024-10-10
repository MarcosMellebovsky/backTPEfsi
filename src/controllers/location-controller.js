import { Router } from 'express';
import LocationService from '../services/location-service.js'

const router = Router();
const svc = new LocationService();


router.get('', async(req, res) => {
    const resArray = await svc.getAllAsync();
    res.status(resArray[1]).send(resArray[0]);
});

router.get('/:id', async (req, res) => {
    let id = req.params.id;
    let resArray = await svc.getByIdAsync(id);
    res.status(resArray[1]).send(resArray[0]);
    
});
router.get('/:id/event-location', async (req, res) => {
    const id = req.params.id;
    const resArray = await svc.getLocationByIdAsync(id);
    res.status(resArray[1]).send(resArray[0]);
});

export default router;