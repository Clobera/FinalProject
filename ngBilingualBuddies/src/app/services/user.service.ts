import { AuthService } from 'src/app/services/auth.service';
import { environment } from './../../environments/environment.development';
import { User } from './../models/user';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, Observable, throwError } from 'rxjs';
import { Language } from '../models/language';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  url = environment.baseUrl + "api/users";
  constructor(private httpClient : HttpClient, private auth : AuthService) { }

  index(): Observable<User[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.httpClient.get<User[]>(this.url, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error(
              'LanguageService.index(): error retrieving Languages: ' + err
            )
        );
      })
    );
  }

}
