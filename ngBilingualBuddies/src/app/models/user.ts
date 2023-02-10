
import { Address } from "./address";
import { Alert } from "./alert";
import { Country } from "./country";
import { Language } from "./language";


export class User {
  id: number;
  email: string;
  username: string;
  password: string;
  dateCreated: Date;
  lastLogin: Date;
  enabled: boolean;
  role: string;
  sponsor: boolean;
  firstName: string;
  lastName: string;
  imgUrl: string;
  bio: string;
  address: Address;
  originCountry: Country;
  alerts: Array<Alert>;
  languages: Array<Language>;

  constructor(
    id: number = 0,
    email: string = '',
    username: string = '',
    password: string = '',
    dateCreated: Date = new Date(),
    lastLogin: Date = new Date(),
    enabled: boolean = true,
    role: string = '',
    sponsor: boolean = false,
    firstName: string = '',
    lastName: string = '',
    imgUrl: string = '',
    bio: string = '',
    address: Address = new Address(),
    originCountry: Country = new Country(),
    alerts: Array<Alert> = [],
    languages: Array<Language> = []



  ) {
    this.id = id;
    this.email = email;
    this.username = username;
    this.password = password;
    this.dateCreated = dateCreated;
    this.lastLogin = lastLogin;
    this.enabled = enabled;
    this.role = role;
    this.sponsor = sponsor;
    this.firstName = firstName;
    this.lastName = lastName;
    this.imgUrl = imgUrl;
    this.bio = bio;
    this.address = address;
    this.alerts = alerts;
    this.languages = languages;
    this.originCountry = originCountry;
  }
}
