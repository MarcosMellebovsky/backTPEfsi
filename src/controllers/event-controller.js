import { Router } from 'express';
import EventService from '../services/events-service.js'
import EventRepositoryverifyToken from '../repositories/event-repository.js'
const router = Router();
const svc = new EventService();


router.get('', async(req, res) => {
    const params = req.query;
    const resArray = await svc.searchAsync(params);
    res.status(resArray[1]).send(resArray[0]);
});

router.get('/:id', async(req, res) => {
    const id = req.params.id;
    const resArray = await svc.getByIdAsync(id);
    res.status(resArray[1]).send(resArray[0]);
    
});

router.get('/:id/enrollment', async(req, res) => {
    const eventId = req.params.id;
    const params = req.query;
    const resArray = await svc.searchEnrollments(eventId,params);
    res.status(resArray[1]).send(resArray[0]);
});

router.post('/:id/enrollment', async(req, res) => {
    const eventId = req.params.id;
    console.log(eventId)
    const resArray = await svc.addEnrollmentOfUser(eventId);
    res.status(resArray[1]).send(resArray[0]);
});


router.post('', async(req, res) => {
    const body = req.body;
    const token = req.headers.authorization && req.headers.authorization.split(' ')[1]; 
    const resArray = await svc.createAsync(body,token);
    res.status(resArray[1]).send(resArray[0]);
});


router.put('/', async (req, res) => {
    try {
        const token = req.headers.authorization && req.headers.authorization.split(' ')[1]; 
        const resArray = await svc.UpdateAsync(req.body,token);
        
        res.status(resArray[1]).send(resArray[0]);
    } catch (error) {
        console.error("Error en el controlador de eventos:", error);
        res.status(500).send("Error interno del servidor");
    }
});

router.delete('/:id', async (req, res) => {
    const eventId = req.params.id;
    const token = req.headers.authorization && req.headers.authorization.split(' ')[1];
  
    try {
      const result = await svc.deleteEvent(eventId, token);
  
      if (!result.success) {
        return res.status(result.status).json({ error: result.message });
      }
  
      return res.status(result.status).json({ message: result.message });
    } catch (error) {
      console.error("Error in event controller:", error);
      return res.status(500).json({ error: "Internal server error" });
    }
  });
  


router.patch('/:id/enrollment/:entero', async(req, res) => {
    const bodyDesc = req.body.observations;
    const eventId = req.params.id;
    const eventRating = req.params.entero;
    const resArray = await svc.ratingEnrollment(eventId,eventRating,bodyDesc);
    res.status(resArray[1]).send(resArray[0]);
})

router.delete('/:id/enrollment/', async(req,res) => {

    const eventId = req.params.id;
    console.log(eventId)
    const resArray = await svc.deleteEnrollmentOfUser(eventId);
    res.status(resArray[1]).send(resArray[0]);

} )
// router.get('/search', async (req, res) => {
//     const params = req.query;c
//     const resArray = await svc.searchAsync(params);
//     res.status(resArray[1]).send(resArray[0]);
// });

export default router;