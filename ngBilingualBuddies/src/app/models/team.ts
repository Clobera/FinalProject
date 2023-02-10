import { Meetup } from "./meetup";
import { User } from "./user";

export class Team {
id: number;
owner: User;
content: string;
imageUrl: string;
name: string;
createdAt: Date;
enabled: boolean;
meetups: Array<Meetup>;
members: Array<User>;



constructor(
  id: number = 0,
  owner: User = new User(),
  content: string = "",
  imageUrl: string = "",
  name: string = "",
  createdAt: Date = new Date(),
  enabled: boolean = false,
  meetups: Array<Meetup> = [],
  members: Array<User> = []

  ){

    this.id = id;
    this.owner = owner;
    this.content = content;
    this.imageUrl = imageUrl;
    this.name = name;
    this.createdAt = createdAt;
    this.enabled = enabled;
    this.meetups = meetups;
    this.members = members;



}











}
