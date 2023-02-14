import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Comment } from 'src/app/models/comment';
import { Post } from 'src/app/models/post';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { CommentService } from 'src/app/services/comment.service';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css']
})
export class CommentComponent {

  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private commentService: CommentService
  ){}


  comment = new Comment();
  editComment: Comment | null = null;
  comments: Comment[] = [];
  newComment: Comment = new Comment();
  user = new User();

  ngOnInit(): void{
    this.loadUser();
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

  create(comment: Comment, post: Post){
    comment.user = this.user
    this.commentService.create(comment, post).subscribe({
      next: (result) =>{
        this.newComment = new Comment();
        // this.reload();
      },
      error: (error) =>{
        console.error("Error creating Comment");
        console.error(error);
      }
    });
  }

  deletePost(id: number, comment: Comment){
    if(comment.user === this.user){
  this.commentService.destroy(id).subscribe({
    next: () => {
      // this.reload();
    },
    error: (fail) => {
      console.error(' Error deleting comment');
      console.error(fail);
    },
  });
}
}

reload(){
  // this.commentService.index().subscribe({
  //   next: (comments) =>{
  //     this.comments = comments;
  //   },
  //   error:(oops) => {
  //     console.error("Error retrieving comments");
  //     console.error(oops);
  //   }
  // });
}
styleUserComments(){
  let num = this.getNumberOfComments();
  if(num > 10){
    return 'bg-success';
  } else if( num >= 5){
    return 'bg-warning';
  } else {
    return 'bg-danger';
  }
}
getNumberOfComments(){
  return this.comments.length;
}

}
