import { getCarrefour,getMasymas,getMercadona } from "../models/model.js";


export function obtindreCarrefour(req, res){
        res.send(getCarrefour());
}
export function obtindreMasymas(req, res){
    res.send(getMasymas());
}
export function obtindreMercadona(req, res){
    res.send(getMercadona());
}