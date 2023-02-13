import { AuthService } from 'src/app/services/auth.service';
import { Component } from '@angular/core';
import { User } from './models/user';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'BilingualBuddies';
  constructor(){}

}
