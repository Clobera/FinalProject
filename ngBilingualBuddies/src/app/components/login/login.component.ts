import { User } from './../../models/user';
import { Observable } from 'rxjs';
import { UserService } from './../../services/user.service';
import { Router, RouterModule } from '@angular/router';
import { Component } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {

  constructor(private router : Router, private authService : AuthService){}
  username : string = "";
  password : string = "";


  register() {
    this.router.navigateByUrl("register");
  }

  login(username : string, password: string) {
    this.username = "";
    this.password = "";
    this.authService.login(username, password).subscribe({
      next: (data) => {
        this.router.navigateByUrl("home");
      },
      error: (err) => {
        console.log("Error LoginCompenent.login(): error logging in");

      }
    })
  }


}
