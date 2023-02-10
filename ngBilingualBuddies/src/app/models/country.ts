import { Language } from "./language";
import { User } from "./user";

export class Country {
countryCode: string;
country: string;
users: Array<User>;
languages: Array<Language>;


constructor(
countryCode: string = "",
country: string = "",
users: Array<User> = [],
languages: Array<Language> = []



){
this.countryCode = countryCode;
this.country = country;
this.users = users;
this.languages = languages;






}

}
