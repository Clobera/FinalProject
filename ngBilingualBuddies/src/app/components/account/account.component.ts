import { AuthService } from 'src/app/services/auth.service';
import { Component } from '@angular/core';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.css']
})
export class AccountComponent {

  constructor(private auth: AuthService){

  }
  user = new User();
  test = 0;
  showDate(){
    let date = this.user.dateCreated;
    console.log(date);
    return new Date(date).valueOf();

  }
  ngOnInit(){
    this.loadUser();
  }
  loadUser(){
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
        this.test = this.showDate();
      },
      error: (err) => {
        console.log(
          'NavbarCompenent.loadUser: Error getting user'
        );
        console.log(err);
      }
    });
  }



}
