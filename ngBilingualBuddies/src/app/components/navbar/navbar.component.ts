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
  constructor(private authservice : AuthService, private router : Router){}

  loggedIn(){
return this.authservice.checkLogin();
}

onLogout(){
  this.authservice.logout();
  localStorage.removeItem('user');
this.router.navigate(['/home']);
}

}
