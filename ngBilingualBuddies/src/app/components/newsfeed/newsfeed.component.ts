import { PostService } from './../../services/post.service';
import { Post } from './../../models/post';
import { AuthService } from 'src/app/services/auth.service';
import { Component } from '@angular/core';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-newsfeed',
  templateUrl: './newsfeed.component.html',
  styleUrls: ['./newsfeed.component.css']
})
export class NewsfeedComponent {
  posts : Post[] = [];

constructor(private postServ : PostService){}

 ngOnInit(){
    this.loadPosts();
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








}
