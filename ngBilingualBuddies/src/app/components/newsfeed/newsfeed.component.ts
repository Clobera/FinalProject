import { PostService } from './../../services/post.service';
import { Post } from './../../models/post';
import { AuthService } from 'src/app/services/auth.service';
import { Component } from '@angular/core';
import { User } from 'src/app/models/user';
import { Comment } from 'src/app/models/comment';
import { CommentService } from 'src/app/services/comment.service';

@Component({
  selector: 'app-newsfeed',
  templateUrl: './newsfeed.component.html',
  styleUrls: ['./newsfeed.component.css']
})
export class NewsfeedComponent {
  posts : Post[] = [];
selected: null | Post = null;
comments: Comment[] = [];
newComment = new Comment();
user= new User();





constructor(private auth: AuthService, private postServ : PostService, private commentService: CommentService){}

 ngOnInit(){
    this.loadPosts();
 }

 loadUser(){
    this.auth.getLoggedInUser().subscribe({
    next: (data) => {
      this.user = data;
    },
    error: (err) => {
      console.log(
        'NavbarCompenent.loadUser: Error getting user'
      );
      console.log(err);
    }
  });
  }

 loadPosts() {
  this.postServ.index().subscribe({
    next: (data) => {
      this.posts = data;
    },
    error: (err) => {
      console.log(
        'NewsFeedComponent.loadLoggedInUser: Error loading user' + err
      );
    },
  })
 }



showPost(post: Post) {
  this.selected = post;
}

reload(post: Post){
  this.commentService.index(post).subscribe({
    next: (comments) =>{
      this.comments = comments;
    },
    error:(oops) => {
      console.error("Error retrieving comments");
      console.error(oops);
    }
  });
}

create(comment: Comment, post: Post){
    this.commentService.create(comment, post).subscribe({
      next: (result) =>{
        this.newComment = new Comment();
        this.reload(post);
      },
      error: (error) =>{
        console.error("Error creating Comment");
        console.error(error);
      }
    });
  }




}
