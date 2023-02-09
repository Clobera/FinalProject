import { Router } from '@angular/router';
import { AuthService } from './../../services/auth.service';
import { Component } from '@angular/core';


@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',

  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {
  collapsed = true;
  toggleCollapsed(): void {
    this.collapsed = !this.collapsed;

  }
loggedIn(){
return this.auth.checkLogin();
}

logout(){
  this.auth.logout();
this.router.navigateByUrl("home");
}

constructor(private auth : AuthService, private router : Router){

}
}
