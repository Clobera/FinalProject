import { AuthService } from 'src/app/services/auth.service';
import { User } from './../models/user';
import { Component } from '@angular/core';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent {
  constructor(private auth: AuthService) {}
  user: User = new User();


  register(user: User) {

  }
}
