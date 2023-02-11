import { AuthService } from 'src/app/services/auth.service';
import { Language } from './../models/language';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { catchError, Observable, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LanguageService {
  url = environment.baseUrl + "api/languages"


  index(): Observable<Language[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.httpClient.get<Language[]>(this.url, httpOptions).pipe(
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

  indexNoCred(): Observable<Language[]> {
    let httpOptions = {
      headers: {
        Authorization: 'Basic ' + 'YWRtaW46d29tYmF0MQ==',
        'X-Requested-with': 'XMLHttpRequest',
      }
    };
    return this.httpClient.get<Language[]>(this.url, httpOptions).pipe(
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

  constructor(private httpClient : HttpClient, private auth : AuthService) { }
}
