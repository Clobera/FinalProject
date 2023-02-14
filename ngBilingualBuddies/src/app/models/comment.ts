import { Post } from "./post";
import { User } from "./user";

export class Comment {
id: number;
post: Post;
user: User;
content: string;
commentDate: Date;
enabled: boolean;



constructor(
id: number = 0,
post: Post = new Post(),
user: User = new User(),
content: string = "",
commentDate: Date = new Date(),
enabled: boolean = true



){
this.id = id;
this.post = post;
this.content = content;
this.commentDate = commentDate;
this.enabled = enabled;
this.user = user;

}
}
