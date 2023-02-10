import { Language } from "./language";
import { User } from "./user";

export class LanguageResource {
id: number;
name: string;
resourceUrl: string;
description: string;
language: Language;
createDate: Date;
addedBy: User;



constructor(
id: number= 0,
name: string = "",
description: string = "",
language: Language = new Language(),
resourceUrl: string = "",
addedBy: User = new User(),
createDate: Date = new Date()

){

this.id = id;
this.name = name;
this.description = description;
this.resourceUrl = resourceUrl;
this.language = language;
this.addedBy = addedBy;
this.createDate = createDate;


}


}
