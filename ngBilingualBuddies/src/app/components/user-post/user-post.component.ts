import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Post } from 'src/app/models/post';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { PostService } from 'src/app/services/post.service';

@Component({
  selector: 'app-user-post',
  templateUrl: './user-post.component.html',
  styleUrls: ['./user-post.component.css']
})
export class UserPostComponent {
  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private postService: PostService
  ){}

post = new Post();
editPost: Post | null = null;
posts: Post[] = [];
selected: null | Post = null;
user = new User();
newPost: Post = new Post();



ngOnInit() : void{
  // this.loadUser();
}
// loadUser(){
//   this.auth.getLoggedInUser().subscribe({
//     next: (data) => {
//       this.user = data;
//     },
//     error: (err) => {
//       console.log(
//         'NavbarCompenent.loadUser: Error getting user'
//       );
//       console.log(err);
//     }
//   });
// }

// create(post: Post)  {
//   this.postService.create(post).subscribe({
//     next: (result) =>{
//       this.newPost = new Post();
//       this.reload();
//     },
//     error: (error) =>{
//       console.error("Error creating post");
//       console.error(error);
//     }
//   });
// }

// deletePost(id: number, post: Post){
//   this.postService.destroy(id).subscribe({
//     next: () =>{
//       this.reload();
//     },
//     error(fail) => {
//       console.console.error("Error deleting post");
//       console.error(fail);

//     }
//   })
// }

// reload(){
//   this.postService.index().subscribe({
//     next: (posts) =>{
//       this.posts = posts;
//     },
//     error:(oops) => {
//       console.error("Error retrieving posts");
//       console.error(oops);
//     }
//   });
// }


// }
}
