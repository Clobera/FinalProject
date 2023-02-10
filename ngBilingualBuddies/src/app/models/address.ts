import { Meetup } from "./meetup";
import { User } from "./user";

export class Address {
id: number;
address: string;
city: string;
state: string;
postalCode: string;
enabled: boolean;
user: User;
meetup: Meetup;
meetups: Meetup;







constructor(

  id: number = 0,
  address: string = "",
  city: string = "",
  state: string = "",
  postalCode: string = "",
  enabled: boolean = false,
  user: User = new User(),
  meetup: Meetup = new Meetup(),
  meetups: Meetup = new Meetup()


){
this.id = id;
this.address = address;
this.city = city;
this.state = state;
this.postalCode = postalCode;
this.enabled = enabled;
this.enabled = enabled;
this.user = user;
this.meetup = meetup;
this.meetups = meetups;






}



}
