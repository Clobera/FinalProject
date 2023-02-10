import { Component } from "@angular/core";
import { Address } from "src/app/models/address";
import { Language } from "src/app/models/language";
import { User } from "src/app/models/user";
import { EnabledUsersPipe } from "src/app/pipes/enabled-users.pipe";
import { NameSearchPipe } from "src/app/pipes/name-search.pipe";
import { UserLanguagePipe } from "src/app/pipes/user-language.pipe";
import { UserSponsorPipe } from "src/app/pipes/user-sponsor.pipe";
import { AddressService } from "src/app/services/address.service";
import { LanguageService } from "src/app/services/language.service";
import { UserService } from "src/app/services/user.service";



@Component({
  selector: 'app-search',
  templateUrl: './search.component.html',
  styleUrls: ['./search.component.css'],
})
export class SearchComponent {
  sponsor = false;
  languages: Language[] = [];
  currLangId: string = '1';
  showName = true;
  showLoc = false;
  searchName = '';
  searchLocation = '';
  users: User[] = [];
  currCity = '';
  addresses : Address[] = [];


  constructor(
    private langServ: LanguageService,
    private userServ: UserService,
    private enabledUser: EnabledUsersPipe,
    private lang: UserLanguagePipe,
    private sponsorship: UserSponsorPipe,
    private nameSearch : NameSearchPipe,
    private addrServ : AddressService
  ) {}


  switchName() {
    this.showName = true;
    this.showLoc = false;
    this.emptyUsers();
  }
  switchLoc(){
    this.showLoc = true;
    this.showName = false;
    this.emptyUsers();
  }
  emptyUsers(){
    this.users = [];
  }

  ngOnInit() {
    this.loadLanguages();
    this.loadAddresses();
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

  searchByName(searchName: string) {
    this.users = this.nameSearch.transform(this.users, searchName);
  }
  searchByLocation(searchLocation: string) {
    console.log('Loc');
  }

  loadUsers(num: number, input: string) {
    this.userServ.index().subscribe({
      next: (data) => {
        this.filterByEnabledAndLanguageAndSponsor(data);
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

  filterByEnabledAndLanguageAndSponsor(data: User[]) {
    let enabled = this.enabledUser.transform(data);
    this.users = this.lang.transform(enabled, this.currLangId);
    if (this.sponsor){
      this.users = this.sponsorship.transform(this.users);
    }
  }

  loadAddresses() {
    this.addrServ.index().subscribe({
      next: (data) => {
        this.addresses = data;
      },
      error: (err) => {
        console.log(
          'SearchComponent.loadAddresses: Error loading Addresses ' + err
        );
      },
    });
  }




}
