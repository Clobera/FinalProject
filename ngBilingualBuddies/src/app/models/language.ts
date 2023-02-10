import { Country } from "./country";
import { User } from "./user";
import { LanguageResource } from "./language-resource";
export class Language {
id: number;
name: string;
description: string;
resources: Array<LanguageResource>;
users: Array<User>;
countries: Array<Country>;

constructor(
id: number = 0,
name: string = "",
description: string = "",
resources: Array<LanguageResource> = [],
users: Array<User> = [],
countries: Array<Country> = []

){

this.id = id;
this.name = name;
this.description = description;
this.resources = resources;
this.users = users;
this.countries = countries;



}

}
