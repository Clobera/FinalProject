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
  ngOnInit(){
    this.loadUser();
  }
  user = new User();
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



}
