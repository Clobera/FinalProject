import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {






  //METHODS
  constructor(private auth: AuthService){}

  ngOnInit(){
    this.tempTestDeleteMeLater(); //DELETE ME
  }

  tempTestDeleteMeLater(){
    this.auth.login('admin', 'wombat1').subscribe({
      next: (result) => {
        console.log('LOGGED IN :D');
        console.log(result);

      },
      error: (ugh) => {
        console.error('ERROR AUTHENTICATING:');
        console.error(ugh);

      }
    });
  }

}
