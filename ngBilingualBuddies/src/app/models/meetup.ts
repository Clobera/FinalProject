import { getLocaleTimeFormat, Time } from "@angular/common";
import { timestamp, VirtualTimeScheduler } from "rxjs";
import { Address } from "./address";
import { Alert } from "./alert";
import { Team } from "./team";
import { User } from "./user";

export class Meetup {

id: number;
meetupDate: Date;
content: string;
address: Address;
enabled: boolean;
owner: User;
team: Team;
attendees: Array<User>;
startTime: Date;
endTime: Date;
createdDate: Date;
imgUrl: string;
title: string;
alerts: Array<Alert>;

constructor(
  id: number = 0,
  meetupDate: Date = new Date(),
  content: string = "",
  address: Address = new Address(),
  enabled: boolean = false,
  owner: User = new User(),
  team: Team = new Team(),
  attendees: Array<User> = [],
  startTime: Date = new Date(),
  endTime: Date = new Date(),
  createdDate: Date = new Date(),
  imgUrl: string = "",
  title: string = "",
  alerts: Array<Alert> = []

  ){
    this.id = id;
    this.meetupDate = meetupDate;
    this.content = content;
    this.address = address;
    this.enabled = enabled;
    this.owner = owner;
    this.team = team;
    this.attendees = attendees
    this.startTime = startTime;
    this.endTime = endTime;
    this.createdDate = createdDate;
    this.imgUrl = imgUrl;
    this.title = title;
    this.alerts = alerts;



}
}
