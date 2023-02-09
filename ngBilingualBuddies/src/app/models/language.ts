export class Language {
id: number;
name: string;
description: string;
resources: string;
//user:
countries: string;

constructor(
id: number = 0,
name: string = "",
description: string = "",
resources: string = "",
//user
countries: string = ""

){

this.id = id;
this.name = name;
this.description = description;
this.resources = resources;
//this.user
this.countries = countries;



}

}
