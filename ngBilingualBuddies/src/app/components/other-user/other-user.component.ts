import { AuthService } from 'src/app/services/auth.service';
import { AlertService } from './../../services/alert.service';
import { UserService } from 'src/app/services/user.service';
import { ActivatedRoute } from '@angular/router';
import { Component } from '@angular/core';
import { User } from 'src/app/models/user';
import { Alert } from 'src/app/models/alert';

@Component({
  selector: 'app-other-user',
  templateUrl: './other-user.component.html',
  styleUrls: ['./other-user.component.css']
})
export class OtherUserComponent {
constructor(private route : ActivatedRoute, private userService : UserService, private alertService : AlertService, private auth : AuthService) {}

username = '';
user = new User();
test = 0;
friend = false;
loggedInUser = new User();

ngOnInit(){
  this.route.params.subscribe( params => this.username = params['id']);
  console.log(this.username);
  this.loadUser();
  this.loadLoggedInUser();

}

loadLoggedInUser (){
  this.auth.getLoggedInUser().subscribe({
    next: (data) => {
      this.loggedInUser = data;
    },
    error: (err) => {
      console.log(
        'OtherUserComponent.loadUser: Error loading user ' + err
      );
    }
  })
}

loadUser(){
  this.userService.show(this.username).subscribe({
    next: (data) => {
      this.user = data;
    },
    error: (err) => {
      console.log(
        'OtherUserComponent.loadUser: Error loading user ' + err
      );
    }
  })
}
addFriend(){
let alert = new Alert();
alert.receiver = this.user;
alert.sender =  this.loggedInUser;
alert.content = "New Friend Request From: " + this.loggedInUser.firstName + " " + this.loggedInUser.lastName + "."

console.log(alert.receiver);

  this.alertService.create(alert).subscribe({
    next: (data) => {
      this.friend = true;
    },
    error: (err) => {
      console.log(
        'OtherUserComponent.addFriend: Error creating new alert ' + err
      );
    }
  })
}

}
