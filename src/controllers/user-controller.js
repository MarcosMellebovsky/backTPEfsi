import { Router } from 'express';
import UserService from '../services/user-service.js'

const router = Router();
const svc = new UserService();


router.post('/register', async(req, res) => {
    const body = req.body;
    const resArray = await svc.createAsync(body);
    res.status(resArray[1]).send(resArray[0]);
});
router.post('/login', async(req, res) => {
    const body = req.body;
    const resArray = await svc.logAsync(body);
    res.status(resArray[1]).send(resArray[0]);
});

export default router;