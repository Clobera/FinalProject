import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { User } from '../../models/user';
import { Component } from '@angular/core';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent {
  constructor(private auth: AuthService, private router : Router) {}
  user: User = new User();

  // class variable to implement form control later
  fnameClass = 'form-control';
  lnameClass = 'form-control';
  passwordClass = 'form-control';
  emailClass = 'form-control';
  usernameClass = 'form-control';

  register(user: User) {
    this.auth.register(user).subscribe({
      next: (data) => {
        this.login(this.user);
      },
      error: (err) => {
        console.log("ERROR RegisterComponent.register(): Error registering new user");
      }
    })
  }
  login(user : User){
    this.auth.login(user.username, user.password).subscribe({
      next: (data) => {
        this.user = new User();
        this.router.navigateByUrl("home");
      },
      error: (err) => {
        console.log("ERROR RegisterComponent.login(): Error logging  in new user");
      }
    })
  }
}
