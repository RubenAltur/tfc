import fs from "fs";

export let carrefour = JSON.parse(fs.readFileSync("./models/carrefour.json","utf-8"));
export let mercadona = JSON.parse(fs.readFileSync("./models/mercadona.json","utf-8"));
export let masymas = JSON.parse(fs.readFileSync("./models/masymas.json","utf-8"));


export function getCarrefour(){
    let llista_carrefour = [];
    for (let producte of carrefour)
        llista_carrefour.push({"Producte":producte.Producte, "Cantitat":producte.Cantitat, "Preu":producte.Preu});
    return llista_carrefour;
}

export function getMercadona(){
    let llista_mercadona = [];
    for (let producte of mercadona)
        llista_mercadona.push({"Producte":producte.Producte, "Cantitat":producte.Cantitat, "Preu":producte.Preu});
    return llista_mercadona;
}

export function getMasymas(){
    let llista_masymas = [];
    for (let producte of masymas)
        llista_masymas.push({"Producte":producte.Producte, "Cantitat":producte.Cantitat, "Preu":producte.Preu});
    return llista_masymas;
}

