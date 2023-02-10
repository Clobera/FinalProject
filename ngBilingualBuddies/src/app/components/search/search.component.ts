import { UserLanguagePipe } from './../../pipes/user-language.pipe';
import { EnabledUsersPipe } from './../../pipes/enabled-users.pipe';
import { UserService } from './../../services/user.service';
import { Language } from './../../models/language';
import { Component } from '@angular/core';
import { LanguageService } from 'src/app/services/language.service';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css'],
})
export class SearchComponent {
  sponsor = false;
  languages: Language[] = [];
  currLangId: string = '1';
  showName = false;
  showLoc = true;
  searchName = '';
  searchLocation = '';
  users: User[] = [];

  switch() {
    this.showName = !this.showName;
    this.showLoc = !this.showLoc;
    this.users = [];
  }

  constructor(
    private langServ: LanguageService,
    private userServ: UserService,
    private enabledUser: EnabledUsersPipe,
    private lang: UserLanguagePipe
  ) {}

  ngOnInit() {
    this.loadLanguages();
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

  searchByName(searchName: string) {}
  searchByLocation(searchLocation: string) {
    console.log('Loc');
  }

  loadUsers(num: number, input: string) {
    this.userServ.index().subscribe({
      next: (data) => {
        this.filterByEnabledAndLanguage(data);
        if (num == 1) {
          this.searchByName(input);
        } else if (num == 2) {
          this.searchByLocation(input);
        }
      },
      error: (err) => {
        console.log(
          'SearchComponent.loadLanguages: Error loading languages ' + err
        );
      },
    });
  }

  filterByEnabledAndLanguage(data: User[]) {
    console.log(data);

    let enabled = this.enabledUser.transform(data);
    console.log(enabled);
    this.users = this.lang.transform(enabled, this.currLangId);
    console.log(this.users);
    if (this.sponsor){
      // filter by sponsor
    }
  }






}
