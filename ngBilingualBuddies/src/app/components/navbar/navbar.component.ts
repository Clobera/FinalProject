import { Router } from '@angular/router';
import { AuthService } from './../../services/auth.service';
import { Component, Input } from '@angular/core';


@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.component.html',

  styleUrls: ['./navbar.component.css']
})
export class NavbarComponent {
  collapsed = true;
  @Input() loggedIn = this.authservice.checkLogin();
  toggleCollapsed(): void {
    this.collapsed = !this.collapsed;

  }
  constructor(private authservice : AuthService, private router : Router){
  }

onLogout(){
  this.authservice.logout();
this.router.navigate(['/home']);
this.loggedIn = this.checkLogin();
}

checkLogin(){
  return this.authservice.checkLogin();
}


}
