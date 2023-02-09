import { SeenPipe } from './../../pipes/seen.pipe';
import { Router } from '@angular/router';
import { AuthService } from './../../services/auth.service';
import { Component, Input } from '@angular/core';
import { User } from 'src/app/models/user';


@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',

  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {
  collapsed = true;
  user = new User();
  alerts = this.seen.transform(this.user.alerts);


  constructor(private authservice : AuthService, private router : Router, private seen : SeenPipe){
  }
  toggleCollapsed(): void {
    this.collapsed = !this.collapsed;

  }

loggedInMethod(){
  return this.authservice.checkLogin();
}

onLogout(){
  this.authservice.logout();
this.router.navigate(['/home']);

}

}
