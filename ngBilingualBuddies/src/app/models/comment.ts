import { User } from "./user";

export class Comment {
id: number;
post: string;
//user User;
content: string;
commentDate: Date;
enabled: boolean;



constructor(
id: number = 0,
post: string = "",
//user: User = new User,
content: string = "",
commentDate: Date = new Date(),
enabled: boolean = false



){
this.id = id;
this.post = post;
this. content = content;
this.commentDate = commentDate;
this.enabled = enabled;


}
}
