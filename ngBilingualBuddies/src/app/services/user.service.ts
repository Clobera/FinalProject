import { AuthService } from 'src/app/services/auth.service';
import { environment } from './../../environments/environment';
import { User } from './../models/user';
import { HttpClient } from '@angular/common/http';
import { Injectable, Pipe } from '@angular/core';
import { catchError, Observable, throwError } from 'rxjs';
import { Language } from '../models/language';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  url = environment.baseUrl + "api/users";
  constructor(private http : HttpClient, private auth : AuthService) { }

  index(): Observable<User[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.http.get<User[]>(this.url, httpOptions).pipe(
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

  show(username: string): Observable<User> {
    return this.http.get<User>(`${this.url}/${username}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('UserService.show(): error retrieving user: ' + err)
        );
      })
    );
  }

  update(user: User, username: string): Observable<User> {
    return this.http.put<User>(`${this.url}/${username}`, user, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('UserService.update(): error updating user: ' + err)
        );
      })
    );
  }

  destroy(username: string, user: User): Observable<void>{
    if(user.role !== "admin" || user.username !== username){
      username = '';
    }
    return this.http.delete<void>(`${this.url}/${username}`, this.getHttpOptions());

  }





  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }




}
