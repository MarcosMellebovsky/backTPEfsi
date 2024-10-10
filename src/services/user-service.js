import {UserRepository} from '../repositories/user-repository.js';
export default class UserService{
createAsync = async (body) => {
    const repo = new UserRepository();
    let resArray = repo.createAsync(body);
    return resArray;
}
logAsync = async (body) => {
    const repo = new UserRepository();
    let resArray = repo.logAsync(body);
    return resArray;
}
}