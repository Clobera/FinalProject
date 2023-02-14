import { Meetup } from './meetup';
import { User } from 'src/app/models/user';
export class Alert {

  id : number;
  sender : User;
  receiver: User;
  meetup: Meetup | null;
  content: string;
  notificationDate: Date | null | undefined;
  seen: boolean;

  constructor(
    id : number = 0,
    sender : User = new User(),
    receiver: User = new User(),
    meetup: Meetup = new Meetup(),
    content: string = '',
    notificationDate: Date | null = null,
    seen: boolean = true
  ) {
    this.id  = id;
  this.sender  = sender;
  this.receiver = receiver;
  this.meetup = meetup;
  this.content = content;
  this.notificationDate = notificationDate;
  this.seen = seen;
  }
}
