import { LanguageService } from 'src/app/services/language.service';
import { Language } from 'src/app/models/language';
import { UserService } from 'src/app/services/user.service';
import { AuthService } from 'src/app/services/auth.service';
import { Component } from '@angular/core';
import { User } from 'src/app/models/user';
import { ActivatedRoute, Router } from '@angular/router';
import { Country } from 'src/app/models/country';
import { Observable } from 'rxjs/internal/Observable';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.css'],
})
export class AccountComponent {
  constructor(
    private auth: AuthService,
    private route: ActivatedRoute,
    private router: Router,
    private userService: UserService,
    private langServ: LanguageService
  ) {}
  user = new User();
  editUser: User | null = null;
  users: User[] = [];
  test = 0;
  selected: null | User = null;
  showForm: boolean = false;
  addedLanguage = true;
  currLangId = 0;
  languages: Language[] = [];
  remove: boolean = false;

  // country: String = this.user.originCountry.country;
  showDate() {
    let date = this.user.dateCreated;
    console.log(date);
    return new Date(date).valueOf();
  }
  ngOnInit(): void {
    let username = this.route.snapshot.paramMap.get('username');
    // idString is getting the username we pass in
    if (username) {
      //if the is found, we assign it to the var username
      if (typeof username !== undefined) {
        // if there is a username value
        this.userService.show(username).subscribe({
          next: (user) => {
            this.selected = user;
            // we will call the show method and assign method to user
          },
          error: (fail) => {
            console.error(fail);
            this.router.navigateByUrl('UserNotFound');
          },
        });
      } else {
        this.router.navigateByUrl('invalidUserId');
      }
    }
    this.loadUser();
    this.loadLanguages();
  }
  loadUser() {
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
        this.test = this.showDate();
      },
      error: (err) => {
        console.log('NavbarCompenent.loadUser: Error getting user');
        console.log(err);
      },
    });
  }
  reload() {
    this.userService.index().subscribe({
      next: (users) => {
        this.users = users;
      },
      error: (oopsie) => {
        console.error('UserComponent.reload: error retrieving user');
        console.error(oopsie);
      },
    });
  }

  update(user: User, username: string): void {
    if (!this.addedLanguage) {
      this.user.languages.push(this.languages[this.currLangId - 1]);
      this.addedLanguage = true;
    }

    this.userService.update(user, username).subscribe({
      next: (result) => {
        this.editUser = null;
        this.selected = user;
        this.loadUser();
        this.showForm = false;
      },
      error: (nojoy) => {
        console.error('UserListComponent.updateUser(): error updating User: ');
        console.error(nojoy);
      },
    });
  }

  destroy(username: string, user: User): Observable<void> | void {
    this.userService.destroy(username, user).subscribe({
      next: (result) => {
        this.loadUser();
        this.showForm = false;
      },
      error: (nojoy) => {
        console.error('UserListComponent.updateUser(): error deleting User: ');
        console.error(nojoy);
      },
    });
  }

  setEditUser(): void {
    this.editUser = Object.assign({}, this.selected);
  }

  loadLanguages() {
    this.langServ.index().subscribe({
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

  addLanguage() {
    this.addedLanguage = false;
  }

  removeLanguage(index :number){
    this.remove = false;
    console.log(index);
    this.user.languages.splice(index, 1);
    console.log(this.languages);

    this.update(this.user, this.user.username);
  }
}
