import { LanguageService } from 'src/app/services/language.service';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/services/auth.service';
import { User } from '../../models/user';
import { Component } from '@angular/core';
import { Language } from 'src/app/models/language';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
})
export class RegisterComponent {
  user: User = new User();
  languages: Language[] = [];
  currLangId: number = 0;

  constructor(private auth: AuthService, private router : Router, private langServ : LanguageService) {}
  ngOnInit(){
    this.loadLanguages();
  }

  register(user: User) {
    this.auth.register(user).subscribe({
      next: (data) => {
        console.log(data.languages[0]);
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

  loadLanguages() {
    this.langServ.indexNoCred().subscribe({
      next: (data) => {
        this.languages = data;
      },
      error: (err) => {
        console.log(
          'SearchComponent.loadLanguages: Error loading languages ' + err
        );
      },
    });
  }

}
