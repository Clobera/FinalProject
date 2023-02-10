import { User } from "./user";

export class Post {
id: number;
user: User;
content: string;
imageUrl: string;
postDate: Date;
enabled: boolean;
comments: Array<Comment>;

constructor(
  id: number = 0,
  user: User = new User(),
  content: string = "",
  imageUrl: string = "",
  postDate: Date = new Date(),
  enabled: boolean = false,
  comments: Array<Comment> = []

){

  this.id = id;
  this.user = user;
  this.content = content;
  this.imageUrl = imageUrl;
  this.postDate = postDate;
  this.enabled = enabled;
  this.comments = comments;




}

















}
