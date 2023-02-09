import { AuthService } from 'src/app/services/auth.service';
import { Router } from '@angular/router';
import { Component } from '@angular/core';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent {

constructor(
private authservice : AuthService,
private router : Router

){}


onLogout(){
  console.log('it logs us out');
}

}
